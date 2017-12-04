library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bomb is
	port(
		clk_bomb : in std_logic;
		rst_bomb : in std_logic;
		x_player : in std_logic_vector(9 downto 0);
		y_player : in std_logic_vector(8 downto 0);
		input : in std_logic; -- TODO: what do we get as input?
		row : out std_logic_vector(3 downto 0);
		col : out std_logic_vector(3 downto 0);
		enable_bomb : out std_logic;
		explode : out std_logic
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