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
		row0_bomb : in std_logic_vector(59 downto 0);
		row1_bomb : in std_logic_vector(59 downto 0);
		row2_bomb : in std_logic_vector(59 downto 0);
		row3_bomb : in std_logic_vector(59 downto 0);
		row4_bomb : in std_logic_vector(59 downto 0);
		row5_bomb : in std_logic_vector(59 downto 0);
		row6_bomb : in std_logic_vector(59 downto 0);
		row7_bomb : in std_logic_vector(59 downto 0);
		row8_bomb : in std_logic_vector(59 downto 0);
		row9_bomb : in std_logic_vector(59 downto 0);
		row10_bomb : in std_logic_vector(59 downto 0);
		row11_bomb : in std_logic_vector(59 downto 0);
		row12_bomb : in std_logic_vector(59 downto 0);
		row13_bomb : in std_logic_vector(59 downto 0);
		row14_bomb : in std_logic_vector(59 downto 0);
		row_bomb : out std_logic_vector(3 downto 0);
		col_bomb : out std_logic_vector(3 downto 0);
		enable_bomb : out std_logic;
		explode_bomb : out std_logic
		);
end bomb_ent;

architecture bomb_behav of bomb_ent is
	shared variable bomb_set : std_logic := '0';
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
			if(plant_bomb = '0' and bomb_set = '0') then -- just plant when no bomb is planted right now 
				bomb_set := '1';
				row_of_bomb := row_player;
				col_of_bomb := col_player;
			end if;
			enable_bomb <= bomb_set;
			row_bomb <= row_of_bomb;
			col_bomb <= col_of_bomb;
		end if;
	end process set_bomb;

	-- ticks down bomb and explosion when bomb is planted
	bomb_tick : process(clk_bomb, rst_bomb)
		constant TICK_MAX : integer range 0 to 72000000 := 72000000; -- time until explosion : 3 sec
		constant EXPLOSION_MAX : integer range 0 to 12000000 := 12000000; -- duration of explosion : 0.5 sec
		variable tick_cnt : integer range 0 to TICK_MAX := TICK_MAX;
		variable explosion_cnt : integer range to EXPLOSION_MAX := EXPLOSION_MAX; 
		variable is_exploding : std_logic := '0'; -- indicates whether the bomb is exploding or not
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
						bomb_set := '0';
					end if;
				end if;
			end if;
		end if;
	end process bomb_tick;

end bomb_behav;
