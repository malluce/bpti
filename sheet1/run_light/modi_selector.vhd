library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modi_selector is
	port(
		clock_sel : in std_logic;
		modus_sel : in std_logic;
		direction_sel : in std_logic;
		reset_sel : in std_logic;
		vector_sel : out std_logic_vector(7 downto 0)
	);
end modi_selector;

architecture modi_selector_behav of modi_selector is

begin


end modi_selector_behav;

