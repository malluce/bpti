library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_movement_ent is
	port (
		clk_in : in std_logic;
		clk_out : out std_logic 
	);
end clk_movement_ent;

architecture counter_behav of clk_movement_ent is
    constant MAX : integer range 0 to 78124 := 78124;
    signal cnt : integer range 0 to 78124 := 0;
    signal temp : std_logic := '0';
    
begin
	count : process(clk)
	begin
		if clk'event and clk = '1' then
			if cnt = MAX then
				cnt <= 0;
				temp <= not temp;
			else
				cnt <= cnt + 1;
			end if;
			clk_out <= temp;
		end if; 
	end process count;
end counter_behav;
