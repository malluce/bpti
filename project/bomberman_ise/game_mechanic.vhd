library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_mechanic_ent is
   generic(PLAYER_SIZE_MECH, TILE_SIZE_MECH : integer);
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
        p1_x_coord_mech : out std_logic_vector(8 downto 0);
        p1_y_coord_mech : out std_logic_vector(8 downto 0);
        p1_enable_mech : out std_logic;
        p2_x_coord_mech : out std_logic_vector(8 downto 0);
        p2_y_coord_mech : out std_logic_vector(8 downto 0);
        p2_enable_mech : out std_logic;
        tiles_mech : out std_logic_vector(899 downto 0)
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
		tiles_player : in std_logic_vector(899 downto 0);
		x_player : out std_logic_vector(8 downto 0);
		y_player : out std_logic_vector(8 downto 0);
		row_player : out std_logic_vector(3 downto 0);
		col_player : out std_logic_vector(3 downto 0);
		row_bomb_player : out std_logic_vector(3 downto 0);
		col_bomb_player : out std_logic_vector(3 downto 0);
		enable_bomb_player : out std_logic;
		explode_bomb_player : out std_logic;
		enable_player_out : out std_logic
	);
	end component;
	
	component game_state_ent
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
	end component;
	
	
	signal x_player1_fwd : std_logic_vector(8 downto 0);
	signal y_player1_fwd : std_logic_vector(8 downto 0);
	signal x_player2_fwd : std_logic_vector(8 downto 0);
	signal y_player2_fwd : std_logic_vector(8 downto 0);
	signal row_player1_fwd : std_logic_vector(3 downto 0);
	signal col_player1_fwd : std_logic_vector(3 downto 0);
	signal row_player2_fwd : std_logic_vector(3 downto 0);
	signal col_player2_fwd : std_logic_vector(3 downto 0);
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
	signal tiles_fwd : std_logic_vector(899 downto 0);
	
	
begin
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
		tiles_fwd,
		x_player1_fwd,
		y_player1_fwd,
		row_player1_fwd,
		col_player1_fwd,
		row_bomb1_fwd,
		col_bomb1_fwd,
		enable_bomb1_fwd,
		explode_bomb1_fwd,
		enable_player1_to_state
	);
	
	player_2: player_ent 
	generic map(417, 417, PLAYER_SIZE_MECH, TILE_SIZE_MECH)
	port map(
		clk_mech,
		rst_mech,
		p2_up_mech,
		p2_down_mech,
		p2_left_mech,
		p2_right_mech,
		p2_bomb_mech,
		enable_player2_to_player,
		tiles_fwd,
		x_player2_fwd,
		y_player2_fwd,
		row_player2_fwd,
		col_player2_fwd,
		row_bomb2_fwd,
		col_bomb2_fwd,
		enable_bomb2_fwd,
		explode_bomb2_fwd,
		enable_player2_to_state
	);
	
	state : game_state_ent 
	generic map(PLAYER_SIZE_MECH, TILE_SIZE_MECH)
	port map(
		clk_mech,
		rst_mech,
		row_player1_fwd,
		col_player1_fwd,
		enable_player1_to_state,
		row_player2_fwd,
		col_player2_fwd,
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
		tiles_fwd
	);

	
	p1_x_coord_mech <= x_player1_fwd;
	p1_y_coord_mech <= y_player1_fwd;
	p2_x_coord_mech <= x_player2_fwd;
	p2_y_coord_mech <= y_player2_fwd;
	p1_enable_mech <= enable_player1_to_player;
	p2_enable_mech <= enable_player2_to_player;
	tiles_mech <= tiles_fwd;
end game_mechanic_struct;