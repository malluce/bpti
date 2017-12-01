library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pixel_gen_ent is
	port(
        p1_x_coord_pixel : out std_logic_vector(9 downto 0);
        p1_y_coord_pixel : out std_logic_vector(9 downto 0);
        p1_enable_pixel : out std_logic;
        p2_x_coord_pixel : out std_logic_vector(9 downto 0);
        p2_y_coord_pixel : out std_logic_vector(9 downto 0);
        p2_enable_pixel : out std_logic;
        row0_pixel : out std_logic_vector(47 downto 0);
        row1_pixel : out std_logic_vector(47 downto 0);
        row2_pixel : out std_logic_vector(47 downto 0);
        row3_pixel : out std_logic_vector(47 downto 0);
        row4_pixel : out std_logic_vector(47 downto 0);
        row5_pixel : out std_logic_vector(47 downto 0);
        row6_pixel : out std_logic_vector(47 downto 0);
        row7_pixel : out std_logic_vector(47 downto 0);
        row8_pixel : out std_logic_vector(47 downto 0);
        row9_pixel : out std_logic_vector(47 downto 0);
        row10_pixel : out std_logic_vector(47 downto 0);
        row11_pixel : out std_logic_vector(47 downto 0)
		red_pixel : out std_logic_vector(3 downto 0);
		green_pixel : out std_logic_vector(3 downto 0);
		blue_pixel : out std_logic_vector(3 downto 0)
	);
end pixel_gen_ent;

architecture pixel_gen_behav of pixel_gen_ent is

end pixel_gen_behav;