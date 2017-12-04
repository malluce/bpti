library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bomb is
	port(
		clk_bomb : in std_logic;
		rst_bomb : in std_logic;
		row0_bomb : std_logic_vector(47 downto 0);
		row1_bomb : std_logic_vector(47 downto 0);
		row2_bomb : std_logic_vector(47 downto 0);
		row3_bomb : std_logic_vector(47 downto 0);
		row4_bomb : std_logic_vector(47 downto 0);
		row5_bomb : std_logic_vector(47 downto 0);
		row6_bomb : std_logic_vector(47 downto 0);
		row7_bomb : std_logic_vector(47 downto 0);
		row8_bomb : std_logic_vector(47 downto 0);
		row9_bomb : std_logic_vector(47 downto 0);
		row10_bomb : std_logic_vector(47 downto 0);
		row11_bomb : std_logic_vector(47 downto 0)
	);
end bomb;

architecture bomb_behav of bomb is

begin

	set_bomb : process(clk_bomb, rst_bomb)
	begin
		-- TODO
	end process set_bomb;
	
	bomb_tick : process(clk_bomb, rst_bomb)
	begin
		-- TODO
	end process bomb_tick;
	
end bomb_behav;