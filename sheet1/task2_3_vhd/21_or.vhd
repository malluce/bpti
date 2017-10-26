entity or_ent is
	port (
		a_or : in bit;
		b_or : in bit;
		c_or : out bit
	);
end or_ent;

architecture behaviour_or of or_ent is
begin
	or_process : process(a_or, b_or)
	begin
		if a_or = '0' and b_or = '0' then
			c_or <= '0';
		else 
			c_or <= '1';
		end if;
	end process or_process;
end behaviour_or;