library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hsync_ent is
	port(
		clk_hsync : in std_logic;
		rst_hsync : in std_logic;
		hsync_out : out std_logic;
		col_hsync : out std_logic_vector(9 downto 0);
		row_hsync : out std_logic_vector(8 downto 0)
	);
end hsync_ent;

architecture hsync_behav of hsync_ent is
		-- indicates whether to set or not to set hsync_out to 0 in the next (!) cycle
		signal set_0 : std_logic := '0';
		-- counts the cycles hsync_out is high (i.e. '1')
		signal cnt_high : integer range 0 to 703 := 0; 
		-- counts the cycles hsync_out is high (i.e. '0')
		signal cnt_low : integer range 0 to 96 := 0;
		-- generates the column counter
		signal cnt_col : integer range 0 to 640 := 0;
		
		signal cnt_row : integer range 0 to 480 := 0;
		signal cnt_times : integer range 0 to 525 := 1;
begin

	hsync_proc : process(clk_hsync, rst_hsync)
	begin
		if(rst_hsync = '0') then -- async reset
			set_0 <= '0';
			cnt_high <= 1;
			cnt_low <= 1;
			hsync_out <= '1';
			col_hsync <= "0000000001";
			cnt_col <= 0;
			cnt_row <= 0;
			cnt_times <= 1;
			
		elsif(clk_hsync'event and clk_hsync = '1') then
			if(set_0 = '0') then -- do not set hsync_out to '0'
				hsync_out <= '1';
				
				if(cnt_times = 525) then
						cnt_times <= 1;
				end if;
				
				if(cnt_high = 685) then
					if(cnt_times >= 30 and cnt_times < 510) then
						cnt_row <= cnt_row + 1;
					end if;
					if(cnt_times = 511) then
						cnt_row <= 0;
					end if;
				end if;
				
				if(cnt_high = 703) then 
		
					
					if cnt_times /= 525 then 
						cnt_times <= cnt_times + 1;
					end if;
					cnt_high <= 0; -- set to 0, because cnt_high is also incremented when changing from 0 to 1
					set_0 <= '1'; -- hsync_out should be 0 in next cycle (=cycle 704)
				else
					cnt_high <= cnt_high + 1;
					if(cnt_high = 684) then -- set column counter and output in range
						cnt_col <= 0;
					-- !!problem hier irgendwo: setzen letzte row nicht!!
					-- lösung vlt den fall aufspalten (einmal col erhöhen, einmal row und col-ausgänge setzen) -> dannn kein overflow beim hochzählen von col, trotzdem wird letzte row gesetzt?
					elsif(cnt_high >= 44 and cnt_high < 684 and cnt_times >= 30 and cnt_times < 510) then
						cnt_col <= cnt_col + 1;
						row_hsync <= std_logic_vector(to_unsigned(cnt_row, 9));
						col_hsync <= std_logic_vector(to_unsigned(cnt_col + 1, 10));
					else
						col_hsync <= "0000000000";
						row_hsync <= "000000000";					
					end if;
				end if;
			else
				hsync_out <= '0';
				if(cnt_low = 95) then 
					cnt_low <= 0;
					set_0 <= '0';
				else 
					cnt_low <= cnt_low + 1;
				end if;
			end if;
		end if;
	end process hsync_proc;


end hsync_behav;

