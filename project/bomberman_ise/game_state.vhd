library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_state_ent is
	port(
		clk_state : in std_logic;
		rst_state : in std_logic;
		x_player1_state : in std_logic_vector(8 downto 0);
		y_player1_state : in std_logic_vector(8 downto 0);
		enable_player1_state : in std_logic;
		x_player2_state : in std_logic_vector(8 downto 0);
		y_player2_state : in std_logic_vector(8 downto 0);
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
		row0_state : out std_logic_vector(59 downto 0);
		row1_state : out std_logic_vector(59 downto 0);
		row2_state : out std_logic_vector(59 downto 0);
		row3_state : out std_logic_vector(59 downto 0);
		row4_state : out std_logic_vector(59 downto 0);
		row5_state : out std_logic_vector(59 downto 0);
		row6_state : out std_logic_vector(59 downto 0);
		row7_state : out std_logic_vector(59 downto 0);
		row8_state : out std_logic_vector(59 downto 0);
		row9_state : out std_logic_vector(59 downto 0);
		row10_state : out std_logic_vector(59 downto 0);
		row11_state : out std_logic_vector(59 downto 0);
		row12_state : out std_logic_vector(59 downto 0);
		row13_state : out std_logic_vector(59 downto 0);
		row14_state : out std_logic_vector(59 downto 0)
	);
end game_state_ent;

architecture game_state_behav of game_state_ent is
	-- TODO initial blocks INSIDE arena
	signal row0 : std_logic_vector(59 downto 0)  := x"FFFFFFFFFFFFFFF";
	signal row1 : std_logic_vector(59 downto 0)  := x"F0011111111100F";
	signal row2 : std_logic_vector(59 downto 0)  := x"F0F0F0F0F0F0F0F";
	signal row3 : std_logic_vector(59 downto 0)  := x"F1010101010101F";
	signal row4 : std_logic_vector(59 downto 0)  := x"F1F0F0F0F0F0F1F";
	signal row5 : std_logic_vector(59 downto 0)  := x"F1101010101011F";
	signal row6 : std_logic_vector(59 downto 0)  := x"F1F0F0F0F0F0F1F";
	signal row7 : std_logic_vector(59 downto 0)  := x"F1010101010101F";
	signal row8 : std_logic_vector(59 downto 0)  := x"F1F0F0F0F0F0F1F";
	signal row9 : std_logic_vector(59 downto 0)  := x"F1101010101011F";
	signal row10 : std_logic_vector(59 downto 0) := x"F1F0F0F0F0F0F1F";
	signal row11 : std_logic_vector(59 downto 0) := x"F1010101010101F";
	signal row12 : std_logic_vector(59 downto 0) := x"F0F0F0F0F0F0F0F";
	signal row13 : std_logic_vector(59 downto 0) := x"F0011111111100F";
	signal row14 : std_logic_vector(59 downto 0) := x"FFFFFFFFFFFFFFF";
	
begin
	bomb_explode : process(clk_state, rst_state)
	begin
		-- TODO : player and block collision, change rows and player_enable
		if(clk_state'event and clk_state = '1') then
			row0_state <= row0;
			row1_state <= row1;
			row2_state <= row2;
			row3_state <= row3;
			row4_state <= row4;
			row5_state <= row5;
			row6_state <= row6;
			row7_state <= row7;
			row8_state <= row8;
			row9_state <= row9;
			row10_state <= row10;
			row11_state <= row11;
			row12_state <= row12;
			row13_state <= row13;
			row14_state <= row14;
		end if;
	end process bomb_explode;
end game_state_behav;