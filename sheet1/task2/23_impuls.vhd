entity counter is
	port (
		clk : in bit;
		b : out bit 
	);
end counter;

architecture behaviour_counter of counter is
    constant max : integer range 0 to 100 := 100;
    signal cnt : integer range 0 to 100 := 0;
begin
	count_process : process(clk)
	begin
		if clk'event and clk = '1' then
			cnt <= cnt + 1;
		end if;
		if cnt = (max - 1) then
			b <= '1';
			cnt <= 0;
		else
			b <= '0';
		end if;
	end count_process;
end behaviour_counter;

