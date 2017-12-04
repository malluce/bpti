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
		explode_bomb_player : out std_logic
	);
end player;

architecture player_struct of player_ent is
	-- TODO
end player_struct;