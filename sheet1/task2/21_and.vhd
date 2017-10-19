entity and_or is
	port (
		a : in bit;
		b : in bit;
		c : out bit
	);
end and_or;

architecture behaviour_and of and_or is
begin
	and_process : process(a, b)
	begin
		if a = '1' and b = '1' then
			c <= '1';
		else 
			c <= '0';
		end if;
	end process and_process;
end behaviour_and;