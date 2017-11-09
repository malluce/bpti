library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity set_led is
	port(
		vector_set : in std_logic_vector(7 downto 0);
		led1_set : out std_logic;
		led2_set : out std_logic;
		led3_set : out std_logic;
		led4_set : out std_logic;
		led5_set : out std_logic;
		led6_set : out std_logic;
		led7_set : out std_logic;
		led8_set : out std_logic
	);
end set_led;

architecture set_led_behav of set_led is

begin
	led_process : process(vector_set)
	begin
		led1_set <= vector_set(7);
		led2_set <= vector_set(6);
		led3_set <= vector_set(5);
		led4_set <= vector_set(4);
		led5_set <= vector_set(3);
		led6_set <= vector_set(2);
		led7_set <= vector_set(1);
		led8_set <= vector_set(0);
	end process led_process;

end set_led_behav;

