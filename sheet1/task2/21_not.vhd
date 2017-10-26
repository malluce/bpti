entity not_ent is
	port (
		a_not : in bit;
		b_not : out bit
	);
end not_ent;

architecture behaviour_not of not_ent is
begin
	not_process : process(a_not)
	begin
		b_not <= not a_not;
	end process not_process;
end behaviour_not;
	
