library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_state_ent is
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
end game_state;

architecture game_state_behav of game_state_ent is
	-- TODO initial blocks INSIDE arena
	signal row0 : std_logic_vector(47 downto 0)  := x"FFFFFFFFFFFF";
	signal row1 : std_logic_vector(47 downto 0)  := x"F0000000000F";
	signal row2 : std_logic_vector(47 downto 0)  := x"F0000000000F";
	signal row3 : std_logic_vector(47 downto 0)  := x"F0000000000F";
	signal row4 : std_logic_vector(47 downto 0)  := x"F0000000000F";
	signal row5 : std_logic_vector(47 downto 0)  := x"F0000000000F";
	signal row6 : std_logic_vector(47 downto 0)  := x"F0000000000F";
	signal row7 : std_logic_vector(47 downto 0)  := x"F0000000000F";
	signal row8 : std_logic_vector(47 downto 0)  := x"F0000000000F";
	signal row9 : std_logic_vector(47 downto 0)  := x"F0000000000F";
	signal row10 : std_logic_vector(47 downto 0) := x"F0000000000F";
	signal row11 : std_logic_vector(47 downto 0) := x"FFFFFFFFFFFF";
	
begin
	bomb_explode : process(clk_state, rst_state)
	begin
		-- TODO : player and block collision, change rows and player_enable
	end process bomb_explode;
end game_state_behav;