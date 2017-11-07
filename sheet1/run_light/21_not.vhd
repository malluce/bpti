library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_ent is
	port (
		a_not : in std_logic;
		b_not : out std_logic
	);
end not_ent;

architecture behaviour_not of not_ent is
begin
	not_process : process(a_not)
	begin
		b_not <= not a_not;
	end process not_process;
end behaviour_not;
	
