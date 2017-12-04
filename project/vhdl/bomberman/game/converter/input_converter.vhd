library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity input_converter_ent is
	port(
		player_input_converter : in std_logic; -- TODO: what do we get as input?
		up_converter : out std_logic;
		down_converter : out std_logic;
		left_converter : out std_logic;
		right_converter : out std_logic;
		plant_converter : out std_logic
	);
end input_converter_ent;

architecture input_converter_behav of input_converter_ent is
begin
	convert : process(player_input_converter)
	begin
		-- TODO
	end process convert;
end input_converter_behav;