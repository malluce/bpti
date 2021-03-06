library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- entity which transforms the state of the game into sprite ids and indeces
entity pixel_gen_ent is
	generic(PLAYER_SIZE_PIX, TILE_SIZE_PIX : integer);
	port(
		--current position, where to draw
        row_pixel : in std_logic_vector(8 downto 0);
        col_pixel : in std_logic_vector(9 downto 0);

		--coordinates and enable values of the players
        p1_x_coord_pixel : in std_logic_vector(8 downto 0);
        p1_y_coord_pixel : in std_logic_vector(8 downto 0);
        p1_enable_pixel : in std_logic;
        p2_x_coord_pixel : in std_logic_vector(8 downto 0);
        p2_y_coord_pixel : in std_logic_vector(8 downto 0);
        p2_enable_pixel : in std_logic;

		--information about the game board
        row0_pixel : in std_logic_vector(59 downto 0);
        row1_pixel : in std_logic_vector(59 downto 0);
        row2_pixel : in std_logic_vector(59 downto 0);
        row3_pixel : in std_logic_vector(59 downto 0);
        row4_pixel : in std_logic_vector(59 downto 0);
        row5_pixel : in std_logic_vector(59 downto 0);
        row6_pixel : in std_logic_vector(59 downto 0);
        row7_pixel : in std_logic_vector(59 downto 0);
        row8_pixel : in std_logic_vector(59 downto 0);
        row9_pixel : in std_logic_vector(59 downto 0);
        row10_pixel : in std_logic_vector(59 downto 0);
        row11_pixel : in std_logic_vector(59 downto 0);
				row12_pixel : in std_logic_vector(59 downto 0);
				row13_pixel : in std_logic_vector(59 downto 0);
				row14_pixel : in std_logic_vector(59 downto 0);

				--information for the sprite entities, which sprites they should draw
				sprite_id_pixel : out std_logic_vector(3 downto 0);
				sprite_row_pixel : out std_logic_vector(4 downto 0);
				sprite_col_pixel : out std_logic_vector(4 downto 0);
				player_id_pixel : out std_logic_vector(3 downto 0);
				player_x_pixel : out std_logic_vector(4 downto 0);
				player_y_pixel : out std_logic_vector(4 downto 0)
	);
end pixel_gen_ent;

architecture pixel_gen_behav of pixel_gen_ent is
begin
	pixel_proc : process(row_pixel, col_pixel, p1_x_coord_pixel, p1_y_coord_pixel, p1_enable_pixel, p2_x_coord_pixel, p2_y_coord_pixel, p2_enable_pixel,
							tiles_pixel)
		variable row_int : integer range 0 to 480 := 1;
		variable col_int : integer range 0 to 640 := 1;
		variable current_row : std_logic_vector(59 downto 0);
		variable arrayElement : std_logic_vector(3 downto 0);
		variable p1_x_int : integer range 0 to 480 := 0;
		variable p1_y_int : integer range 0 to 480 := 0;
		variable p2_x_int : integer range 0 to 480 := 0;
		variable p2_y_int : integer range 0 to 480 := 0;
		variable sprite_id : std_logic_vector(3 downto 0) := x"0";
		variable player_id : std_logic_vector(3 downto 0) := x"0";
		variable sprite_row_int : integer range 0 to 31 := 0;
		variable sprite_col_int : integer range 0 to 31 := 0;
		variable player_x : integer range 0 to 31 := 0;
		variable player_y : integer range 0 to 31 := 0;


	begin
		--convert all of the input vectors to integers
		row_int := to_integer(unsigned(row_pixel));
		col_int := to_integer(unsigned(col_pixel));
		p1_x_int := to_integer(unsigned(p1_x_coord_pixel));
		p1_y_int := to_integer(unsigned(p1_y_coord_pixel));
		p2_x_int := to_integer(unsigned(p2_x_coord_pixel));
		p2_y_int := to_integer(unsigned(p2_y_coord_pixel));

		if(col_int /= 0 and row_int /= 0) then
			sprite_row_int := (row_int - 1) mod TILE_SIZE_PIX;
			sprite_col_int := (col_int - 1) mod TILE_SIZE_PIX;
			if(col_int <= 160) then
				--special sprite_id to make left side of the monitor black, because we wanted the board to be a square
				sprite_id := x"4";
			else
				if(p1_enable_pixel = '1'  and row_int >= p1_y_int
					and col_int >= (p1_x_int + 160) and row_int < (p1_y_int + PLAYER_SIZE_PIX)
					and col_int < (p1_x_int + 160 + PLAYER_SIZE_PIX)) then
					-- draw player1
						player_id := x"2";
						player_x := col_int - 160 - p1_x_int;
						player_y := row_int - p1_y_int;
				elsif(p2_enable_pixel = '1'  and row_int >= p2_y_int
					and col_int >= (p2_x_int + 160) and row_int < (p2_y_int + PLAYER_SIZE_PIX)
					and col_int < (p2_x_int + 160 + PLAYER_SIZE_PIX)) then
					-- draw player2
						player_id := x"3";
						player_x := col_int - 160 - p2_x_int;
						player_y := row_int - p2_y_int;
				else
					--no player is drawn at the moment
					player_x := 0;
					player_y := 0;
					player_id := x"0";

				end if;

				--get the row, which we want to draw at the moment
				case ((row_int - 1) / TILE_SIZE_PIX) is
					when 0 => current_row := row0_pixel;
					when 1 => current_row := row1_pixel;
					when 2 => current_row := row2_pixel;
					when 3 => current_row := row3_pixel;
					when 4 => current_row := row4_pixel;
					when 5 => current_row := row5_pixel;
					when 6 => current_row := row6_pixel;
					when 7 => current_row := row7_pixel;
					when 8 => current_row := row8_pixel;
					when 9 => current_row := row9_pixel;
					when 10 => current_row := row10_pixel;
					when 11 => current_row := row11_pixel;
					when 12 => current_row := row12_pixel;
					when 13 => current_row := row13_pixel;
					when 14 => current_row := row14_pixel;
					when others => null;
				end case;

				--read the ids from the row
				--sprite_ids and the coding for the tiles is the same
				sprite_id := current_row((59 - (((col_int - 161) / TILE_SIZE_PIX) * 4)) downto
															(56 - (((col_int - 161) / TILE_SIZE_PIX) * 4)));

			end if;
		else
			-- not allowed to set rgb right now
			sprite_id := x"5";
			player_id := x"5";
		end if;

		--set the output signals to the variable values
		sprite_id_pixel <= sprite_id;
		sprite_row_pixel <= std_logic_vector(to_unsigned(sprite_row_int, 5));
		sprite_col_pixel <= std_logic_vector(to_unsigned(sprite_col_int, 5));
		player_x_pixel <= std_logic_vector(to_unsigned(player_x, 5));
		player_y_pixel <= std_logic_vector(to_unsigned(player_y, 5));
		player_id_pixel <= player_id;
	end process pixel_proc;
end pixel_gen_behav;
