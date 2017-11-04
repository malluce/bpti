library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity set_led_ent is
	port(
		slow_clk : in std_logic;
		set_led : out std_logic;
	);
end set_led_ent;

architecture behaviour_set_led of set_led_ent is
    signal led_was_set : std_logic := '0';
begin
	set_process : process(slow_clk)
	begin
		if slow_clk'event and slow_clk = '1' then
			if led_was_set = '1' then
				set_led <= '0';
				led_was_set <= '0';
			else 
				set_led <= '1';
				led_was_set <= '1';
		end if;
	end process count_process;
end behaviour_counter;