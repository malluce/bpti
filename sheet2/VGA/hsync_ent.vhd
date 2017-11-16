library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hsync_ent is
	port(
		clk_hsync : in std_logic;
		rst_hsync : in std_logic;
		hsync_out : out std_logic;
		col_hsync : out std_logic_vector(9 downto 0)
	);
end hsync_ent;

architecture hsync_behav of hsync_ent is

begin

	hsync_proc : process(clk_hsync, rst_hsync)
		variable toggle_cnt : std_logic := '0';
		variable cnt_high : integer range 1 to 704 := 1; 
		variable cnt_low : integer range 1 to 97 := 1;
		variable cnt_col : integer range 1 to 640 := 1;
	begin
		if(rst_hsync = '0') then
			toggle_cnt := '0';
			cnt_high := 1;
			cnt_low := 1;
			hsync_out <= '1';
			col_hsync <= "0000000001";
		elsif(clk_hsync'event and clk_hsync = '1') then
			if(toggle_cnt = '0') then
				hsync_out <= '1';
				if(cnt_high > 45 and cnt_high < 685) then
					cnt_col := cnt_col + 1;
					col_hsync <= std_logic_vector(to_unsigned(cnt_col, 10));
				else
					col_hsync <= "0000000000";
				end if;
				if(cnt_high = 685) then
					cnt_col := 1;
				end if;
				if(cnt_high = 704) then
					cnt_high := 1;
					toggle_cnt := '1';
				end if;
				cnt_high := cnt_high + 1;
			else
				hsync_out <= '0';
				if(cnt_low = 96) then
					cnt_low := 1;
					toggle_cnt := '0';
				else 
					cnt_low := cnt_low + 1;
				end if;
			end if;
		end if;
	end process hsync_proc;


end hsync_behav;

