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
	type memory is array(0 to 14) of std_logic_vector(59 downto 0);
	constant initial_map : memory := (	x"FFFFFFFFFFFFFFF",
										x"F00EEEEEEEEE00F",
							            x"F0F0F0F0F0F0F0F",
							            x"FE0E0E0E0E0E0EF",
							            x"FEF0F0F0F0F0FEF",
							            x"FEE0E0E0E0E0EEF",
							            x"FEF0F0F0F0F0FEF",
							            x"FE0E0E0E0E0E0EF",
							            x"FEF0F0F0F0F0FEF",
							            x"FEE0E0E0E0E0EEF",
							            x"FEF0F0F0F0F0FEF",
							            x"FE0E0E0E0E0E0EF",
							            x"F0F0F0F0F0F0F0F",
							            x"F00EEEEEEEEE00F",
							            x"FFFFFFFFFFFFFFF");
	signal current_map : memory := initial_map;


	procedure SET_TILE (
			ROW_INT,COL_UPPER: integer; -- row and col of tile to change
		 	NEW_VALUE : std_logic_vector; -- the value to be set
			signal CUR_MAP : out memory -- the current map on which to change the tile
		) is

		variable col : integer range 0 to 59;
		variable row_upper : std_logic_vector(59 downto 0);
		variable row_mid : std_logic_vector(59 downto 0);
		variable row_lower : std_logic_vector(59 downto 0);
		variable tiles_index_upper : integer range 0 to 899 := 0;
		variable tiles_index_mid : integer range 0 to 899 := 0;
		variable tiles_index_lower : integer range 0 to 899 := 0;
	begin
		col := 59 - (4 * COL_UPPER);

		-- get variables from map
		if(ROW_INT = 0) then
			row_mid := current_map(0);
			row_lower := current_map(1);
		elsif(ROW_INT = 14) then
			row_upper := current_map(13);
			row_mid := current_map(14);
		else
			row_upper := current_map(ROW_INT - 1);
			row_mid := current_map(ROW_INT);
			row_lower := current_map(ROW_INT + 1);
		end if;

		if(NEW_VALUE /= x"D") then -- not bomb => change tiles within radius
			if(col <= 55) then -- left tile
				if(to_integer(unsigned(row_mid((col + 4) downto (col + 1)))) /= 15) then
					row_mid((col + 4) downto (col + 1)) := NEW_VALUE;
				end if;
			end if;
			if(col >= 7) then -- right tile
				if(to_integer(unsigned(row_mid((col - 4) downto (col - 7)))) /= 15) then
					row_mid((col - 4) downto (col - 7)) := NEW_VALUE;
				end if;
			end if;
			if(row_int >= 1) then -- upper tile
				if(to_integer(unsigned(row_upper(col downto (col - 3)))) /= 15) then
					row_upper(col downto (col - 3)) := NEW_VALUE;
				end if;
			end if;
			if(row_int <= 13) then -- lower tile
				if(to_integer(unsigned(row_lower(col downto (col - 3)))) /= 15) then
					row_lower(col downto (col - 3)) := NEW_VALUE;
				end if;
			end if;
		end if;

		-- middle tile
		if(to_integer(unsigned(row_mid(col downto (col - 3)))) /=
				15) then
			row_mid(col downto (col - 3)) := NEW_VALUE;
		end if;

		-- set map from variable rows
		if(ROW_INT = 0) then
			CUR_MAP(0) <= row_mid;
			CUR_MAP(1) <= row_lower;
		elsif(ROW_INT = 14) then
			CUR_MAP(13) <= row_upper;
			CUR_MAP(14) <= row_mid;
		else
			CUR_MAP(ROW_INT - 1) <= row_upper;
			CUR_MAP(ROW_INT) <= row_mid;
			CUR_MAP(ROW_INT + 1) <= row_lower;
		end if;
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
		variable enable_player1_state_var : std_logic := '1';
		variable enable_player2_state_var : std_logic := '1';
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
				vector_player1 := current_map(player1_row_int);
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

				vector_player2 := current_map(player2_row_int);

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
			current_map(0) <=  initial_map(0);
			current_map(1) <=  initial_map(1);
			current_map(2) <=  initial_map(2);
			current_map(3) <=  initial_map(3);
			current_map(4) <=  initial_map(4);
			current_map(5) <=  initial_map(5);
			current_map(6) <=  initial_map(6);
			current_map(7) <=  initial_map(7);
			current_map(8) <=  initial_map(8);
			current_map(9) <=  initial_map(9);
			current_map(10) <=  initial_map(10);
			current_map(11) <=  initial_map(11);
			current_map(12) <=  initial_map(12);
			current_map(13) <=  initial_map(13);
			current_map(14) <=  initial_map(14);
		elsif(clk_state'event and clk_state = '1') then
				-- row, col of bombs
				row_int1 := to_integer(unsigned(row_bomb1_state));
				col_int1 := to_integer(unsigned(col_bomb1_state));
				row_int2 := to_integer(unsigned(row_bomb2_state));
				col_int2 := to_integer(unsigned(col_bomb2_state));

			if(explode_bomb1_state = '1' and was_explode1 = '0') then -- bomb 1 is exploding right now
					was_explode1 := '1';
					SET_TILE(row_int1, col_int1, x"1", current_map);

				elsif(explode_bomb1_state = '0' and was_explode1 = '1') then -- bomb 1 finished exploding
					was_explode1 := '0';
					was_enable1 := '0';
					SET_TILE(row_int1, col_int1, x"0", current_map);
				elsif(was_enable1 = '0' and enable_bomb1_state = '1') then -- bomb 1 is ticking right now
					was_enable1 := '1';
					SET_TILE(row_int1, col_int1, x"D", current_map);
			end if;

			if(explode_bomb2_state = '1' and was_explode2 = '0') then -- bomb 2 is exploding right now
					was_explode2 := '1';
					SET_TILE(row_int2, col_int2, x"1", current_map);

			elsif(explode_bomb2_state = '0' and was_explode2 = '1') then -- bomb 2 finished exploding
					was_explode2 := '0';
					was_enable2 := '0';
					SET_TILE(row_int2, col_int2, x"0", current_map);
			elsif(was_enable2 = '0' and enable_bomb2_state = '1') then -- bomb 2 is ticking right now
					-- bomb 2 is just ticking right now
					was_enable2 := '1';
					SET_TILE(row_int2, col_int2, x"D", current_map);
			end if;

			row0_state <= current_map(0);
			row1_state <= current_map(1);
			row2_state <= current_map(2);
			row3_state <= current_map(3);
			row4_state <= current_map(4);
			row5_state <= current_map(5);
			row6_state <= current_map(6);
			row7_state <= current_map(7);
			row8_state <= current_map(8);
			row9_state <= current_map(9);
			row10_state <= current_map(10);
			row11_state <= current_map(11);
			row12_state <= current_map(12);
			row13_state <= current_map(13);
			row14_state <= current_map(14);
		end if;
	end process bomb_placement;
end game_state_behav;
