library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vsync_ent is
	port(
		hsync_in : in std_logic;
		rst_vsync : in std_logic;
		row_vsync : out std_logic_vector(8 downto 0);
		vsync_out : out std_logic
	);
end vsync_ent;

architecture vsync_behav of vsync_ent is
	signal cnt_high : integer range 0 to 524 :=  0; 
	signal next_0 : std_logic := '0';
	signal cnt_row : integer range 1 to 480 := 1;
begin
	
	vsync_proc : process(hsync_in, rst_vsync)
	begin
		if(rst_vsync = '0') then
			cnt_high <= 0;
			next_0 <= '0';
			vsync_out <= '1';
			row_vsync <= "000000001";
		elsif(hsync_in'event and hsync_in = '1') then
			if(next_0 = '0') then
				vsync_out <= '1';
				if(cnt_high > 31 and cnt_high <= 510) then
					cnt_row <= cnt_row + 1;
				end if;
				
				if(cnt_high = 523) then
					cnt_high <= 1;
					next_0 <= '1';
				else
					cnt_high <= cnt_high + 1;
				end if;
			
			else
				vsync_out <= '0';
				next_0 <= '0';
				
			end if;
			row_vsync <= std_logic_vector(to_unsigned(cnt_row, 9));
		end if;
	end process vsync_proc;


end vsync_behav;

