library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_mechanic_ent is
    port(
        clk_mech : in std_logic;
        rst_mech : in std_logic;
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
        p1_x_coord_mech : out std_logic_vector(9 downto 0);
        p1_y_coord_mech : out std_logic_vector(8 downto 0);
        p1_enable_mech : out std_logic;
        p2_x_coord_mech : out std_logic_vector(9 downto 0);
        p2_y_coord_mech : out std_logic_vector(8 downto 0);
        p2_enable_mech : out std_logic;
        row0_mech : out std_logic_vector(47 downto 0);
        row1_mech : out std_logic_vector(47 downto 0);
        row2_mech : out std_logic_vector(47 downto 0);
        row3_mech : out std_logic_vector(47 downto 0);
        row4_mech : out std_logic_vector(47 downto 0);
        row5_mech : out std_logic_vector(47 downto 0);
        row6_mech : out std_logic_vector(47 downto 0);
        row7_mech : out std_logic_vector(47 downto 0);
        row8_mech : out std_logic_vector(47 downto 0);
        row9_mech : out std_logic_vector(47 downto 0);
        row10_mech : out std_logic_vector(47 downto 0);
        row11_mech : out std_logic_vector(47 downto 0)
    );
end game_mechanic_ent;

architecture game_mechanic_struct of game_mechanic_ent is
	component player_ent 
		port(
		clk_player : in std_logic;
		rst_player : in std_logic;
		up_player : in std_logic;
		down_player : in std_logic;
		left_player : in std_logic;
		right_player : in std_logic;
		plant_player : in std_logic;
		enable_player : in std_logic;
		row0_player : in std_logic_vector(47 downto 0);
		row1_player : in std_logic_vector(47 downto 0);
		row2_player : in std_logic_vector(47 downto 0);
		row3_player : in std_logic_vector(47 downto 0);
		row4_player : in std_logic_vector(47 downto 0);
		row5_player : in std_logic_vector(47 downto 0);
		row6_player : in std_logic_vector(47 downto 0);
		row7_player : in std_logic_vector(47 downto 0);
		row8_player : in std_logic_vector(47 downto 0);
		row9_player : in std_logic_vector(47 downto 0);
		row10_player : in std_logic_vector(47 downto 0);
		row11_player : in std_logic_vector(47 downto 0);
		x_player : out std_logic_vector(9 downto 0);
		y_player : out std_logic_vector(8 downto 0);
		row_bomb_player : out std_logic_vector(3 downto 0);
		col_bomb_player : out std_logic_vector(3 downto 0);
		enable_bomb_player : out std_logic;
		explode_bomb_player : out std_logic;
		enable_player_out : out std_logic
	);
	end component;
	
	component game_state_ent
		port(
			clk_state : in std_logic;
			rst_state : in std_logic;
			x_player1_state : in std_logic_vector(3 downto 0);
			y_player1_state : in std_logic_vector(3 downto 0);
			enable_player1_state : in std_logic;
			x_player2_state : in std_logic_vector(3 downto 0);
			y_player2_state : in std_logic_vector(3 downto 0);
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
			row0_state : out std_logic_vector(47 downto 0);
			row1_state : out std_logic_vector(47 downto 0);
			row2_state : out std_logic_vector(47 downto 0);
			row3_state : out std_logic_vector(47 downto 0);
			row4_state : out std_logic_vector(47 downto 0);
			row5_state : out std_logic_vector(47 downto 0);
			row6_state : out std_logic_vector(47 downto 0);
			row7_state : out std_logic_vector(47 downto 0);
			row8_state : out std_logic_vector(47 downto 0);
			row9_state : out std_logic_vector(47 downto 0);
			row10_state : out std_logic_vector(47 downto 0);
			row11_state : out std_logic_vector(47 downto 0)
		);
	end component;
	
	signal x_player1_fwd : std_logic_vector(9 downto 0);
	signal y_player1_fwd : std_logic_vector(8 downto 0);
	signal x_player2_fwd : std_logic_vector(9 downto 0);
	signal y_player2_fwd : std_logic_vector(8 downto 0);
	signal enable_player1_to_state : std_logic;
	signal enable_player2_to_state : std_logic;
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
	signal row0_fwd : std_logic_vector(47 downto 0);
	signal row1_fwd : std_logic_vector(47 downto 0);
	signal row2_fwd : std_logic_vector(47 downto 0);
	signal row3_fwd : std_logic_vector(47 downto 0);
	signal row4_fwd : std_logic_vector(47 downto 0);
	signal row5_fwd : std_logic_vector(47 downto 0);
	signal row6_fwd : std_logic_vector(47 downto 0);
	signal row7_fwd : std_logic_vector(47 downto 0);
	signal row8_fwd : std_logic_vector(47 downto 0);
	signal row9_fwd : std_logic_vector(47 downto 0);
	signal row10_fwd : std_logic_vector(47 downto 0);
	signal row11_fwd : std_logic_vector(47 downto 0);
	
begin
	player_1: player_ent port map(
		clk_mech,
		rst_mech,
		p1_up_mech,
		p1_down_mech,
		p1_left_mech,
		p1_right_mech,
		p1_bomb_mech,
		enable_player1_to_player,
		row0_fwd,
		row1_fwd,
		row2_fwd,
		row3_fwd,
		row4_fwd,
		row5_fwd,
		row6_fwd,
		row7_fwd,
		row8_fwd,
		row9_fwd,
		row10_fwd,
		row11_fwd,
		x_player1_fwd,
		y_player1_fwd,
		row_bomb1_fwd,
		col_bomb1_fwd,
		enable_bomb1_fwd,
		explode_bomb1_fwd,
		enable_player1_to_state
	);
	
	player_2: player_ent port map(
		clk_mech,
		rst_mech,
		p2_up_mech,
		p2_down_mech,
		p2_left_mech,
		p2_right_mech,
		p2_bomb_mech,
		enable_player2_to_player,
		row0_fwd,
		row1_fwd,
		row2_fwd,
		row3_fwd,
		row4_fwd,
		row5_fwd,
		row6_fwd,
		row7_fwd,
		row8_fwd,
		row9_fwd,
		row10_fwd,
		row11_fwd,
		x_player2_fwd,
		y_player2_fwd,
		row_bomb2_fwd,
		col_bomb2_fwd,
		enable_bomb2_fwd,
		explode_bomb2_fwd,
		enable_player2_to_state
	);
	
	state : game_state_ent port map(
		clk_mech,
		rst_mech,
		x_player1_fwd,
		y_player1_fwd,
		enable_player1_to_state,
		x_player2_fwd,
		y_player2_fwd,
		enable_player2_to_state,
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
		row0_fwd,
		row1_fwd,
		row2_fwd,
		row3_fwd,
		row4_fwd,
		row5_fwd,
		row6_fwd,
		row7_fwd,
		row8_fwd,
		row9_fwd,
		row10_fwd,
		row11_fwd
	);

	
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
end game_mechanic_struct;