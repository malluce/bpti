library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modi is
	port(
		slow_clk : in std_logic;
		modus : in std_logic;
		direction : in std_logic;
		reset : in std_logic;
		led1 : out std_logic;
		led2 : out std_logic;
		led3 : out std_logic;
		led4 : out std_logic;
		led5 : out std_logic;
		led6 : out std_logic;
		led7 : out std_logic;
		led8 : out std_logic
	);
end modi;

architecture modi_struct of modi is
	component modi_selector
		port(
			clock_sel : in std_logic;
			modus_sel : in std_logic;
			direction_sel : in std_logic;
			reset_sel : in std_logic;
			vector_sel : out std_logic_vector(7 downto 0)
		);
	end component;
	
	component set_led
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
	end component;
	
	signal vector_fwd : std_logic_vector(7 downto 0);
	
begin

	my_modi_sel : modi_selector port map(
		slow_clk, modus, direction, reset, vector_fwd
	);
	
	my_set_led : set_led port map(
		vector_fwd, led1, led2, led3, led4, led5, led6, led7, led8
	);
	
end modi_struct;

