library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity player_ent is
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
end player_ent;

architecture player_struct of player_ent is
	
	component clk_movement_ent
		port (
			rst_clk : in std_logic;
			clk_in : in std_logic;
			clk_out : out std_logic 
		);
	end component;

	component movement_ent
		generic(X_INIT_MOVE, Y_INIT_MOVE, PLAYER_SIZE_MOVE, TILE_SIZE_MOVE : integer); 
		port(
			fast_clk_move : in std_logic;
			clk_move : in std_logic;
			rst_move : in std_logic;
			up_move : in std_logic;
			down_move : in std_logic;
			left_move : in std_logic;
			right_move : in std_logic;
			tiles_move : in std_logic_vector(899 downto 0);
			x_move : out std_logic_vector(8 downto 0);
			y_move : out std_logic_vector(8 downto 0)
	);
	end component;
	
	component bomb_ent
		generic(TILE_SIZE_BOMB : integer);
		port(
			clk_bomb : in std_logic;
			rst_bomb : in std_logic;
			col_player : in std_logic_vector(3 downto 0);
			row_player : in std_logic_vector(3 downto 0);
			plant_bomb : in std_logic;
			enable_player : in std_logic;
			row_bomb : out std_logic_vector(3 downto 0);
			col_bomb : out std_logic_vector(3 downto 0);
			enable_bomb : out std_logic;
			explode_bomb : out std_logic
		);
	end component;
	
	signal enable_player_fwd : std_logic;
	signal mov_clk_fwd : std_logic;
	signal x_fwd : std_logic_vector(8 downto 0);
	signal y_fwd : std_logic_vector(8 downto 0);
	signal row_fwd : std_logic_vector(3 downto 0);
	signal col_fwd : std_logic_vector(3 downto 0);
	
begin

	mov_clk : clk_movement_ent
	port map(
		rst_player,
		clk_player,
		mov_clk_fwd
	);

	movement : movement_ent  
	generic map(X_INIT_PLAYER, Y_INIT_PLAYER, PLAYER_SIZE_PLAYER, TILE_SIZE_PLAYER)
	port map(
		clk_player,
		mov_clk_fwd,
		rst_player,
		up_player,
		down_player,
		left_player,
		right_player,
		tiles_player,
		x_fwd,
		y_fwd
	);
	
	bomb : bomb_ent 
	generic map(TILE_SIZE_PLAYER)
	port map(
		clk_player,
		rst_player,
		col_fwd,
		row_fwd,
		plant_player,
		enable_player_fwd,
		row_bomb_player,
		col_bomb_player,
		enable_bomb_player,
		explode_bomb_player
	);
	
	x_player <= x_fwd;
	y_player <= y_fwd;
	row_fwd <= std_logic_vector(to_unsigned((to_integer(unsigned(y_fwd)) + (PLAYER_SIZE_PLAYER / 2) - 1) / TILE_SIZE_PLAYER, 4));
	col_fwd <= std_logic_vector(to_unsigned((to_integer(unsigned(x_fwd)) + (PLAYER_SIZE_PLAYER / 2) - 1) / TILE_SIZE_PLAYER, 4));
	row_player <= row_fwd;
	col_player <= col_fwd;
	enable_player_out <= enable_player;
	enable_player_fwd <= enable_player;
end player_struct;