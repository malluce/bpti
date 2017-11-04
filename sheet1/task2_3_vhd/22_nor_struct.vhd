entity nor_ent is
	port (
		a_nor : in bit;
		b_nor : in bit;
		c_nor : out bit
	);
end nor_ent;

architecture structure_nor of nor_ent is
	component or_ent
		port (a_or : in bit; b_or : in bit; c_or : out bit);
	end component;

	component not_ent
		port (a_not : in bit; b_not : out bit);
	end component;

	signal s1 : bit;
begin
	t1 : or_ent port map (a_nor, b_nor, s1);
	t2 : not_ent port map (s1, c_nor);  
end structure_nor;
