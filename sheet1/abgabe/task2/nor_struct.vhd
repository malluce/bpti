library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nor_ent is
	port (
		a_nor : in std_logic;
		b_nor : in std_logic;
		c_nor : out std_logic
	);
end nor_ent;

architecture structure_nor of nor_ent is
	component or_ent
		port (a_or : in std_logic; b_or : in std_logic; c_or : out std_logic);
	end component;

	component not_ent
		port (a_not : in std_logic; b_not : out std_logic);
	end component;

	signal s1 : std_logic;
begin
	t1 : or_ent port map (a_nor, b_nor, s1);
	t2 : not_ent port map (s1, c_nor);  
end structure_nor;
