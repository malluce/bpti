library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- represents a bomb,
entity bomb_ent is
	generic(TILE_SIZE_BOMB : integer);
	port(
		clk_bomb : in std_logic;
		rst_bomb : in std_logic;

		-- tile position of the player (will be position of planted bomb)
		col_player : in std_logic_vector(3 downto 0);
		row_player : in std_logic_vector(3 downto 0);

		-- controller input (low-active)
		plant_bomb : in std_logic;

		-- indicates whether the player is alive (bomb will not be planted if player is dead)
		enable_player : in std_logic;

		-- tile position of the bomb
		row_bomb : out std_logic_vector(3 downto 0);
		col_bomb : out std_logic_vector(3 downto 0);

		-- 1 while the bomb is planted and exploding
		enable_bomb : out std_logic;
		explode_bomb : out std_logic
		);
end bomb_ent;

architecture bomb_behav of bomb_ent is
	-- uncomment the next two lines and comment out the two after this for simulation purposes
	--constant EXPLOSION_MAX : integer range 0 to 12 := 12;
	--constant TICK_MAX : integer range 0 to 72 := 72;
	constant EXPLOSION_MAX : integer range 0 to 12000000 := 12000000; -- duration of explosion : approx 0.5 sec
	constant TICK_MAX : integer range 0 to 72000000 := 72000000; -- time until explosion : approx 3 sec
	shared variable bomb_set : std_logic := '0'; -- indicates whether the bomb is planted or not
	shared variable is_exploding : std_logic := '0'; -- indicates whether the bomb is exploding or not
begin

	-- handles the planting of a (new) bomb
	set_bomb : process(clk_bomb, rst_bomb)
		-- variables for tile position of the bomb (need to save it inside this entity for output because player tile position may change while bomb is planted)
		variable row_of_bomb : integer range 0 to 14 := 0;
		variable col_of_bomb : integer range 0 to 14 := 0;
	begin
		if(rst_bomb = '0') then
			bomb_set := '0';
			row_of_bomb := 0;
			col_of_bomb := 0;
		elsif(clk_bomb'event and clk_bomb = '1') then
			if((bomb_set = '1') and (is_exploding = '0') and (tick_cnt = TICK_MAX)) then -- disable bomb when it is exploded (allows to plant a new bomb)
				bomb_set := '0';
			elsif(plant_bomb = '0' and bomb_set = '0' and enable_player = '1') then -- enable bomb when no bomb is planted right now, player is alive and the plant button is pushed
				bomb_set := '1';
				row_of_bomb := to_integer(unsigned(row_player));
				col_of_bomb := to_integer(unsigned(col_player));
			end if;
			-- at every rising edge output state of the bomb
			enable_bomb <= bomb_set;
			row_bomb <= std_logic_vector(to_unsigned(row_of_bomb, 4));
			col_bomb <= std_logic_vector(to_unsigned(col_of_bomb, 4));
		end if;
	end process set_bomb;

	-- ticks down bomb and explosion when bomb is already planted
	bomb_tick : process(clk_bomb, rst_bomb)
		variable tick_cnt : integer range 0 to TICK_MAX := TICK_MAX; -- counter for planted bomb (if =0, then explode)
		variable explosion_cnt : integer range 0 to EXPLOSION_MAX := EXPLOSION_MAX; -- counter for exploding bomb (if = 0, then stop exploding)
	begin
		if(rst_bomb = '0') then
			tick_cnt := TICK_MAX;
			explosion_cnt := EXPLOSION_MAX;
			is_exploding := '0';
		elsif(clk_bomb'event and clk_bomb = '1') then
			explode_bomb <= is_exploding;
			if(bomb_set = '1') then -- just need to do sth. if bomb is active
				if(is_exploding = '0') then -- if bomb is not exploding, tick
					if(tick_cnt > 0) then
						tick_cnt := tick_cnt - 1;
					elsif(tick_cnt = 0) then -- bomb ticked down, now explode
						is_exploding := '1';
						tick_cnt := TICK_MAX;
					end if;
				elsif(is_exploding = '1') then -- if bomb is exploding, let it explode for a while
					if(explosion_cnt > 0) then
						explosion_cnt := explosion_cnt - 1;
					elsif(explosion_cnt = 0) then -- finished exploding
						is_exploding := '0';
						explosion_cnt := EXPLOSION_MAX;
					end if;
				end if;
			end if;
		end if;
	end process bomb_tick;

end bomb_behav;
