library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xy_to_rowcol_ent is
	port(
		x_convert : in std_logic_vector(8 downto 0);
		y_convert : in std_logic_vector(8 downto 0);
		row_convert : out std_logic_vector(3 downto 0);
		col_convert : out std_logic_vector(3 downto 0)
	);
end xy_to_rowcol_ent;

architecture xy_to_rowcol_behav of xy_to_rowcol_ent is
	
begin

	convert : process(x_convert, y_convert)
	begin
		-- TODO
	end process convert;
	
end xy_to_rowcol_behav;