library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rgb_assign_ent is
	port(
		red_assign : in std_logic_vector(3 downto 0);
		green_assign : in std_logic_vector(3 downto 0);
		blue_assign : in std_logic_vector(3 downto 0);
		red_assign_0 : out std_logic;
		red_assign_1 : out std_logic;
		red_assign_2 : out std_logic;
		red_assign_3 : out std_logic;
		green_assign_0 : out std_logic;
		green_assign_1 : out std_logic;
		green_assign_2 : out std_logic;
		green_assign_3 : out std_logic
		blue_assign_0 : out std_logic;
		blue_assign_1 : out std_logic;
		blue_assign_2 : out std_logic;
		blue_assign_3 : out std_logic
	);
end rgb_assign_ent;

architecture rgb_assign_behav of rgb_assign_ent is

begin
	assign_proc : process(red_assign, green_assign, blue_assign)
	begin
		red_assign_0 <= red_assign(0);
		red_assign_1 <= red_assign(1);
		red_assign_2 <= red_assign(2);
		red_assign_3 <= red_assign(3);
		green_assign_0 <= green_assign(0);
		green_assign_1 <= green_assign(1);
		green_assign_2 <= green_assign(2);
		green_assign_3 <= green_assign(3);
		blue_assign_0 <= blue_assign(0);
		blue_assign_1 <= blue_assign(1);
		blue_assign_2 <= blue_assign(2);
		blue_assign_3 <= blue_assign(3);
	end process assign_proc;

end rgb_assign_behav;
