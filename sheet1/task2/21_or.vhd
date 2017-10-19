entity and_or is
	port (
		a : in bit;
		b : in bit;
		c : out bit
	);
end and_or;

architecture behaviour_or of and_or is
begin
	or_process : process(a, b)
	begin
		if a = '0' and b = '0' then
			c <= '0';
		else 
			c <= '1';
		end if;
	end process or_process;
end behaviour_or;