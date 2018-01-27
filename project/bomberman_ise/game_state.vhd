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
		tiles_state : out std_logic_vector(899 downto 0)
	);
end game_state_ent;

architecture game_state_behav of game_state_ent is
	shared variable tiles : std_logic_vector(899 downto 0)  := x"FFFFFFFFFFFFFFFF00EEEEEEEEE00FF0F0F0F0F0F0F0FFE0E0E0E0E0E0EFFEF0F0F0F0F0FEFFEE0E0E0E0E0EEFFEF0F0F0F0F0FEFFE0E0E0E0E0E0EFFEF0F0F0F0F0FEFFEE0E0E0E0E0EEFFEF0F0F0F0F0FEFFE0E0E0E0E0E0EFF0F0F0F0F0F0F0FF00EEEEEEEEE00FFFFFFFFFFFFFFFF";
	shared variable enable_player1_state_var : std_logic := '1';
	shared variable enable_player2_state_var : std_logic := '1';


	procedure SET_TILE (ROW_INT,COL_UPPER: integer; NEW_VALUE : std_logic_vector) is
		variable col : integer range 0 to 59;
		variable row_upper : std_logic_vector(59 downto 0);
		variable row_mid : std_logic_vector(59 downto 0);
		variable row_lower : std_logic_vector(59 downto 0);
		variable tiles_index_upper : integer range 0 to 899 := 0;
		variable tiles_index_mid : integer range 0 to 899 := 0;
		variable tiles_index_lower : integer range 0 to 899 := 0;
	begin
		col := 59 - (4 * COL_UPPER);

		tiles_index_upper := 899 - ((ROW_INT - 1) * 60);
		row_upper := tiles(tiles_index_upper downto (tiles_index_upper - 59));

		tiles_index_mid := 899 - ((ROW_INT) * 60);
		row_mid := tiles(tiles_index_mid downto (tiles_index_mid - 59));

		tiles_index_lower := 899 - ((ROW_INT + 1) * 60);
		row_lower := tiles(tiles_index_lower downto (tiles_index_lower - 59));

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

		tiles(tiles_index_upper downto (tiles_index_upper - 59)) := row_upper;
		tiles(tiles_index_mid downto (tiles_index_mid - 59)) := row_mid;
		tiles(tiles_index_lower downto (tiles_index_lower - 59)) := row_lower;

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
		variable tiles_index1 : integer range 0 to 899 := 0;
		variable tiles_index2 : integer range 0 to 899 := 0;
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
				tiles_index1 := 899 - (player1_row_int * 60);
				vector_player1 := tiles(tiles_index1 downto (tiles_index1 - 59));

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
				tiles_index2 := 899 - (player2_row_int * 60);
				vector_player2 := tiles(tiles_index2 downto (tiles_index2 - 59));

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
			tiles := x"FFFFFFFFFFFFFFFF00EEEEEEEEE00FF0F0F0F0F0F0F0FFE0E0E0E0E0E0EFFEF0F0F0F0F0FEFFEE0E0E0E0E0EEFFEF0F0F0F0F0FEFFE0E0E0E0E0E0EFFEF0F0F0F0F0FEFFEE0E0E0E0E0EEFFEF0F0F0F0F0FEFFE0E0E0E0E0E0EFF0F0F0F0F0F0F0FF00EEEEEEEEE00FFFFFFFFFFFFFFFF";
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

			tiles_state <= tiles;
		end if;
	end process bomb_placement;
end game_state_behav;
