library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity game_state_ent is
	generic(PLAYER_SIZE_STATE, TILE_SIZE_STATE : integer);
	port(
		clk_state : in std_logic;
		rst_state : in std_logic;
		row_player1_state : in std_logic_vector(3 downto 0);
		col_player1_state : in std_logic_vector(3 downto 0);
		enable_player1_state : in std_logic;
		row_player2_state : in std_logic_vector(3 downto 0);
		col_player2_state : in std_logic_vector(3 downto 0);
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
	shared variable row0 : std_logic_vector(59 downto 0)  := x"FFFFFFFFFFFFFFF";
	shared variable row1 : std_logic_vector(59 downto 0)  := x"F00EEEEEEEEE00F";
	shared variable row2 : std_logic_vector(59 downto 0)  := x"F0F0F0F0F0F0F0F";
	shared variable row3 : std_logic_vector(59 downto 0)  := x"FE0E0E0E0E0E0EF";
	shared variable row4 : std_logic_vector(59 downto 0)  := x"FEF0F0F0F0F0FEF";
	shared variable row5 : std_logic_vector(59 downto 0)  := x"FEE0E0E0E0E0EEF";
	shared variable row6 : std_logic_vector(59 downto 0)  := x"FEF0F0F0F0F0FEF";
	shared variable row7 : std_logic_vector(59 downto 0)  := x"FE0E0E0E0E0E0EF";
	shared variable row8 : std_logic_vector(59 downto 0)  := x"FEF0F0F0F0F0FEF";
	shared variable row9 : std_logic_vector(59 downto 0)  := x"FEE0E0E0E0E0EEF";
	shared variable row10 : std_logic_vector(59 downto 0) := x"FEF0F0F0F0F0FEF";
	shared variable row11 : std_logic_vector(59 downto 0) := x"FE0E0E0E0E0E0EF";
	shared variable row12 : std_logic_vector(59 downto 0) := x"F0F0F0F0F0F0F0F";
	shared variable row13 : std_logic_vector(59 downto 0) := x"F00EEEEEEEEE00F";
	shared variable row14 : std_logic_vector(59 downto 0) := x"FFFFFFFFFFFFFFF";
	shared variable enable_player1_state_var : std_logic := '1';
	shared variable enable_player2_state_var : std_logic := '1';


	procedure SET_TILE (ROW_INT,COL_UPPER: integer; NEW_VALUE : std_logic_vector) is
		variable col : integer range 0 to 59;
		variable row_upper : std_logic_vector(59 downto 0);
		variable row_mid : std_logic_vector(59 downto 0);
		variable row_lower : std_logic_vector(59 downto 0);
	begin
		col := 59 - (4 * COL_UPPER);
		case ROW_INT is
			when 0 => 	row_mid := row0;
							row_lower := row1;
			when 1 => 	row_upper := row0;
							row_mid := row1;
							row_lower := row2;
			when 2 => 	row_upper := row1;
							row_mid := row2;
							row_lower := row3;
			when 3 => 	row_upper := row2;
							row_mid := row3;
							row_lower := row4;
			when 4 => 	row_upper := row3;
							row_mid := row4;
							row_lower := row5;
			when 5 => 	row_upper := row4;
							row_mid := row5;
							row_lower := row6;
			when 6 => 	row_upper := row5;
							row_mid := row6;
							row_lower := row7;
			when 7 => 	row_upper := row6;
							row_mid := row7;
							row_lower := row8;
			when 8 => 	row_upper := row7;
							row_mid := row8;
							row_lower := row9;
			when 9 => 	row_upper := row8;
							row_mid := row9;
							row_lower := row10;
			when 10 => 	row_upper := row9;
							row_mid := row10;
							row_lower := row11;
			when 11 => 	row_upper := row10;
							row_mid := row11;
							row_lower := row12;
			when 12 => 	row_upper := row11;
							row_mid := row12;
							row_lower := row13;
			when 13 => 	row_upper := row12;
							row_mid := row13;
							row_lower := row14;
			when 14 => 	row_upper := row13;
							row_mid := row14;
			when others => null;
		end case;
		
		if(NEW_VALUE /= x"D") then
			if(col <= 55) then
				if(to_integer(unsigned(row_mid(col downto (col - 3)))) /= 15) then
					row_mid((col + 4) downto (col + 1)) := NEW_VALUE;
				end if;
			end if;
			if(col >= 7) then
				if(to_integer(unsigned(row_mid(col downto (col - 3)))) /= 15) then
					row_mid((col - 4) downto (col - 7)) := NEW_VALUE;
				end if;
			end if;
			if(row_int >= 1) then
				if(to_integer(unsigned(row_upper(col downto (col - 3)))) /= 15) then
					row_upper(col downto (col - 3)) := NEW_VALUE;
				end if;
			end if;
			if(row_int <= 13) then
				if(to_integer(unsigned(row_lower(col downto (col - 3)))) /= 15) then
					row_lower(col downto (col - 3)) := NEW_VALUE;
				end if;
			end if;
		end if;
		
		if(to_integer(unsigned(row_mid(col downto (col - 3)))) /= 
				15) then
			row_mid(col downto (col - 3)) := NEW_VALUE;
		end if;

		case ROW_INT is
			when 0 => 	row0 := row_mid;
							row1 := row_lower;
			when 1 => 	row0 := row_upper;
							row1 := row_mid;
							row2 := row_lower;
			when 2 => 	row1 := row_upper;
							row2 := row_mid;
							row3 := row_lower;
			when 3 => 	row2 := row_upper;
							row3 := row_mid;
							row4 := row_lower;
			when 4 => 	row3 := row_upper;
							row4 := row_mid;
							row5 := row_lower;
			when 5 => 	row4 := row_upper;
							row5 := row_mid;
							row6 := row_lower;
			when 6 => 	row5 := row_upper;
							row6 := row_mid;
							row7 := row_lower;
			when 7 => 	row6 := row_upper;
							row7 := row_mid;
							row8 := row_lower;
			when 8 => 	row7 := row_upper;
							row8 := row_mid;
							row9 := row_lower;
			when 9 => 	row8 := row_upper;
							row9 := row_mid;
							row10 := row_lower;
			when 10 => 	row9 := row_upper;
							row10 := row_mid;
							row11 := row_lower;
			when 11 => 	row10 := row_upper;
							row11 := row_mid;
							row12 := row_lower;
			when 12 => 	row11 := row_upper;
							row12 := row_mid;
							row13 := row_lower;
			when 13 => 	row12 := row_upper;
							row13 := row_mid;
							row14 := row_lower;
			when 14 => 	row13 := row_upper;
							row14 := row_mid;
			when others => null;
		end case;
	end SET_TILE;
	
begin
	
	-- lookup player position in current row vectors. if player tile = explosion tile kill player (i.e set enable to '0')
	player_collision : process(clk_state, rst_state)
		variable vector_player1 : std_logic_vector(59 downto 0) := x"000000000000000";
		variable vector_player2 : std_logic_vector(59 downto 0) := x"000000000000000";
		variable player1_row_int : integer range 0 to 14 := 0;
		variable player1_col_int : integer range 0 to 14 := 0;
		variable player2_row_int : integer range 0 to 14 := 0;
		variable player2_col_int : integer range 0 to 14 := 0;
	begin
		if(rst_state = '0') then
			vector_player1 := x"000000000000000";
			vector_player2 := x"000000000000000";
			player1_row_int := 0;
			player1_col_int := 0;
			player2_row_int := 0;
			player2_col_int := 0;
			enable_player1_state_var := '1';
			enable_player2_state_var := '1';
		elsif(clk_state'event and clk_state = '1') then
			if(enable_player1_state = '1') then -- action just needed when player is still alive
				player1_row_int := to_integer(unsigned(row_player1_state));
				player1_col_int := to_integer(unsigned(col_player1_state));
				-- calculate the row in which the player is
				case player1_row_int is
					when 0 => vector_player1 := row0;
					when 1 => vector_player1 := row1;
					when 2 => vector_player1 := row2;
					when 3 => vector_player1 := row3;
					when 4 => vector_player1 := row4;
					when 5 => vector_player1 := row5;
					when 6 => vector_player1 := row6;
					when 7 => vector_player1 := row7;
					when 8 => vector_player1 := row8;
					when 9 => vector_player1 := row9;
					when 10 => vector_player1 := row10;
					when 11 => vector_player1 := row11;
					when 12 => vector_player1 := row12;
					when 13 => vector_player1 := row13;
					when 14 => vector_player1 := row14;
					when others => vector_player1 := x"000000000000000";
				end case;
				-- player tile is explosion tile -> kill player
				if(vector_player1(59 - (player1_col_int * 4) downto 56 - (player1_col_int * 4)) = x"1") then
					enable_player1_state_var := '0';
				end if;
			end if;
			enable_player1_state_out <= enable_player1_state_var;
			
			-- same for player2
			if(enable_player2_state = '1') then
				player2_row_int := to_integer(unsigned(row_player2_state));
				player2_col_int := to_integer(unsigned(col_player2_state));
				case player2_row_int is
					when 0 => vector_player2 := row0;
					when 1 => vector_player2 := row1;
					when 2 => vector_player2 := row2;
					when 3 => vector_player2 := row3;
					when 4 => vector_player2 := row4;
					when 5 => vector_player2 := row5;
					when 6 => vector_player2 := row6;
					when 7 => vector_player2 := row7;
					when 8 => vector_player2 := row8;
					when 9 => vector_player2 := row9;
					when 10 => vector_player2 := row10;
					when 11 => vector_player2 := row11;
					when 12 => vector_player2 := row12;
					when 13 => vector_player2 := row13;
					when 14 => vector_player2 := row14;
					when others => vector_player2 := x"000000000000000";
				end case;

				if(vector_player2(59 - (player2_col_int * 4) downto 56 - (player2_col_int * 4)) = x"1") then
					enable_player2_state_var := '0';
				end if;
			end if;
			enable_player2_state_out <= enable_player2_state_var;
		end if;
	end process player_collision;

	-- the rows are changed here when a bomb is planted (or exploding?)
	bomb_placement : process(clk_state, rst_state)
		
		 variable col_int1 : integer range 0 to 14 := 0;
		 variable col_int2 : integer range 0 to 14 := 0;
		 variable was_explode1 : std_logic := '0';
		 variable was_explode2 : std_logic := '0';
		 variable was_enable1 : std_logic := '0';
		 variable was_enable2 : std_logic := '0';
		 variable row_int1 : integer range 0 to 14 := 0;
		 variable row_int2 : integer range 0 to 14 := 0;
		
	begin
		if(rst_state = '0') then
			row_int1 := 0;
			row_int2 := 0;
			col_int1 := 0;
			col_int2 := 0;
			was_explode1 := '0';
			was_explode2 := '0';
			was_enable1 := '0';
			was_enable2 := '0';
			row0 :=  x"FFFFFFFFFFFFFFF";
			row1 :=  x"F00EEEEEEEEE00F";
			row2 :=  x"F0F0F0F0F0F0F0F";
			row3 :=  x"FE0E0E0E0E0E0EF";
			row4 :=  x"FEF0F0F0F0F0FEF";
			row5 :=  x"FEE0E0E0E0E0EEF";
			row6 :=  x"FEF0F0F0F0F0FEF";
			row7 :=	x"FE0E0E0E0E0E0EF";
			row8 :=  x"FEF0F0F0F0F0FEF";
			row9 :=  x"FEE0E0E0E0E0EEF";
			row10 := x"FEF0F0F0F0F0FEF";
			row11 := x"FE0E0E0E0E0E0EF";
			row12 := x"F0F0F0F0F0F0F0F";
			row13 := x"F00EEEEEEEEE00F";
			row14 := x"FFFFFFFFFFFFFFF";
		elsif(clk_state'event and clk_state = '1') then
				row_int1 := to_integer(unsigned(row_bomb1_state));
				col_int1 := to_integer(unsigned(col_bomb1_state)); -- upper bound for vector access
				row_int2 := to_integer(unsigned(row_bomb2_state));
				col_int2 := to_integer(unsigned(col_bomb2_state)); -- upper bound for vector access
		
			if(explode_bomb1_state = '1' and was_explode1 = '0') then -- bomb 1 is exploding right now
					was_explode1 := '1';
					SET_TILE(row_int1, col_int1, x"1");

				elsif(explode_bomb1_state = '0' and was_explode1 = '1') then
					was_explode1 := '0';
					was_enable1 := '0';
					SET_TILE(row_int1, col_int1, x"0");

				elsif(was_enable1 = '0' and enable_bomb1_state = '1') then
				-- bomb 1 is just ticking right now
					-- change one tile to bomb (bomb = x"D")
					was_enable1 := '1';
					SET_TILE(row_int1, col_int1, x"D");
			end if;
			
			if(explode_bomb2_state = '1' and was_explode2 = '0') then -- bomb 2 is exploding right now
					was_explode2 := '1';
					SET_TILE(row_int2, col_int2, x"1");

				elsif(explode_bomb2_state = '0' and was_explode2 = '1') then
					was_explode2 := '0';
					was_enable2 := '0';
					SET_TILE(row_int2, col_int2, x"0");

				elsif(was_enable2 = '0' and enable_bomb2_state = '1') then
				-- bomb 2 is just ticking right now
					-- change one tile to bomb (bomb = x"D")
					was_enable2 := '1';
					SET_TILE(row_int2, col_int2, x"D");
			end if;
			
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
		end if;
	end process bomb_placement;
end game_state_behav;
