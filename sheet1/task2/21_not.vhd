entity not_ent is
	port (
		a : in bit;
		b : out bit
	);
end not;

architecture behaviour_not of not_ent is
begin
	not_process : process(a)
	begin
		b <= not a;
	end process not_process;
end behaviour_not;
	
