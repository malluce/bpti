library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SpriteROM is
	port(
		clk_sprite : in std_logic;
		sprite_id : in std_logic_vector(3 downto 0);
		sprite_row : in std_logic_vector(4 downto 0);
		sprite_col : in std_logic_vector(4 downto 0);
		red_sprite : out std_logic_vector(3 downto 0);
		green_sprite : out std_logic_vector(3 downto 0);
		blue_sprite : out std_logic_vector(3 downto 0)
	);
end SpriteROM;

architecture SpriteROM_Behav of SpriteROM is


type spriteROM is array(0 to 31) of std_logic_vector(383 downto 0);
constant empty_tile : spriteROM := ();
constant destroyable_tile : spriteROM := ();
constant undestroyable_tile : spriteROM := ();
constant bomb_tile : spriteROM := ();
constant explosion_tile : spriteROM := ();

begin
	sprite_proc : process(clk_sprite)
		variable row_int : integer range 0 to 31 := 0;
		variable col_int : integer range 0 to 31 := 0;
		variable sprite_idx : integer range 0 to 383 := 0;
		
		begin
			if(clk_sprite'event and clk_sprite = '1') then
				row_int := to_integer(unsigned(sprite_row));
				col_int := to_integer(unsigned(sprite_col));
				sprite_idx := 383 - 6 * col_int;
				case sprite_id is
					when x"0" => 	red_sprite <= empty_tile(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= empty_tile(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= empty_tile(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when x"1" => 	red_sprite <= explosion_tile(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= explosion_tile(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= explosion_tile(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when x"2" => 	red_sprite <= player1(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= player1(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= player1(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when x"3" => 	red_sprite <= player2(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= player2(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= player2(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when x"D" => 	red_sprite <= bomb_tile(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= bomb_tile(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= bomb_tile(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when x"E" => 	red_sprite <= destroyable_tile(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= destroyable_tile(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= destroyable_tile(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when x"F" => 	red_sprite <= undestroyable_tile(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= undestroyable_tile(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= undestroyable_tile(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when others => red_sprite <= x"F";
										green_sprite <= x"F";
										blue_sprite <= x"F";
				end case;
			end if;
		end process sprite_proc;


end SpriteROM_Behav;

