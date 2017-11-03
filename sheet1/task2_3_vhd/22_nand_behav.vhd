library ieee;
use ieee.std_logic_1164.all;

entity nand_ent is
	port (
		a_nand : in std_logic;
		b_nand : in std_logic;
		c_nand : out std_logic
	);
end nand_ent;

architecture behaviour_nand of nand_ent is
begin
	nand_process : process(a_nand, b_nand)
	begin
		if a_nand = '1' and b_nand = '1' then
			c_nand <= '0';
		else 
			c_nand <= '1';
		end if;
	end process nand_process;
end behaviour_nand;