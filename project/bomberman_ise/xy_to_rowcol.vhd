library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xy_to_rowcol_ent is
	generic(PLAYER_SIZE_CONV, TILE_SIZE_CONV : integer);
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
		variable x_int : integer range 0 to 480;
		variable y_int : integer range 0 to 480;
		variable col_int : integer range 0 to ((480 / TILE_SIZE_CONV) - 1);
		variable row_int : integer range 0 to ((480 / TILE_SIZE_CONV) - 1)
	begin
		x_int := to_integer(unsigned(x_convert));
		y_int := to_integer(unsigned(y_convert));
		col_int := (x_int + (PLAYER_SIZE_CONV / 2) - 1) / TILE_SIZE_CONV;
		row_int := (y_int + (PLAYER_SIZE_CONV / 2) - 1) / TILE_SIZE_CONV;
		col_convert <= std_logic_vector(to_unsigned(col_int, 4));
		row_convert <= std_logic_vector(to_unsigned(row_int, 4));
	end process convert;
	
end xy_to_rowcol_behav;