library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_ent is
	port (
		clk : in std_logic;
		rst : in std_logic;
		b : out std_logic 
	);
end counter_ent;

architecture behaviour_counter of counter_ent is
    constant MAX : integer range 0 to 15625000 := 15625000;
    signal was_1 : std_logic := '0';
    signal cnt : integer range 0 to 15625000 := 0;
begin
	count_process : process(clk, rst)
	begin
		if rst = '0' then
			cnt <= 0;
			b <= '0';
		else
			if clk'event and clk = '1' then
			     if cnt = MAX then
			       b <= '1';
					cnt <= 0;
					was_1 <= '1';
				  else
					b <= '0';
					cnt <= cnt + 1;           
				  end if;
       elsif clk'event and clk = '0' then
        if was_1 = '1' then -- 0 in second half of clock cycle when the counter had overflow (not impuls anymore)
          b <= '0';
          was_1 <= '0';
        end if; 			
				end if;
			end if; 
	end process count_process;
end behaviour_counter;
