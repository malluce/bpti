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
	 -- minimum speed : count to 31250000 => b is 1 every 4 seconds
	 constant MIN_SPEED : integer range 0 to 31250000 := 31250000;
	 -- maximum speed : counter to 488281 => b is 1 every 0,06 seconds
	 constant MAX_SPEED : integer range 0 to 488281 := 488281;
	 -- number added/subtracted from/to count when pressing speed_up or speed_down
	 constant MULTIPLIER : integer range 0 to 250000 := 250000;
	 -- initial speed : b is 1 every 0,5 seconds
	 constant SPEED_INIT : integer range 0 to 3906250 := 3906250;
    signal cnt : integer range 0 to 31250000 := 0;
	 signal speed : integer range 0 to MIN_SPEED := SPEED_INIT;
	 signal up_button_pressed : std_logic := '0';
	 signal down_button_pressed : std_logic := '0';
begin
	-- process to slow incoming clock by counting
	count_process : process(clk, rst)
	begin
		if rst = '0' then
			cnt <= 0;
			b <= '0';
		else
			-- count logic (it is an impuls to speek in words of task 2)
			if clk'event and clk = '1' then
				if cnt >= speed then
					b <= '1';
					cnt <= 0;
				else 
				  b <= '0';
				  cnt <= cnt + 1;
				end if;
			end if; 
		end if;
	end process count_process;
	
	-- process to adjust speed when button pressed
	speed_proc : process(clk, rst)
	begin
		if rst = '0' then
			speed <= SPEED_INIT;
			up_button_pressed <= '0';
			down_button_pressed <= '0';
		elsif clk'event and clk = '1' then	
			if  speed_up = '1' and speed > MAX_SPEED and up_button_pressed = '0' then
				speed <= speed - MULTIPLIER;
				up_button_pressed <= '1';
			elsif speed_down ='1' and speed < MIN_SPEED and down_button_pressed = '0' then
				speed <= speed + MULTIPLIER;
				down_button_pressed <= '1';	
			-- reset up_button_pressed and down_button_pressed when button is not pressed anymore
			elsif speed_up = '0' and up_button_pressed = '1' then
				up_button_pressed <= '0';
			elsif speed_down = '0' and down_button_pressed = '1' then
				down_button_pressed <= '0';
			end if;
		end if;
	end process speed_proc;
end behaviour_counter;
