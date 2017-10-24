entity and_or is
	port (
		a : in bit;
		b : in bit;
		c : out bit
	);
end and_or;

entity not_ent is
	port (
		a : in bit;
		b : out bit
	);
end not_ent;

architecture structure_nand of and_or is
	component and_or
		port (a_in : in bit; b_in : in bit; c_out : out bit);
	end component;

	component not_ent
		port (ain : in bit; bout : out bit);
	end component;

	signal s1 : bit;
begin
	t1 : and_or port map (c_out => s1, a_in => a, b_in => b);
	t2 : not_ent port map (ain => s1, bout => c);  
end structure_nand;