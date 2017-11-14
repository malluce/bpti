library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vsync_ent is
	port(
		hsync_in : in std_logic;
		rst_vsync : in std_logic;
		row_vsync : out std_logic_vector(8 downto 0);
		vsync_out : out std_logic
	);
end vsync_ent;

architecture vsync_behav of vsync_ent is

begin


end vsync_behav;

