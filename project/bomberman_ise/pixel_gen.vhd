library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pixel_gen_ent is
	generic(PLAYER_SIZE_PIX, TILE_SIZE_PIX : integer);
	port(
        row_pixel : in std_logic_vector(8 downto 0);
        col_pixel : in std_logic_vector(9 downto 0);
        p1_x_coord_pixel : in std_logic_vector(8 downto 0);
        p1_y_coord_pixel : in std_logic_vector(8 downto 0);
        p1_enable_pixel : in std_logic;
        p2_x_coord_pixel : in std_logic_vector(8 downto 0);
        p2_y_coord_pixel : in std_logic_vector(8 downto 0);
        p2_enable_pixel : in std_logic;
        tiles_pixel : in std_logic_vector(899 downto 0);
		red_pixel : out std_logic_vector(3 downto 0);
		green_pixel : out std_logic_vector(3 downto 0);
		blue_pixel : out std_logic_vector(3 downto 0)
	);
end pixel_gen_ent;

architecture pixel_gen_behav of pixel_gen_ent is
begin
	pixel_proc : process(row_pixel, col_pixel, p1_x_coord_pixel, p1_y_coord_pixel, p1_enable_pixel, p2_x_coord_pixel, p2_y_coord_pixel, p2_enable_pixel,
							tiles_pixel)
		variable row_int : integer range 0 to 480 := 1;
		variable col_int : integer range 0 to 640 := 1;
		variable red_int : integer range 0 to 15 := 0;
		variable green_int : integer range 0 to 15 := 0;
		variable blue_int : integer range 0 to 15 := 0;
		variable current_row : std_logic_vector(59 downto 0);
		variable arrayElement : std_logic_vector(3 downto 0);
		variable p1_x_int : integer range 0 to 480 := 0;
		variable p1_y_int : integer range 0 to 480 := 0;
		variable p2_x_int : integer range 0 to 480 := 0;
		variable p2_y_int : integer range 0 to 480 := 0;

	begin
		row_int := to_integer(unsigned(row_pixel));
		col_int := to_integer(unsigned(col_pixel));
		p1_x_int := to_integer(unsigned(p1_x_coord_pixel));
		p1_y_int := to_integer(unsigned(p1_y_coord_pixel));
		p2_x_int := to_integer(unsigned(p2_x_coord_pixel));
		p2_y_int := to_integer(unsigned(p2_y_coord_pixel));
		if(col_int /= 0 and row_int /= 0) then
			if(col_int <= 160) then
				red_pixel <= x"F";
				green_pixel <= x"F";
				blue_pixel <= x"F";
			else
				if(p1_enable_pixel = '1'  and row_int >= p1_y_int
					and col_int >= (p1_x_int + 160) and row_int < (p1_y_int + PLAYER_SIZE_PIX)
					and col_int < (p1_x_int + 160 + PLAYER_SIZE_PIX)) then
					-- draw player1
						red_pixel <= x"F";
						green_pixel <= x"F";
						blue_pixel <= x"0";
				elsif(p2_enable_pixel = '1'  and row_int >= p2_y_int
					and col_int >= (p2_x_int + 160) and row_int < (p2_y_int + PLAYER_SIZE_PIX)
					and col_int < (p2_x_int + 160 + PLAYER_SIZE_PIX)) then
					-- draw player2
						red_pixel <= x"F";
						green_pixel <= x"0";
						blue_pixel <= x"F";
				else
					-- draw arena
					current_row := tiles_pixel(899 - (((row_int - 1) / TILE_SIZE_PIX) * 60) downto 899 - ((((row_int - 1) / TILE_SIZE_PIX) + 1) * 60));

					arrayElement := current_row((59 - (((col_int - 161) / TILE_SIZE_PIX) * 4)) downto
																(56 - (((col_int - 161) / TILE_SIZE_PIX) * 4)));

					case (arrayElement) is
						when x"0" => red_pixel <= x"F"; -- empty blocks = white
										 green_pixel <= x"F";
										 blue_pixel <= x"F";				
						when x"1" => red_pixel <= x"F"; -- explosion = red
										 green_pixel <= x"0";
										 blue_pixel <= x"0";
						when x"D" => red_pixel <= x"0"; -- bomb = blue
										 green_pixel <= x"0";
										 blue_pixel <= x"F";
						when x"E" => red_pixel <= x"0"; -- destroyable blocks = green
										 green_pixel <= x"F";
										 blue_pixel <= x"0";
						when x"F" => red_pixel <= x"0"; -- undestroyable blocks = black
										 green_pixel <= x"0";
										 blue_pixel <= x"0";
						when others => red_pixel <= x"A"; -- everything random
										 green_pixel <= x"A";
										 blue_pixel <= x"A";
					end case;
				end if;
			end if;
		else
			red_pixel <= x"0";
			green_pixel <= x"0";
			blue_pixel <= x"0";
		end if;
	end process pixel_proc;
end pixel_gen_behav;
