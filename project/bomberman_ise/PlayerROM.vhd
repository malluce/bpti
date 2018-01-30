library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PlayerROM is
	port(
		clk_player : in std_logic;
		id_player : in std_logic_vector(3 downto 0);
		x_player : in std_logic_vector(4 downto 0);
		y_player : in std_logic_vector(4 downto 0);
		red_in_player : in std_logic_vector(3 downto 0);
		green_in_player : in std_logic_vector(3 downto 0);
		blue_in_player : in std_logic_vector(3 downto 0);
		red_out_player : out std_logic_vector(3 downto 0);
		green_out_player : out std_logic_vector(3 downto 0);
		blue_out_player : out std_logic_vector(3 downto 0)
	);
end PlayerROM;

architecture PlayerROM_Behav of PlayerROM is

type spriteROM is array(0 to 31) of std_logic_vector(383 downto 0);

constant player1 : spriteROM := ();
constant player2 : spriteROM := ();

begin
	player_proc : process(clk_player)
	
	variable x_int : integer range 0 to 31 := 0;
	variable y_int : integer range 0 to 31 := 0;
	variable sprite_idx : integer range 0 to 383 := 0;
	variable red : std_logic_vector(3 downto 0) := x"0";
	variable green : std_logic_vector(3 downto 0) := x"0";
	variable blue : std_logic_vector(3 downto 0) := x"0";
	
	begin
		if(clk_player'event and clk_player = '1') then
			x_int := to_integer(unsigned(x_player));
			y_int := to_integer(unsigned(y_player));
			sprite_idx := 383 - 6 * x_int;
			case id_player is
				when x"2" => 
					red := player1(y_int)(sprite_idx downto (sprite_idx - 3));
					green := player1(y_int)((sprite_idx - 4) downto (sprite_idx - 7));
					blue := player1(y_int)((sprite_idx - 8) downto (sprite_idx - 11));
				when x"3" =>
					red := player2(y_int)(sprite_idx downto (sprite_idx - 3));
					green := player2(y_int)((sprite_idx - 4) downto (sprite_idx - 7));
					blue := player2(y_int)((sprite_idx - 8) downto (sprite_idx - 11));
				when others =>
					red := x"0";
					green := x"0";
					blue := x"0";
			end case;
			
			if(red = x"0" and green = x"0" and blue = x"0") then
				red_out_player <= red_in_player;
				green_out_player <= green_in_player;
				blue_out_player <= blue_in_player;
			else
				red_out_player <= red;
				green_out_player <= green;
				blue_out_player <= blue;
			end if;
		end if;
	end process player_proc;


end PlayerROM_Behav;

