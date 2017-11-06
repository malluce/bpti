library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nor_ent is
	port (
		a_nor : in std_logic;
		b_nor : in std_logic;
		c_nor : out std_logic
	);
end nor_ent;

architecture behaviour_nor of nor_ent is
begin
	nor_process : process(a_nor, b_nor)
	begin
		if a_nor = '0' and b_nor = '0' then
			c_nor <= '1';
		else 
			c_nor <= '0';
		end if;
	end process nor_process;
end behaviour_nor;