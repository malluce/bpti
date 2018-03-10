library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- basically a demux for rgb vectors for getting the signals for the single pins (e.g red-vector -> red<0>)
entity rgb_assign_ent is
	port(
		--values of the colors in a vector
		red_assign : in std_logic_vector(3 downto 0);
		green_assign : in std_logic_vector(3 downto 0);
		blue_assign : in std_logic_vector(3 downto 0);

		--single bits for every color
		red_0_assign : out std_logic;
		red_1_assign : out std_logic;
		red_2_assign : out std_logic;
		red_3_assign : out std_logic;
		green_0_assign : out std_logic;
		green_1_assign : out std_logic;
		green_2_assign : out std_logic;
		green_3_assign : out std_logic;
		blue_0_assign : out std_logic;
		blue_1_assign : out std_logic;
		blue_2_assign : out std_logic;
		blue_3_assign : out std_logic
	);
end rgb_assign_ent;

architecture rgb_assign_behav of rgb_assign_ent is

begin
	assign_proc : process(red_assign, green_assign, blue_assign)
	begin
		--set the individual bits from the input vectors
		red_0_assign <= red_assign(0);
		red_1_assign <= red_assign(1);
		red_2_assign <= red_assign(2);
		red_3_assign <= red_assign(3);
		green_0_assign <= green_assign(0);
		green_1_assign <= green_assign(1);
		green_2_assign <= green_assign(2);
		green_3_assign <= green_assign(3);
		blue_0_assign <= blue_assign(0);
		blue_1_assign <= blue_assign(1);
		blue_2_assign <= blue_assign(2);
		blue_3_assign <= blue_assign(3);
	end process assign_proc;

end rgb_assign_behav;
