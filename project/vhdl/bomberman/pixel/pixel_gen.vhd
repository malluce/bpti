library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pixel_gen_ent is
	port(
        row_pixel : in std_logic_vector(8 downto 0);
        col_pixel : in std_logic_vector(9 downto 0);
        p1_x_coord_pixel : in std_logic_vector(9 downto 0);
        p1_y_coord_pixel : in std_logic_vector(8 downto 0);
        p1_enable_pixel : in std_logic;
        p2_x_coord_pixel : in std_logic_vector(9 downto 0);
        p2_y_coord_pixel : in std_logic_vector(8 downto 0);
        p2_enable_pixel : in std_logic;
        row0_pixel : in std_logic_vector(47 downto 0);
        row1_pixel : in std_logic_vector(47 downto 0);
        row2_pixel : in std_logic_vector(47 downto 0);
        row3_pixel : in std_logic_vector(47 downto 0);
        row4_pixel : in std_logic_vector(47 downto 0);
        row5_pixel : in std_logic_vector(47 downto 0);
        row6_pixel : in std_logic_vector(47 downto 0);
        row7_pixel : in std_logic_vector(47 downto 0);
        row8_pixel : in std_logic_vector(47 downto 0);
        row9_pixel : in std_logic_vector(47 downto 0);
        row10_pixel : in std_logic_vector(47 downto 0);
        row11_pixel : in std_logic_vector(47 downto 0)
		red_pixel : out std_logic_vector(3 downto 0);
		green_pixel : out std_logic_vector(3 downto 0);
		blue_pixel : out std_logic_vector(3 downto 0)
	);
end pixel_gen_ent;

architecture pixel_gen_behav of pixel_gen_ent is
begin
	pixel_proc : process(row_pixel, col_pixel, p1_x_coord_pixel, p1_y_coord_pixel, p1_enable_pixel, p2_x_coord_pixel, p2_y_coord_pixel, p2_enable_pixel, 
							row0_pixel, row1_pixel, row2_pixel, row3_pixel, row4_pixel, row5_pixel, row6_pixel, row7_pixel, row8_pixel, row9_pixel, row10_pixel, row11_pixel)
		variable row_int : integer range 0 to 480 := 1;
		variable col_int : integer range 0 to 640 := 1;
		variable x_rect_int : integer range 1 to 640 := 1;
		variable y_rect_int : integer range 1 to 480 := 1;
		variable red_int : integer range 0 to 15 := 0;
		variable green_int : integer range 0 to 15 := 0;
		variable blue_int : integer range 0 to 15 := 0;
	begin
		row_int := to_integer(unsigned(row_pixel));
		col_int := to_integer(unsigned(col_pixel));
		if(col_int /= 0 and row /= 0) then	
			if(row_pixel <= 120) then
				red_pixel <= x"F";
				green_pixel <= x"F";
				blue_pixel <= x"F";
			else
			-- TODO player
				case (row_int / 12) is -- can div 12 be synthesized?
					when 0 => ; -- lookup in row0_pixel
					-- etc.
				end case;
			end if;
		end if;
	end process border;
end pixel_gen_behav;