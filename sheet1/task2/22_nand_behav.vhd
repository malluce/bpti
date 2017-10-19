entity and_or is
	port (
		a : in bit;
		b : in bit;
		c : out bit
	);
end and_or;

architecture behaviour_nand of and_or is
begin
	nand_process : process(a, b)
	begin
		if a = '1' and b = '1' then
			c <= '0';
		else 
			c <= '1';
		end if;
	end process nand_process;
end behaviour_nand;