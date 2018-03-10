library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--basically an entity to connect the two players with the logic in game_state_ent

entity game_mechanic_ent is
   generic(PLAYER_SIZE_MECH, TILE_SIZE_MECH : integer);
   port(
        --clock and reset signals
        clk_mech : in std_logic;
        rst_mech : in std_logic;

        --input from the users
        p1_up_mech : in std_logic;
        p1_down_mech : in std_logic;
        p1_left_mech : in std_logic;
        p1_right_mech : in std_logic;
        p1_bomb_mech : in std_logic;
        p2_up_mech : in std_logic;
        p2_down_mech : in std_logic;
        p2_left_mech : in std_logic;
        p2_right_mech : in std_logic;
        p2_bomb_mech : in std_logic;

        --coordinates and enables of the players
        p1_x_coord_mech : out std_logic_vector(8 downto 0);
        p1_y_coord_mech : out std_logic_vector(8 downto 0);
        p1_enable_mech : out std_logic;
        p2_x_coord_mech : out std_logic_vector(8 downto 0);
        p2_y_coord_mech : out std_logic_vector(8 downto 0);
        p2_enable_mech : out std_logic;

        --new state of the game board
        row0_mech : out std_logic_vector(59 downto 0);
        row1_mech : out std_logic_vector(59 downto 0);
        row2_mech : out std_logic_vector(59 downto 0);
        row3_mech : out std_logic_vector(59 downto 0);
        row4_mech : out std_logic_vector(59 downto 0);
        row5_mech : out std_logic_vector(59 downto 0);
        row6_mech : out std_logic_vector(59 downto 0);
        row7_mech : out std_logic_vector(59 downto 0);
        row8_mech : out std_logic_vector(59 downto 0);
        row9_mech : out std_logic_vector(59 downto 0);
        row10_mech : out std_logic_vector(59 downto 0);
        row11_mech : out std_logic_vector(59 downto 0);
		row12_mech : out std_logic_vector(59 downto 0);
		row13_mech : out std_logic_vector(59 downto 0);
		row14_mech : out std_logic_vector(59 downto 0)
    );
end game_mechanic_ent;

architecture game_mechanic_struct of game_mechanic_ent is
	component player_ent
		generic(X_INIT_PLAYER, Y_INIT_PLAYER, PLAYER_SIZE_PLAYER, TILE_SIZE_PLAYER : integer);
		port(
    		clk_player : in std_logic;
    		rst_player : in std_logic;
    		up_player : in std_logic;
    		down_player : in std_logic;
    		left_player : in std_logic;
    		right_player : in std_logic;
    		plant_player : in std_logic;
    		enable_player : in std_logic;
    		row_upper_player : in std_logic_vector(59 downto 0);
    		row_mid_player : in std_logic_vector(59 downto 0);
    		row_lower_player : in std_logic_vector(59 downto 0);
    		x_player : out std_logic_vector(8 downto 0);
    		y_player : out std_logic_vector(8 downto 0);
    		row_player : out std_logic_vector(3 downto 0);
    		col_player : out std_logic_vector(3 downto 0);
    		row_bomb_player : out std_logic_vector(3 downto 0);
    		col_bomb_player : out std_logic_vector(3 downto 0);
    		enable_bomb_player : out std_logic;
    		explode_bomb_player : out std_logic
	    );
	end component;

	component game_state_ent
		generic(PLAYER_SIZE_STATE, TILE_SIZE_STATE : integer);
		port(
			clk_state : in std_logic;
			rst_state : in std_logic;
			row_player1_state : in std_logic_vector(3 downto 0);
			col_player1_state : in std_logic_vector(3 downto 0);
			row_player2_state : in std_logic_vector(3 downto 0);
			col_player2_state : in std_logic_vector(3 downto 0);
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
	end component;


	signal x_player1_fwd : std_logic_vector(8 downto 0);
	signal y_player1_fwd : std_logic_vector(8 downto 0);
	signal x_player2_fwd : std_logic_vector(8 downto 0);
	signal y_player2_fwd : std_logic_vector(8 downto 0);
	signal row_player1_fwd : std_logic_vector(3 downto 0);
	signal col_player1_fwd : std_logic_vector(3 downto 0);
	signal row_player2_fwd : std_logic_vector(3 downto 0);
	signal col_player2_fwd : std_logic_vector(3 downto 0);
	signal enable_player1_to_player : std_logic;
	signal enable_player2_to_player : std_logic;
	signal row_bomb1_fwd : std_logic_vector(3 downto 0);
	signal col_bomb1_fwd : std_logic_vector(3 downto 0);
	signal row_bomb2_fwd : std_logic_vector(3 downto 0);
	signal col_bomb2_fwd : std_logic_vector(3 downto 0);
	signal explode_bomb1_fwd : std_logic;
	signal explode_bomb2_fwd : std_logic;
	signal enable_bomb1_fwd : std_logic;
	signal enable_bomb2_fwd : std_logic;
	signal row0_fwd : std_logic_vector(59 downto 0);
	signal row1_fwd : std_logic_vector(59 downto 0);
	signal row2_fwd : std_logic_vector(59 downto 0);
	signal row3_fwd : std_logic_vector(59 downto 0);
	signal row4_fwd : std_logic_vector(59 downto 0);
	signal row5_fwd : std_logic_vector(59 downto 0);
	signal row6_fwd : std_logic_vector(59 downto 0);
	signal row7_fwd : std_logic_vector(59 downto 0);
	signal row8_fwd : std_logic_vector(59 downto 0);
	signal row9_fwd : std_logic_vector(59 downto 0);
	signal row10_fwd : std_logic_vector(59 downto 0);
	signal row11_fwd : std_logic_vector(59 downto 0);
	signal row12_fwd : std_logic_vector(59 downto 0);
	signal row13_fwd : std_logic_vector(59 downto 0);
	signal row14_fwd : std_logic_vector(59 downto 0);
	signal row_upper_fwd_p1 : std_logic_vector(59 downto 0);
	signal row_mid_fwd_p1 : std_logic_vector(59 downto 0);
	signal row_lower_fwd_p1 : std_logic_vector(59 downto 0);
	signal row_upper_fwd_p2 : std_logic_vector(59 downto 0);
	signal row_mid_fwd_p2 : std_logic_vector(59 downto 0);
	signal row_lower_fwd_p2 : std_logic_vector(59 downto 0);

begin

    --first player
	player_1: player_ent
	generic map(33, 33, PLAYER_SIZE_MECH, TILE_SIZE_MECH)
	port map(
		clk_mech,
		rst_mech,
		p1_up_mech,
		p1_down_mech,
		p1_left_mech,
		p1_right_mech,
		p1_bomb_mech,
		enable_player1_to_player,
		row_upper_fwd_p1,
		row_mid_fwd_p1,
		row_lower_fwd_p1,
		x_player1_fwd,
		y_player1_fwd,
		row_player1_fwd,
		col_player1_fwd,
		row_bomb1_fwd,
		col_bomb1_fwd,
		enable_bomb1_fwd,
		explode_bomb1_fwd
	);

    --second player
	player_2: player_ent
	generic map(33, 417, PLAYER_SIZE_MECH, TILE_SIZE_MECH)
	port map(
		clk_mech,
		rst_mech,
		p2_up_mech,
		p2_down_mech,
		p2_left_mech,
		p2_right_mech,
		p2_bomb_mech,
		enable_player2_to_player,
		row_upper_fwd_p2,
		row_mid_fwd_p2,
		row_lower_fwd_p2,
		x_player2_fwd,
		y_player2_fwd,
		row_player2_fwd,
		col_player2_fwd,
		row_bomb2_fwd,
		col_bomb2_fwd,
		enable_bomb2_fwd,
		explode_bomb2_fwd
	);

    --manages the game board and all of the collisions
	state : game_state_ent
	generic map(PLAYER_SIZE_MECH, TILE_SIZE_MECH)
	port map(
		clk_mech,
		rst_mech,
		row_player1_fwd,
		col_player1_fwd,
		row_player2_fwd,
		col_player2_fwd,
		row_bomb1_fwd,
		col_bomb1_fwd,
		explode_bomb1_fwd,
		enable_bomb1_fwd,
		row_bomb2_fwd,
		col_bomb2_fwd,
		explode_bomb2_fwd,
		enable_bomb2_fwd,
		enable_player1_to_player,
		enable_player2_to_player,
		tiles_fwd
	);


	row_upper_fwd_p1 <= row0_fwd when row_player1_fwd = x"1" else
							  row1_fwd when row_player1_fwd = x"2" else
							  row2_fwd when row_player1_fwd = x"3" else
							  row3_fwd when row_player1_fwd = x"4" else
							  row4_fwd when row_player1_fwd = x"5" else
							  row5_fwd when row_player1_fwd = x"6" else
							  row6_fwd when row_player1_fwd = x"7" else
							  row7_fwd when row_player1_fwd = x"8" else
							  row8_fwd when row_player1_fwd = x"9" else
							  row9_fwd when row_player1_fwd = x"A" else
							  row10_fwd when row_player1_fwd = x"B" else
							  row11_fwd when row_player1_fwd = x"C" else
							  row12_fwd when row_player1_fwd = x"D" else
							  row13_fwd when row_player1_fwd = x"E" else
							  x"000000000000000";

	row_mid_fwd_p1 <=   row0_fwd when row_player1_fwd = x"0" else
							  row1_fwd when row_player1_fwd = x"1" else
							  row2_fwd when row_player1_fwd = x"2" else
							  row3_fwd when row_player1_fwd = x"3" else
							  row4_fwd when row_player1_fwd = x"4" else
							  row5_fwd when row_player1_fwd = x"5" else
							  row6_fwd when row_player1_fwd = x"6" else
							  row7_fwd when row_player1_fwd = x"7" else
							  row8_fwd when row_player1_fwd = x"8" else
							  row9_fwd when row_player1_fwd = x"9" else
							  row10_fwd when row_player1_fwd = x"A" else
							  row11_fwd when row_player1_fwd = x"B" else
							  row12_fwd when row_player1_fwd = x"C" else
							  row13_fwd when row_player1_fwd = x"D" else
							  row14_fwd when row_player1_fwd = x"E" else
							  x"000000000000000";

	row_lower_fwd_p1 <= row1_fwd when row_player1_fwd = x"0" else
							  row2_fwd when row_player1_fwd = x"1" else
							  row3_fwd when row_player1_fwd = x"2" else
							  row4_fwd when row_player1_fwd = x"3" else
							  row5_fwd when row_player1_fwd = x"4" else
							  row6_fwd when row_player1_fwd = x"5" else
							  row7_fwd when row_player1_fwd = x"6" else
							  row8_fwd when row_player1_fwd = x"7" else
							  row9_fwd when row_player1_fwd = x"8" else
							  row10_fwd when row_player1_fwd = x"9" else
							  row11_fwd when row_player1_fwd = x"A" else
							  row12_fwd when row_player1_fwd = x"B" else
							  row13_fwd when row_player1_fwd = x"C" else
							  row14_fwd when row_player1_fwd = x"D" else
							  x"000000000000000";

	row_upper_fwd_p2 <= row0_fwd when row_player2_fwd = x"1" else
							  row1_fwd when row_player2_fwd = x"2" else
							  row2_fwd when row_player2_fwd = x"3" else
							  row3_fwd when row_player2_fwd = x"4" else
							  row4_fwd when row_player2_fwd = x"5" else
							  row5_fwd when row_player2_fwd = x"6" else
							  row6_fwd when row_player2_fwd = x"7" else
							  row7_fwd when row_player2_fwd = x"8" else
							  row8_fwd when row_player2_fwd = x"9" else
							  row9_fwd when row_player2_fwd = x"A" else
							  row10_fwd when row_player2_fwd = x"B" else
							  row11_fwd when row_player2_fwd = x"C" else
							  row12_fwd when row_player2_fwd = x"D" else
							  row13_fwd when row_player2_fwd = x"E" else
							  x"000000000000000";

	row_mid_fwd_p2 <=   row0_fwd when row_player2_fwd = x"0" else
							  row1_fwd when row_player2_fwd = x"1" else
							  row2_fwd when row_player2_fwd = x"2" else
							  row3_fwd when row_player2_fwd = x"3" else
							  row4_fwd when row_player2_fwd = x"4" else
							  row5_fwd when row_player2_fwd = x"5" else
							  row6_fwd when row_player2_fwd = x"6" else
							  row7_fwd when row_player2_fwd = x"7" else
							  row8_fwd when row_player2_fwd = x"8" else
							  row9_fwd when row_player2_fwd = x"9" else
							  row10_fwd when row_player2_fwd = x"A" else
							  row11_fwd when row_player2_fwd = x"B" else
							  row12_fwd when row_player2_fwd = x"C" else
							  row13_fwd when row_player2_fwd = x"D" else
							  row14_fwd when row_player2_fwd = x"E" else
							  x"000000000000000";

	row_lower_fwd_p2 <= row1_fwd when row_player2_fwd = x"0" else
							  row2_fwd when row_player2_fwd = x"1" else
							  row3_fwd when row_player2_fwd = x"2" else
							  row4_fwd when row_player2_fwd = x"3" else
							  row5_fwd when row_player2_fwd = x"4" else
							  row6_fwd when row_player2_fwd = x"5" else
							  row7_fwd when row_player2_fwd = x"6" else
							  row8_fwd when row_player2_fwd = x"7" else
							  row9_fwd when row_player2_fwd = x"8" else
							  row10_fwd when row_player2_fwd = x"9" else
							  row11_fwd when row_player2_fwd = x"A" else
							  row12_fwd when row_player2_fwd = x"B" else
							  row13_fwd when row_player2_fwd = x"C" else
							  row14_fwd when row_player2_fwd = x"D" else
							  x"000000000000000";

    --set the output signale to the values of the forward signals
	p1_x_coord_mech <= x_player1_fwd;
	p1_y_coord_mech <= y_player1_fwd;
	p2_x_coord_mech <= x_player2_fwd;
	p2_y_coord_mech <= y_player2_fwd;
	p1_enable_mech <= enable_player1_to_player;
	p2_enable_mech <= enable_player2_to_player;
	row0_mech <= row0_fwd;
	row1_mech <= row1_fwd;
	row2_mech <= row2_fwd;
	row3_mech <= row3_fwd;
	row4_mech <= row4_fwd;
	row5_mech <= row5_fwd;
	row6_mech <= row6_fwd;
	row7_mech <= row7_fwd;
	row8_mech <= row8_fwd;
	row9_mech <= row9_fwd;
	row10_mech <= row10_fwd;
	row11_mech <= row11_fwd;
	row12_mech <= row12_fwd;
	row13_mech <= row13_fwd;
	row14_mech <= row14_fwd;
end game_mechanic_struct;
