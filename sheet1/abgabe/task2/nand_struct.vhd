library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_ent is
	port (
		a_nand : in std_logic;
		b_nand : in std_logic;
		c_nand : out std_logic
	);
end nand_ent;

architecture structure_nand of nand_ent is
	component and_ent
		port (a_and : in std_logic; b_and : in std_logic; c_and : out std_logic);
	end component;

	component not_ent
		port (a_not : in std_logic; b_not : out std_logic);
	end component;

	signal s1 : std_logic;
begin
	t1 : and_ent port map (a_nand, b_nand, s1);
	t2 : not_ent port map (s1, c_nand);  
end structure_nand;