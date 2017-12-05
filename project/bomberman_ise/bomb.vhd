library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bomb_ent is
	port(
		clk_bomb : in std_logic;
		rst_bomb : in std_logic;
		col_player : in std_logic_vector(3 downto 0);
		row_player : in std_logic_vector(3 downto 0);
		plant_bomb : in std_logic;
		row0_bomb : in std_logic_vector(59 downto 0);
		row1_bomb : in std_logic_vector(59 downto 0);
		row2_bomb : in std_logic_vector(59 downto 0);
		row3_bomb : in std_logic_vector(59 downto 0);
		row4_bomb : in std_logic_vector(59 downto 0);
		row5_bomb : in std_logic_vector(59 downto 0);
		row6_bomb : in std_logic_vector(59 downto 0);
		row7_bomb : in std_logic_vector(59 downto 0);
		row8_bomb : in std_logic_vector(59 downto 0);
		row9_bomb : in std_logic_vector(59 downto 0);
		row10_bomb : in std_logic_vector(59 downto 0);
		row11_bomb : in std_logic_vector(59 downto 0);
		row12_bomb : in std_logic_vector(59 downto 0);
		row13_bomb : in std_logic_vector(59 downto 0);
		row14_bomb : in std_logic_vector(59 downto 0);
		row_bomb : out std_logic_vector(3 downto 0);
		col_bomb : out std_logic_vector(3 downto 0);
		enable_bomb : out std_logic;
		explode_bomb : out std_logic
		);
end bomb_ent;

architecture bomb_behav of bomb_ent is

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