library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_ent is
	port (
		a_and : in std_logic;
		b_and : in std_logic;
		c_and : out std_logic
	);
end and_ent;

architecture behaviour_and of and_ent is
begin
	and_process : process(a_and, b_and)
	begin
		if a_and = '1' and b_and = '1' then
			c_and <= '1';
		else 
			c_and <= '0';
		end if;
	end process and_process;
end behaviour_and;