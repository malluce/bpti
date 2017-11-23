library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity pixel_gen_ent is
	generic(width_rect, height_rect : positive);
	port(
		row : in std_logic_vector(8 downto 0);
		col : in std_logic_vector(9 downto 0);
		x_rect : in std_logic_vector(9 downto 0);
		y_rect : in std_logic_vector(8 downto 0);
		red : out std_logic_vector(3 downto 0); 
		green : out std_logic_vector(3 downto 0);
		blue : out std_logic_vector(3 downto 0)
	);
end pixel_gen_ent;

architecture pixel_gen_behav of pixel_gen_ent is

begin
	pixel_proc : process(row, col)
		variable row_int : integer range 0 to 480 := 1;
		variable col_int : integer range 0 to 640 := 1;
		variable x_rect_int : integer range 1 to 640 := 1;
		variable y_rect_int : integer range 1 to 480 := 1;
		variable red_int : integer range 0 to 15 := 0;
		variable green_int : integer range 0 to 15 := 0;
		variable blue_int : integer range 0 to 15 := 0;
		variable cnt : integer range 0 to 31 := 0;
	begin
		if(col /= "0000000000" and row /= "000000000") then
			row_int := to_integer(unsigned(row));
			col_int := to_integer(unsigned(col));
			x_rect_int := to_integer(unsigned(x_rect));
			y_rect_int := to_integer(unsigned(y_rect));
				if(y_rect_int + height_rect <= 480 and x_rect_int + width_rect <= 640) then
					
				end if;
				if(row_int >= y_rect_int and col_int >= x_rect_int
						and row_int < (y_rect_int + height_rect) and col_int < (x_rect_int + width_rect)) then
						red_int := 15;
						green_int := 0;
						blue_int := 0;				
				else
					red_int := 0;
					green_int := 0;
					blue_int := 0;
				end if;
		else 
			-- black (not allowed to set RGB here)
			red_int := 0;
			green_int := 0;
			blue_int := 0;
		end if;
		red <= std_logic_vector(to_unsigned(red_int, 4));
		green <= std_logic_vector(to_unsigned(green_int, 4));
		blue <= std_logic_vector(to_unsigned(blue_int, 4));
	end process pixel_proc;
end pixel_gen_behav;

