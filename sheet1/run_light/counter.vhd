library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_ent is
	port (
		clk : in std_logic;
		rst : in std_logic;
		speed_up : in std_logic;
		speed_down : in std_logic;
		b : out std_logic 
	);
end counter_ent;

architecture behaviour_counter of counter_ent is
	 constant MIN : integer range 0 to 31250000 := 31250000;
	 constant MAX : integer range 0 to 488281 := 488281;
	 constant MULTIPLIER : integer range 0 to 250000 := 250000;
	 constant SPEED_INIT : integer range 0 to 3906250 := 3906250;
    signal cnt : integer range 0 to 31250000 := 0;
	 shared variable speed : integer := SPEED_INIT;
begin
	count_process : process(clk, rst)
	begin
		if rst = '0' then
			cnt <= 0;
			b <= '0';
		else
			if clk'event and clk = '1' then
				if cnt = speed then
					b <= '1';
					cnt <= 0;
				else 
				  b <= '0';
				  cnt <= cnt + 1;
				end if;
			end if; 
		end if;
	end process count_process;
	
	speed_proc : process(speed_up, speed_down, rst)
	begin
		if rst = '0' then
			speed := SPEED_INIT;
	   elsif  speed_up = '1' and (speed - MULTIPLIER) > MIN then
			speed := speed - MULTIPLIER;
		elsif speed_down ='1' and (speed + MULTIPLIER) < MAX then
			speed := speed + MULTIPLIER;
		else
			speed := speed;
		end if;
	end process speed_proc;
end behaviour_counter;
