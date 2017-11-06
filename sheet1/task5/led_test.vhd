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
	
	component set_led_ent
		port (slow_clk : in std_logic; rst : in std_logic; set_led : out std_logic);
	end component;
	
	component not_ent
	  port (a_not : in std_logic; b_not : out std_logic);
	end component; 
	 
	signal led_fwd : std_logic;
	signal counter_to_set : std_logic;
	signal not_to_dcm : std_logic;
	
	begin
		set : set_led_ent port map (counter_to_set, rst_led, out_led);
		cnt : counter_ent port map(led_fwd, rst_led, counter_to_set);
		not_for_rst : not_ent port map (rst_led, not_to_dcm);
		my_dcm : myDCM2 port map(CLKIN_IN => in_led,RST_IN => not_to_dcm,CLKDV_OUT => led_fwd);
end struct_led;