library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity pixel_gen_ent is
	port(
		row : in std_logic_vector(8 downto 0);
		col : in std_logic_vector(9 downto 0);
		red : out std_logic_vector(3 downto 0); 
		green : out std_logic_vector(3 downto 0);
		blue : out std_logic_vector(3 downto 0)
	);
end pixel_gen_ent;

architecture pixel_gen_behav of pixel_gen_ent is

begin
	pixel_proc : process(row, col)
		variable row_int : integer range 0 to 480 := 1;
		variable col_int : integer range 0 to 640 := 1;
	begin
		if(col /= "0000000000" and row /= "000000000") then
			row_int := to_integer(unsigned(row));
			col_int := to_integer(unsigned(col));
			if(row_int = 1 or row_int = 480 or col_int = 1 or col_int = 640) then
				-- white
				red <= "1111";
				green <= "1111";
				blue <= "1111";
			else
				if(col_int <= 255) then
					red <= "0000";
					green <= "0000";
					blue <= col(7 downto 4);
				elsif(col_int <= 511) then
					red <= "0000";
					green <= col(7 downto 4);
					blue <= not (col(7 downto 4));
				else 
					red <= col(6 downto 3);
					green <= not (col(6 downto 3));
					blue <= "0000";	
				end if;
			end if;
		else 
			-- black (not allowed to set RGB here)
			red <= "0000";
			green <= "0000";
			blue <= "0000";
		end if;
	end process pixel_proc;
end pixel_gen_behav;

