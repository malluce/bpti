library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity movement_ent is
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
end movement_ent;

architecture movement_behav of movement_ent is
	variable x_int : integer range 0 to 480 := 1;
	variable y_int : integer range 0 to 480 := 1;
begin

	collission : process(clk_move, rst_move)
	
	begin
		-- TODO
		
		x_move <= std_logic_vector(to_unsigned(x_int, 9));
		y_move <= std_logic_vector(to_unsigned(x_int, 9));
	end process collission;
end movement_behav;