library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xy_to_rowcol is
	port(
		x : in std_logic_vector(9 downto 0);
		y : in std_logic_vector(8 downto 0);
		row : out std_logic_vector(3 downto 0);
		col : out std_logic_vector(3 downto 0)
	);
end xy_to_rowcol;

architecture xy_to_rowcol_behav of xy_to_rowcol is
	
begin

	convert : process(x, y)
	begin
		-- TODO
	end process convert;
	
end xy_to_rowcol_behav;