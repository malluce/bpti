library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bomb_ent is
	generic(TILE_SIZE_BOMB : integer);
	port(
		clk_bomb : in std_logic;
		rst_bomb : in std_logic;
		col_player : in std_logic_vector(3 downto 0);
		row_player : in std_logic_vector(3 downto 0);
		plant_bomb : in std_logic;
		row_bomb : out std_logic_vector(3 downto 0);
		col_bomb : out std_logic_vector(3 downto 0);
		enable_bomb : out std_logic;
		explode_bomb : out std_logic
		);
end bomb_ent;

architecture bomb_behav of bomb_ent is
	--constant EXPLOSION_MAX : integer range 0 to 12 := 12;
	constant EXPLOSION_MAX : integer range 0 to 12000000 := 12000000; -- duration of explosion : 0.5 sec
	--constant TICK_MAX : integer range 0 to 72 := 72;
	constant TICK_MAX : integer range 0 to 72000000 := 72000000; -- time until explosion : 3 sec
	shared variable bomb_set : std_logic := '0';
	shared variable tick_cnt : integer range 0 to TICK_MAX := TICK_MAX;
	shared variable is_exploding : std_logic := '0'; -- indicates whether the bomb is exploding or not
begin

	set_bomb : process(clk_bomb, rst_bomb)
	variable row_of_bomb : integer range 0 to 14 := 0;
	variable col_of_bomb : integer range 0 to 14 := 0;
	begin
		if(rst_bomb = '0') then
			bomb_set := '0';
			row_of_bomb := 0;
			col_of_bomb := 0;
		elsif(clk_bomb'event and clk_bomb = '1') then
			if((bomb_set = '1') and (is_exploding = '0') and (tick_cnt = 0)) then
				bomb_set := '0';
			end if;
			if(plant_bomb = '0' and bomb_set = '0') then -- just plant when no bomb is planted right now 
				bomb_set := '1';
				row_of_bomb := to_integer(unsigned(row_player));
				col_of_bomb := to_integer(unsigned(col_player));
			end if;
			enable_bomb <= bomb_set;
			row_bomb <= std_logic_vector(to_unsigned(row_of_bomb, 4));
			col_bomb <= std_logic_vector(to_unsigned(col_of_bomb, 4));
		end if;
	end process set_bomb;

	-- ticks down bomb and explosion when bomb is planted
	bomb_tick : process(clk_bomb, rst_bomb)
		variable explosion_cnt : integer range 0 to EXPLOSION_MAX := EXPLOSION_MAX;
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
