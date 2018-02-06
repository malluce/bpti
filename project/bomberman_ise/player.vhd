library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- this entity instantiates all components needed for one player.
-- it handles the inputs of one gamepad in accordance to the current map and outputs the position of the player and his bomb (including the state of the bomb).
entity player_ent is
	generic(
		-- the initial position of this player (arena coordinates start at (1,1) and ends at (480, 480))
		X_INIT_PLAYER,
		Y_INIT_PLAYER,
		-- the size of the player and the tile (in pixels)
		PLAYER_SIZE_PLAYER,
		TILE_SIZE_PLAYER : integer
		);
	port(
		-- VGA clock
		clk_player : in std_logic;
		-- synchronous reset
		rst_player : in std_logic;

		-- inputs by gamepad (low-active)
		up_player : in std_logic;
		down_player : in std_logic;
		left_player : in std_logic;
		right_player : in std_logic;
		plant_player : in std_logic;

		-- indicates whether the player is still alive (may have been killed by bomb explosion)
		enable_player : in std_logic;

		-- the rows of the current arena (15 tiles per row, each tile's state is encoded in one hex number)
		row0_player : in std_logic_vector(59 downto 0);
		row1_player : in std_logic_vector(59 downto 0);
		row2_player : in std_logic_vector(59 downto 0);
		row3_player : in std_logic_vector(59 downto 0);
		row4_player : in std_logic_vector(59 downto 0);
		row5_player : in std_logic_vector(59 downto 0);
		row6_player : in std_logic_vector(59 downto 0);
		row7_player : in std_logic_vector(59 downto 0);
		row8_player : in std_logic_vector(59 downto 0);
		row9_player : in std_logic_vector(59 downto 0);
		row10_player : in std_logic_vector(59 downto 0);
		row11_player : in std_logic_vector(59 downto 0);
		row12_player : in std_logic_vector(59 downto 0);
		row13_player : in std_logic_vector(59 downto 0);
		row14_player : in std_logic_vector(59 downto 0);

		-- the position of the player

		-- pixel-position:
		x_player : out std_logic_vector(8 downto 0);
		y_player : out std_logic_vector(8 downto 0);

		-- tile-position:
		row_player : out std_logic_vector(3 downto 0);
		col_player : out std_logic_vector(3 downto 0);

		-- the position of the bomb (tile-position)
		row_bomb_player : out std_logic_vector(3 downto 0);
		col_bomb_player : out std_logic_vector(3 downto 0);

		-- state of the bomb
		enable_bomb_player : out std_logic;
		explode_bomb_player : out std_logic
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
			clk_move : in std_logic;
			rst_move : in std_logic;
			up_move : in std_logic;
			down_move : in std_logic;
			left_move : in std_logic;
			right_move : in std_logic;
			row0_move : in std_logic_vector(59 downto 0);
			row1_move : in std_logic_vector(59 downto 0);
			row2_move : in std_logic_vector(59 downto 0);
			row3_move : in std_logic_vector(59 downto 0);
			row4_move : in std_logic_vector(59 downto 0);
			row5_move : in std_logic_vector(59 downto 0);
			row6_move : in std_logic_vector(59 downto 0);
			row7_move : in std_logic_vector(59 downto 0);
			row8_move : in std_logic_vector(59 downto 0);
			row9_move : in std_logic_vector(59 downto 0);
			row10_move : in std_logic_vector(59 downto 0);
			row11_move : in std_logic_vector(59 downto 0);
			row12_move : in std_logic_vector(59 downto 0);
			row13_move : in std_logic_vector(59 downto 0);
			row14_move : in std_logic_vector(59 downto 0);
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
		mov_clk_fwd,
		rst_player,
		up_player,
		down_player,
		left_player,
		right_player,
		row0_player,
		row1_player,
		row2_player,
		row3_player,
		row4_player,
		row5_player,
		row6_player,
		row7_player,
		row8_player,
		row9_player,
		row10_player,
		row11_player,
		row12_player,
		row13_player,
		row14_player,
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

	-- position of player is the output of the movement_ent
	x_player <= x_fwd;
	y_player <= y_fwd;
	-- tile-position can be calculated from pixel-position (we use the approximate centre point of the player)
	row_fwd <= std_logic_vector(to_unsigned((to_integer(unsigned(y_fwd)) + (PLAYER_SIZE_PLAYER / 2) - 1) / TILE_SIZE_PLAYER, 4));
	col_fwd <= std_logic_vector(to_unsigned((to_integer(unsigned(x_fwd)) + (PLAYER_SIZE_PLAYER / 2) - 1) / TILE_SIZE_PLAYER, 4));
	row_player <= row_fwd;
	col_player <= col_fwd;

	enable_player_fwd <= enable_player;
end player_struct;
