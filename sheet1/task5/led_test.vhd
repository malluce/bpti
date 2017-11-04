library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_ent is
	port(
		in_led : in std_logic;
		rst_led : in std_logic;
		out_led : out std_logic
	);
end led_ent;

architecture struct_led of led_ent is
	component counter_ent
		port(clk : in std_logic; rst : in std_logic; b : out std_logic);
	end component;
	component myDCM2
		port(
			CLKIN_IN : IN std_logic;
			RST_IN : IN std_logic;          
			CLKDV_OUT : OUT std_logic;
			CLK0_OUT : OUT std_logic;
			LOCKED_OUT : OUT std_logic);
	end component;
	
	signal led_fwd : std_logic;
	begin
		cnt : counter_ent port map(led_fwd, rst_led, out_led);
		my_dcm : myDCM2 port map(CLKIN_IN => in_led,RST_IN => rst_led,CLKDV_OUT => led_fwd);
end struct_led;