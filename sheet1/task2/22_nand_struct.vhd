entity nand_ent is
	port (
		a_nand : in bit;
		b_nand : in bit;
		c_nand : out bit
	);
end nand_ent;

entity and_ent is
  port (
    a_and : in bit;
    b_and : in bit;
    c_and : out bit
  );
end and_ent;

entity not_ent is
	port (
		a_not : in bit;
		b_not : out bit
	);
end not_ent;

architecture structure_nand of nand_ent is
	component and_ent
		port (a_and : in bit; b_and : in bit; c_and : out bit);
	end component;

	component not_ent
		port (a_not : in bit; b_not : out bit);
	end component;

	signal s1 : bit;
begin
	t1 : and_ent port map (a_nand, b_nand, s1);
	t2 : not_ent port map (s1, c_nand);  
end structure_nand;