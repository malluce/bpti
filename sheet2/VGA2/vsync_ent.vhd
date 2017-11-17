library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vsync_ent is
	port(
		hsync_in : in std_logic;
		rst_vsync : in std_logic;
		vsync_out : out std_logic
	);
end vsync_ent;

architecture vsync_behav of vsync_ent is
	signal cnt_high : integer range 0 to 524 :=  0; 
	signal set_0 : std_logic := '0';
begin
	
	vsync_proc : process(hsync_in, rst_vsync)
	begin
		if(rst_vsync = '0') then
			cnt_high <= 0;
			set_0 <= '0';
			vsync_out <= '1';
		elsif(hsync_in'event and hsync_in = '1') then
			if(set_0 = '0') then
				vsync_out <= '1';

				if(cnt_high = 522) then
					cnt_high <= 0;
					set_0 <= '1';
				else
					cnt_high <= cnt_high + 1;
				end if;
			else
				vsync_out <= '0';
				set_0 <= '0';
			end if;
		end if;
	end process vsync_proc;
end vsync_behav;