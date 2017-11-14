library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pixel_gen_ent is
	port(
		row : in std_logic_vector(8 downto 0);
		col : in std_logic_vector(9 downto 0);
		rst_pixel : in std_logic;
		red : out std_logic_vector(3 downto 0); 
		green : out std_logic_vector(3 downto 0);
		blue : out std_logic_vector(3 downto 0)
	);
end pixel_gen_ent;

architecture pixel_gen_behav of pixel_gen_ent is

begin


end pixel_gen_behav;

