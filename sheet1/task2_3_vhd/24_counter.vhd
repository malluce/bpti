entity counter_ent is
	port (
		clk : in bit;
		b : out bit 
	);
end counter_ent;

architecture behaviour_counter of counter_ent is
    constant max : integer range 0 to 100 := 100;
    signal cnt : integer range 0 to 100 := 0;
begin
	count_process : process(clk)
	begin
		if clk'event and clk = '1' then
			cnt <= cnt + 1;
		  if cnt = (max - 1) then
                b <= '1';
                cnt <= 0;
      end if;
		else
			b <= '0';
		end if;
	end process count_process;
end behaviour_counter;
