library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity run_light is
	port(
		clock_in : in std_logic;
		modus_in : in std_logic;
		direction_in : in std_logic;
		speed_up_in : in std_logic;
		speed_down_in : in std_logic;
		reset_in : in std_logic;
		dip1_in : in std_logic;
		dip2_in : in std_logic;
		dip3_in : in std_logic;
		dip4_in : in std_logic;
		dip5_in : in std_logic;
		dip6_in : in std_logic;
		dip7_in : in std_logic;
		dip8_in : in std_logic;
		led1_out : out std_logic;
		led2_out : out std_logic;
		led3_out : out std_logic;
		led4_out : out std_logic;
		led5_out : out std_logic;
		led6_out : out std_logic;
		led7_out : out std_logic;
		led8_out : out std_logic
	);
end run_light;

architecture run_light_struct of run_light is
	component led_ent
		port(
		in_led : in std_logic;
		rst_led : in std_logic;
		speed_up_led : in std_logic;
		speed_down_led : in std_logic;
		out_led : out std_logic
		);
	end component;
	
	component modi
		port(
			slow_clk : in std_logic;
			modus : in std_logic;
			direction : in std_logic;
			reset : in std_logic;
			dip1 : in std_logic;
			dip2 : in std_logic;
			dip3 : in std_logic;
			dip4 : in std_logic;
			dip5 : in std_logic;
			dip6 : in std_logic;
			dip7 : in std_logic;
			dip8 : in std_logic;
			led1 : out std_logic;
			led2 : out std_logic;
			led3 : out std_logic;
			led4 : out std_logic;
			led5 : out std_logic;
			led6 : out std_logic;
			led7 : out std_logic;
			led8 : out std_logic
		);
	end component;
	
	signal slow_clk_fwd : std_logic;
	
begin
	led : led_ent port map(
		clock_in,
		reset_in,
		speed_up_in,
		speed_down_in,
		slow_clk_fwd
	);

	my_modi : modi port map(
		slow_clk_fwd,
		modus_in,
		direction_in,
		reset_in,
		dip1_in,
		dip2_in,
		dip3_in,
		dip4_in,
		dip5_in,
		dip6_in,
		dip7_in,
		dip8_in,
		led1_out,
		led2_out,
		led3_out,
		led4_out,
		led5_out,
		led6_out,
		led7_out,
		led8_out
	);

end run_light_struct;

