library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_state_ent is
	generic(PLAYER_SIZE_STATE, TILE_SIZE_STATE : integer);
	port(
		clk_state : in std_logic;
		rst_state : in std_logic;
		x_player1_state : in std_logic_vector(8 downto 0);
		y_player1_state : in std_logic_vector(8 downto 0);
		enable_player1_state : in std_logic;
		x_player2_state : in std_logic_vector(8 downto 0);
		y_player2_state : in std_logic_vector(8 downto 0);
		enable_player2_state : in std_logic;
		row_bomb1_state : in std_logic_vector(3 downto 0);
		col_bomb1_state : in std_logic_vector(3 downto 0);
		explode_bomb1_state : in std_logic;
		enable_bomb1_state : in std_logic;
		row_bomb2_state : in std_logic_vector(3 downto 0);
		col_bomb2_state : in std_logic_vector(3 downto 0);
		explode_bomb2_state : in std_logic;
		enable_bomb2_state : in std_logic;
		
		enable_player1_state_out : out std_logic;
		enable_player2_state_out : out std_logic;
		row0_state : out std_logic_vector(59 downto 0);
		row1_state : out std_logic_vector(59 downto 0);
		row2_state : out std_logic_vector(59 downto 0);
		row3_state : out std_logic_vector(59 downto 0);
		row4_state : out std_logic_vector(59 downto 0);
		row5_state : out std_logic_vector(59 downto 0);
		row6_state : out std_logic_vector(59 downto 0);
		row7_state : out std_logic_vector(59 downto 0);
		row8_state : out std_logic_vector(59 downto 0);
		row9_state : out std_logic_vector(59 downto 0);
		row10_state : out std_logic_vector(59 downto 0);
		row11_state : out std_logic_vector(59 downto 0);
		row12_state : out std_logic_vector(59 downto 0);
		row13_state : out std_logic_vector(59 downto 0);
		row14_state : out std_logic_vector(59 downto 0)
	);
end game_state_ent;

architecture game_state_behav of game_state_ent is
	signal row0 : std_logic_vector(59 downto 0)  := x"FFFFFFFFFFFFFFF";
	signal row1 : std_logic_vector(59 downto 0)  := x"F00EEEEEEEEE00F";
	signal row2 : std_logic_vector(59 downto 0)  := x"F0F0F0F0F0F0F0F";
	signal row3 : std_logic_vector(59 downto 0)  := x"FE0E0E0E0E0E0EF";
	signal row4 : std_logic_vector(59 downto 0)  := x"FEF0F0F0F0F0FEF";
	signal row5 : std_logic_vector(59 downto 0)  := x"FEE0E0E0E0E0EEF";
	signal row6 : std_logic_vector(59 downto 0)  := x"FEF0F0F0F0F0FEF";
	signal row7 : std_logic_vector(59 downto 0)  := x"FE0E0E0E0E0E0EF";
	signal row8 : std_logic_vector(59 downto 0)  := x"FEF0F0F0F0F0FEF";
	signal row9 : std_logic_vector(59 downto 0)  := x"FEE0E0E0E0E0EEF";
	signal row10 : std_logic_vector(59 downto 0) := x"FEF0F0F0F0F0FEF";
	signal row11 : std_logic_vector(59 downto 0) := x"FE0E0E0E0E0E0EF";
	signal row12 : std_logic_vector(59 downto 0) := x"F0F0F0F0F0F0F0F";
	signal row13 : std_logic_vector(59 downto 0) := x"F00EEEEEEEEE00F";
	signal row14 : std_logic_vector(59 downto 0) := x"FFFFFFFFFFFFFFF";
	
begin
	player_collision : process(clk_state, rst_state)
	begin
		-- TODO : player collission, change player_enable
	end process player_collision;

	-- the rows are changed here when a bomb is planted (or exploding?)
	bomb_placement : process(clk_state, rst_state)
		variable row_int : integer range 0 to 14 := 0;
		variable row_bomb1 : std_logic_vector(59 downto 0) := x"000000000000000";
	begin
		if(rst_state = '0') then
			-- TODO reset all variables
		elsif(clk_state'event and clk_state = '1') then
			if(enable_bomb1_state = '1') then -- bomb 1 is active
				if(explode_bomb1_state = '1') then -- bomb 1 is exploding right now
					-- TODO change rows (also do the explode logic)
					-- NOTE: former bomb_explode process logic could also go here... 
				else -- bomb 1 is just ticking right now
					row_int := to_integer(row_bomb1_state, 4);
					col_int_upper := 59 - (to_integer(col_bomb1_state, 4) * 4); -- upper bound for vector access
					col_int_lower := 56 - (to_integer(col_bomb1_state, 4) * 4); -- lower bound for vector access
					-- change one tile to bomb (bomb = x"D")
					case row_int is
						when 0 => row0(col_int_upper downto col_int_lower) <= x"D";
						when 1 => row1(col_int_upper downto col_int_lower) <= x"D";
						when 2 => row2(col_int_upper downto col_int_lower) <= x"D";
						when 3 => row3(col_int_upper downto col_int_lower) <= x"D";
						when 4 => row4(col_int_upper downto col_int_lower) <= x"D";
						when 5 => row5(col_int_upper downto col_int_lower) <= x"D";
						when 6 => row6(col_int_upper downto col_int_lower) <= x"D";
						when 7 => row7(col_int_upper downto col_int_lower) <= x"D";
						when 8 => row8(col_int_upper downto col_int_lower) <= x"D";
						when 9 => row9(col_int_upper downto col_int_lower) <= x"D";
						when 10 => row10(col_int_upper downto col_int_lower) <= x"D";
						when 11 => row11(col_int_upper downto col_int_lower) <= x"D";
						when 12 => row12(col_int_upper downto col_int_lower) <= x"D";
						when 13 => row13(col_int_upper downto col_int_lower) <= x"D";
						when 14 => row14(col_int_upper downto col_int_lower) <= x"D";
						when others => ;
					end case;
				end if;
			end if;
		end if;
	end process bomb_placement;

	bomb_explode : process(clk_state, rst_state)
	begin
		-- TODO : block collision, change rows
		if(clk_state'event and clk_state = '1') then
			row0_state <= row0;
			row1_state <= row1;
			row2_state <= row2;
			row3_state <= row3;
			row4_state <= row4;
			row5_state <= row5;
			row6_state <= row6;
			row7_state <= row7;
			row8_state <= row8;
			row9_state <= row9;
			row10_state <= row10;
			row11_state <= row11;
			row12_state <= row12;
			row13_state <= row13;
			row14_state <= row14;
			enable_player1_state_out <= '1';
			enable_player2_state_out <= '1';
		end if;
	end process bomb_explode;
end game_state_behav;