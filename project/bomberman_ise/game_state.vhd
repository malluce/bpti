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
		variable col : integer range 0 to 14;
		variable row : std_logic_vector(59 downto 0);
	begin
		case ROW_INT is
			when 0 => row := row0;
			when 1 => row := row1;
			when 2 => row := row2;
			when 3 => row := row3;
			when 4 => row := row4;
			when 5 => row := row5;
			when 6 => row := row6;
			when 7 => row := row7;
			when 8 => row := row8;
			when 9 => row := row9;
			when 10 => row := row10;
			when 11 => row := row11;
			when 12 => row := row12;
			when 13 => row := row13;
			when 14 => row := row14;
			when others => row := x"000000000000000";
		end case;
		
		if(to_integer(unsigned(row(COL_UPPER downto (COL_UPPER - 3)))) /= 
				15) then
			row(COL_UPPER downto (COL_UPPER - 3)) := NEW_VALUE;
		end if;

		case ROW_INT is
			when 0 => row0 := row;
			when 1 => row1 := row;
			when 2 => row2 := row;
			when 3 => row3 := row;
			when 4 => row4 := row;
			when 5 => row5 := row;
			when 6 => row6 := row;
			when 7 => row7 := row;
			when 8 => row8 := row;
			when 9 => row9 := row;
			when 10 => row10 := row;
			when 11 => row11 := row;
			when 12 => row12 := row;
			when 13 => row13 := row;
			when 14 => row14 := row;
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
		variable row_int : integer range 0 to 14 := 0;
		variable row_bomb1 : std_logic_vector(59 downto 0) := x"000000000000000";
		variable col_int_upper : integer range 0 to 59 := 59;
		variable col_int_lower : integer range 0 to 56 := 56;
		variable was_explode1 : std_logic := '0';
		variable was_explode2 : std_logic := '0';
		variable was_enable1 : std_logic := '0';
	begin
		if(rst_state = '0') then
			row_int := 0;
			row_bomb1 := x"000000000000000";
			col_int_upper := 59;
			col_int_lower := 56;
			was_explode1 := '0';
			was_explode2 := '0';
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
				row_int := to_integer(unsigned(row_bomb1_state));
				col_int_upper := 59 - (to_integer(unsigned(col_bomb1_state)) * 4); -- upper bound for vector access
			if(explode_bomb1_state = '1' and was_explode1 = '0') then -- bomb 1 is exploding right now
					was_explode1 := '1';
					SET_TILE(row_int, col_int_upper, x"1");
					if(col_int_upper <= 55) then
						SET_TILE(row_int, col_int_upper+4, x"1");
					end if;
					if(col_int_upper >= 7) then
						SET_TILE(row_int, col_int_upper-4, x"1");
					end if;
					if(row_int >= 1) then
						SET_TILE(row_int-1, col_int_upper, x"1");
					end if;
					if(row_int <= 13) then
						SET_TILE(row_int+1, col_int_upper, x"1");
					end if;

				elsif(explode_bomb1_state = '0' and was_explode1 = '1') then
					was_explode1 := '0';
					was_enable1 := '0';
					SET_TILE(row_int, col_int_upper, x"0");
					if(col_int_upper <= 55) then
						SET_TILE(row_int, col_int_upper+4, x"0");
					end if;
					if(col_int_upper >= 7) then
						SET_TILE(row_int, col_int_upper-4, x"0");
					end if;
					if(row_int >= 1) then
						SET_TILE(row_int-1, col_int_upper, x"0");
					end if;
					if(row_int <= 13) then
						SET_TILE(row_int+1, col_int_upper, x"0");
					end if;

				elsif(was_enable1 = '0' and enable_bomb1_state = '1') then
				-- bomb 1 is just ticking right now
					-- change one tile to bomb (bomb = x"D")
					was_enable1 := '1';
					SET_TILE(row_int, col_int_upper, x"D");
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
