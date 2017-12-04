library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity player_ent is
	port(
		clk_player : in std_logic;
		rst_player : in std_logic;
		player_input : in std_logic; -- TODO which kind of input?
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
end player_ent;

architecture player_struct of player_ent is
	component input_converter_ent
		port(
			player_input_converter : in std_logic;
			up_converter : out std_logic;
			down_converter : out std_logic;
			left_converter : out std_logic;
			right_converter : out std_logic;
			plant_converter : out std_logic
	);
	end component;
	
	component movement_ent
		port(
			clk_move : in std_logic;
			rst_move : in std_logic;
			up_move : in std_logic;
			down_move : in std_logic;
			left_move : in std_logic;
			right_move : in std_logic;
			row0_move : in std_logic_vector(47 downto 0);
			row1_move : in std_logic_vector(47 downto 0);
			row2_move : in std_logic_vector(47 downto 0);
			row3_move : in std_logic_vector(47 downto 0);
			row4_move : in std_logic_vector(47 downto 0);
			row5_move : in std_logic_vector(47 downto 0);
			row6_move : in std_logic_vector(47 downto 0);
			row7_move : in std_logic_vector(47 downto 0);
			row8_move : in std_logic_vector(47 downto 0);
			row9_move : in std_logic_vector(47 downto 0);
			row10_move : in std_logic_vector(47 downto 0);
			row11_move : in std_logic_vector(47 downto 0);
			x_move : out std_logic_vector(9 downto 0);
			y_move : out std_logic_vector(8 downto 0)
	);
	end component;
	
	component xy_to_rowcol_ent
		port(
			x_convert : in std_logic_vector(9 downto 0);
			y_convert : in std_logic_vector(8 downto 0);
			row_convert : out std_logic_vector(3 downto 0);
			col_convert : out std_logic_vector(3 downto 0)
		);
	end component;
	
	component bomb_ent
		port(
			clk_bomb : in std_logic;
			rst_bomb : in std_logic;
			col_player : in std_logic_vector(3 downto 0);
			row_player : in std_logic_vector(3 downto 0);
			plant_bomb : in std_logic;
			row0_bomb : in std_logic_vector(47 downto 0);
			row1_bomb : in std_logic_vector(47 downto 0);
			row2_bomb : in std_logic_vector(47 downto 0);
			row3_bomb : in std_logic_vector(47 downto 0);
			row4_bomb : in std_logic_vector(47 downto 0);
			row5_bomb : in std_logic_vector(47 downto 0);
			row6_bomb : in std_logic_vector(47 downto 0);
			row7_bomb : in std_logic_vector(47 downto 0);
			row8_bomb : in std_logic_vector(47 downto 0);
			row9_bomb : in std_logic_vector(47 downto 0);
			row10_bomb : in std_logic_vector(47 downto 0);
			row11_bomb : in std_logic_vector(47 downto 0);
			row_bomb : out std_logic_vector(3 downto 0);
			col_bomb : out std_logic_vector(3 downto 0);
			enable_bomb : out std_logic;
			explode_bomb : out std_logic
		);
	end component;
	
	signal up_fwd : std_logic;
	signal down_fwd : std_logic;
	signal left_fwd : std_logic;
	signal right_fwd : std_logic;
	signal plant_fwd : std_logic;
	signal x_fwd : std_logic_vector(9 downto 0);
	signal y_fwd : std_logic_vector(8 downto 0);
	signal row_fwd : std_logic_vector(3 downto 0);
	signal col_fwd : std_logic_vector(3 downto 0);
	
	
begin 
	input_converter : input_converter_ent port map(
		player_input,
		up_fwd,
		down_fwd,
		left_fwd,
		right_fwd,
		plant_fwd
	);
	
	movement : movement_ent port map(
		clk_player,
		rst_player,
		up_fwd,
		down_fwd,
		left_fwd,
		right_fwd,
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
		x_fwd,
		y_fwd
	);
	
	xy_to_rowcol : xy_to_rowcol_ent port map(
		x_fwd,
		y_fwd,
		row_fwd,
		col_fwd
	);
	
	bomb : bomb_ent port map(
		clk_player,
		rst_player,
		col_fwd,
		row_fwd,
		plant_fwd,
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
		row_bomb_player,
		col_bomb_player,
		enable_bomb_player,
		explode_bomb_player
	);
	
	x_player <= x_fwd;
	y_player <= y_fwd;
	enable_player_out <= enable_player;
end player_struct;