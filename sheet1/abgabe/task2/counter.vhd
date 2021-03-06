library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_ent is
	port (
		clk : in std_logic;
		b : out std_logic 
	);
end counter_ent;

architecture behaviour_counter of counter_ent is
    constant MAX : integer range 0 to 100 := 100;
    signal cnt : integer range 0 to 100 := 0;
    signal was_1 : std_logic := '0';
    
begin
	count_process : process(clk)
	begin
			if clk'event then
			  if clk = '1' then 
				  if cnt = MAX then
					 b <= '1';
					 cnt <= 0;
					 was_1 <= '1';
				  else
				    b <= '0';
				    cnt <= cnt + 1;
				  end if;
				 else 
				    if was_1 = '1' then -- 0 in second half of clock cycle when the counter had overflow (not impuls anymore)
				     b <= '0';
				     was_1 <= '0';
				    end if; 
				  end if;
			end if; 
	end process count_process;
end behaviour_counter;
