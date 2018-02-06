library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- divides the clk_in clock (in our case: the vga clock) so clk_out can be used for the movement entity
entity clk_movement_ent is
	port (
		rst_clk : in std_logic;
		clk_in : in std_logic;
		clk_out : out std_logic
	);
end clk_movement_ent;

architecture counter_behav of clk_movement_ent is
    constant MAX : integer range 0 to 78124 := 1;
    signal cnt : integer range 0 to 78124 := 0;
    signal temp : std_logic := '0';

begin
	count : process(clk_in, rst_clk)
	begin
		if rst_clk = '0' then
			cnt <= 0;
			temp <= '0';
		elsif clk_in'event and clk_in = '1' then
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
