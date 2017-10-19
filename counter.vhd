entity counter is
	port (
		clk : in bit;
		b : out bit 
	);
end counter;

architecture behaviour_counter of counter is
begin
	count_process : process(clk)
		variable cnt : integer range 0 to 100 := 0;
		variable max : integer range 0 to 100 := 100;
	begin
		if clk'event then
			cnt := cnt + 1;
		end if;
		if cnt = max then
			cnt := 0;
			if clk'event and clk='1' then
				b <= '1';
			elsif clk'event and clk='0' then
				b <= '0';
			end if;
		else
			b <= '0';
		end if;
	end count_process;
end behaviour_counter;
