entity and_or is
	port (
		a : in bit;
		b : in bit;
		c : out bit
	);
end and_or;

architecture behaviour_nor of and_or is
begin
	nor_process : process(a, b)
	begin
		if a = '0' and b = '0' then
			c <= '1';
		else 
			c <= '0';
		end if;
	end process nor_process;
end behaviour_nor;