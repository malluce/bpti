library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SpriteROM is
	port(
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
constant empty_tile : spriteROM := (
	x"060040050040050040040050050040050030040040050050040050040050060050030040040050040040050040050050",
	x"050050060040040040030060040040040050040030050050040050040040060040040040040050040020050030050040",
	x"050060050060040040040070040050040040050040050060040060050040050040060060050060040030040030050050",
	x"040060040060030030040060030060050050050050050060050050060040030040050050040060030040040030050040",
	x"050060050070050020040040040050040030060060050050060040040050040060050050040060050050040030050040",
	x"040060050060060040030030040030030030060050040040060020050060040060040040030060060060050050060040",
	x"040050050050060050040020050040030040070050050040060030050070040050050040040050070060050050050030",
	x"030050050030050050030040050040040050050040050050060030060060030040050030040030070060060050030030",
	x"030070040040030030050060040050040050050050060050060040060050030050040030060040070060040030040040",
	x"040060050040040030050050030040040040050040050030050040050030050060040030060040070040050030050060",
	x"050060030050050030060040030030040040050040050040050050050030050060030050060040050040040040060060",
	x"050060040050060040050020020040040040050040040030040050040020050060030050060030050040050050050040",
	x"050060040040050030040020020040040050060050040050040050040040050050020050050030040050050060050020",
	x"050050050050040040040030020050040060060050040040050040040030060050040040070040040060040050060030",
	x"050060050050030040040030020060030050060030040050050040040040050040060040070040040060030040070050",
	x"030060040070030060050040020050050060060030040040060030040030060060070030070050040070030030070050",
	x"030060050060030060040030020070030040060030040040040050030030040040070050070030040070030020070060",
	x"050040040070030050040050030050040040060040040050040040050030050050060040050030050070030020060050",
	x"050050040060030040040050050050030040050040050060030040040050050040050050040030060070040020050060",
	x"050030030060040040040040050030030060050060060070050050040060050050040050030040050060040030050040",
	x"040050030050030040050040050040030060040060050060060050030050040040040070030050040050050040050040",
	x"050040030050040050040040040030030060040060050050060040040040030030030050030050040040040050050040",
	x"050060050030030040050040050040040050040040040040040040030040040030A00050030040050030030040050050",
	x"060040060050040040050040040040050050050040050050050040050040050030050040050040040040040050060050",
	x"040040050040050040050050040040050040040030050050030050050040040030060050050040050030040050050040",
	x"050030030050060040040050040060060040050040050040050050060030030030050040060030050040060060040030",
	x"030040030050060050030050040060050040040040050040040060050030030030040040060040050040050050040040",
	x"050040040050070040020040040060040030040050050040050050040040040030040040060030050040040060050040",
	x"050030050050050060040050020060040040030040050060050040050050040040050050050030060040030040040040",
	x"060040040040050050050050040040030050040030050060040040050040040040060050040040070030030040040050",
	x"070040030050040050050060040050040060050020050040040050050030050050050050050050070030040040040060",
	x"060040040060050030040060060060040050060030060030050060030030050040060040060050070030040050050050"

);
constant destroyable_tile : spriteROM := (
	x"000000000111111111111000111111111000111111000000111000111111111111000000111111111111000111000111",
	x"AAAAAA999AAAAAAAAA999999999999999999999999666111AAAAAA999AAAAAA999AAA999999AAA999999999999666000",
	x"999888888777777666666666666777888666666666444000999888888777888777777666666777666777666666444111",
	x"AAA666777777888777777777666666888666666666333111AAA888888666777666666777666555666666666555333000",
	x"AAA777666888666777666666777666666777777777444111AAA777777777666777777666666666555555666555444111",
	x"999888666777666666666777777666666666666666333111AAA777666666777777666666666555555555555555333000",
	x"999666666777777777666777666666666666666666333111999666777666666555555666555555666666555555333111",
	x"666444444333444333333444333444333444333333333000666444444444333333444333444333444333333333333000",
	x"000111000111111000111000111000111111000000000111111111111000000111000111000111000000000111000111",
	x"AAA999AAA999999999666000999AAAAAA999AAAAAAAAA999999AAA999999999999666111AAAAAA999AAA999999999999",
	x"888777666555666666444111AAA888777888666666777777777666666777666555444000999888777888888777666666",
	x"666666666777666555444111999777888888666888666666777777666777666666333000AAA888777666888666666777",
	x"777666666777777666333111AAA777888777888777555666666777777666666555444111999777666666666666777666",
	x"666777555555666555333000999777666666666666666777555666555555666555333000AAA666777777777777666666",
	x"555666555666555666333000999666666555777777777666555555666666555555333111999777666666666666666555",
	x"444333444333333333333000666444444444444444444333444333444333333333333000666444444333444333444444",
	x"000000111111000111000111000111000111000000111000111111000111111000000111111111000000111000111111",
	x"AAA999AAAAAA999AAA999999AAAAAAAAA999999999666111AAA999999999AAA999999AAAAAAAAA999999999999666000",
	x"999888777888777666777666666666666555666555444111AAA888777888777666777666666666666777666555444111",
	x"AAA777888888888888777777555666888888777666333000AAA777888888666666777666777777666777666555333000",
	x"AAA888666777666888666666888777666666666555444000AAA666777888666777777666777777666555666555444000",
	x"AAA777666666666666777666666777666555666666333111999777777777777666666666666666777777666666444000",
	x"999666666666555666777555666555666777555555333111999666666777666666666777666666555666555555333111",
	x"666444444333333333333444333444444444333333333000666444333444333333444333333444444444333333333000",
	x"111000111000000000000111000111111000000111000111000111111000111000000111000111000000111111000111",
	x"AAA999999AAA999999666111AAA999999AAAAAAAAAAAAAAAAAAAAA999AAA999999666000AAAAAAAAAAAAAAAAAA999999",
	x"888777666666777666333000AAA777777777666666777666666777666666666666444111AAA888777777666777666666",
	x"777666555666777555444111AAA666777666777666666777666888777777555555333000AAA888666888888777666666",
	x"666666555555666555333000999777666777777666777666777777777666666555444111999888777777666666666777",
	x"555555777666555666333111AAA777666777666666888666555666666777666666333000999777666777777666777666",
	x"666666666555666555333000999666666666555555666555555777555555555555333000999666777666555666555666",
	x"444333444444333333333000666444444333333333333444444333333333333333333000666444444444333333333444"
);

constant undestroyable_tile : spriteROM := (
	x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	x"000BBBCCCCCCAAABBBAAAAAACCCCCCAAAAAACCCBBBCCCBBBAAABBBBBBCCCBBBCCCCCCCCCBBBCCCBBBBBBAAACCCBBB888",
	x"000AAABBBCCCBBBCCCAAABBBCCCAAABBBCCCBBBAAAAAACCCBBBAAABBBBBBCCCAAAAAABBBCCCBBBAAAAAABBBBBB888444",
	x"000BBBAAA999999999888777666777666777666777888888666888777666555777777666888888666666555888444333",
	x"000AAA999999888777888555777666999999888666555666777666555555666777666888666555666888666555333444",
	x"000999AAA888777888666666888999666888777888666777888555666777888777666777888777888666777666333444",
	x"000AAABBB777777555777444333444222333444444222333333444222333444444333222444888666777666888444333",
	x"000AAAAAA888666666444333444333333222444333333222444333333222444333222333888AAA555777555777444333",
	x"000BBBBBB666777999333222777666666777777666777777666666777777666555666777AAABBB666777666666444444",
	x"000BBBAAA666666999333333666888777888999888777888777888999888777666777888BBBCCC888777555777333444",
	x"000AAABBB777555777222444777999888666777777888999888777888777777888777666999AAA777666666888444444",
	x"000BBBAAA555666888333333555888666777888777777888777666777777888888666777BBB999555666777777444444",
	x"000BBBAAA666999777333444555666777888777666888999888777888666999777777888CCCAAA777777666888444444",
	x"000AAAAAA888777666444333666888777777666888777777666777888666666777666777BBBBBB666777555888444444",
	x"000BBBBBB777999888333222666777888888777777888888777888888666777888777888BBBAAA888666555777444333",
	x"000AAABBB888666777444333777777666666777888777777666888777777666888888777AAA999666666777666333444",
	x"000AAABBB666666999444444777888888888777777666666777777888888777666777666BBB999555888777666444444",
	x"000AAAAAA666888999333444666777888777888888999888777888777777888777888777BBBAAA666777888777444444",
	x"000BBBAAA888999888222333777888777666999777666888777888777888999777666999AAABBB777555666888333333",
	x"000AAABBB888666888444333666777666888999666777999999777888777777888777888AAACCC777666555777444333",
	x"000999AAA888777666333444555666888888777888666777888888999999888777888777999AAA666555666777444333",
	x"000BBB999888777666444333666888666777666999777888777888777777999666777666BBBBBB666888666777333333",
	x"000AAA999888888666333444777888777888777999888999777666888777666777666888BBBAAA666777888666444333",
	x"000BBBAAA777888666333444666777888777666888777888888777999888888777888999BBBCCC888666666555444444",
	x"000BBBBBB888777777444888BBBBBBAAABBBAAABBBBBBCCCCCCBBBAAABBBCCCBBBAAACCCAAABBB666888888666444333",
	x"000BBBAAA888666888666BBBCCCCCCCCCCCCBBBCCCAAABBBCCCCCCBBBAAABBBCCCBBBCCCCCCBBB555777777888444333",
	x"000AAA999666777666777777888888777888777666888777666777777888777888777777888888666777777888333444",
	x"000BBBAAA666777777777888666777777666888777666888777888666888777666666777777888777888666777444444",
	x"000BBBBBB888777666555777666555777666666888666777888666555666666888666555888666777888777888444444",
	x"000AAAAAA777888555666777555555666888888666555666777888666777777777555666777888666666777666333444",
	x"000AAA888444444333333444333444444444444333333444444333333444333444333444444333444444333333333333",
	x"000888444444333444444444444444333444333333333444333444444333444333333333333333444333444444444333"
);

constant bomb_tile : spriteROM := (
	x"060040050040050040040050050040050030040040050050040050040050060050030040040050040040050040050050",
	x"050050060040040040030060040040040050040030050050040050040040060040040040040050040020000030050040",
	x"050060050060040040040070040050040040050040050060040060050000050040060000050060040000900000050050",
	x"040060040060030030040060030060050050050050050060050050000900000040000900000060000900000030050040",
	x"050060050070050020040040040050040030060060050050000000900000000000900900000000900000040030050040",
	x"040060050060060040030030040030030030060050040000E00900000000900E00900000000900E00000050050060040",
	x"040050050050060050040020050040030040070000000E30E00000000900E00000000000900E00000060050050050030",
	x"030050050030050050030040050040040050000E00E30E00000000E00E00000000000E00E00000000060060050030030",
	x"030070040040030030050060040050000000E30E70E30000E70E00E00000000000E00E00000000900000040030040040",
	x"040060050040040030050050000000E00E00E70E30E00E30E30E30000000000E00E30000000900000040050030050060",
	x"050060030050050030060000E00E00E00E30E30E00E30E00E70E00000000E00E30E00000000900000040040040060060",
	x"050060040050060040000E00E30E70E70E30E70E30E70E70E30E30E00E70E70E30000000E00000050040050050050040",
	x"050060040040050000E70E30E70E70E30E70E30E70E70E30E00E00E30E70E30000000E00E00000040050050060050020",
	x"050050050050000E70E30E70EB0EB0EB0EB0E70E30E30E70E00E30E00E00E00000E00E70000040040060040050060030",
	x"050060050050000E70EB0EB0EE0EB0EE0EB0EE0EB0E70EB0E70E00E30E70E00000E70E30000040040060030040070050",
	x"030060040070000EB0EE0EB0EB0EE0EE0EE0EB0EB0EB0E70EB0E30E70E30E00E30E70000000050040070030030070050",
	x"030060050000E70EE0EB0EE0EE0EE0EEBEE0EEBEE0EB0EB0E70EB0E70E30E00E70E30000900000040070030020070060",
	x"050040040000EB0EB0EB0EE0EEBEEBEEBEEBEE0EE0EE0EB0EB0E70E00E00E00E00000000900000050070030020060050",
	x"050050040000E70EB0EE0EEBEEBEEBEE0EEBEE0EEBEE0EE0E70E30E30E00E30E000000EE0EE000000070040020050060",
	x"050030030000E70EB0EE0EE0EEBEEBEEBEEBEE0EEBEE0EB0EB0E70EB0E30E300EE0EE222AAA0BB0BB000040030050040",
	x"040050030050000E70EE0EEBEEBEE0EEBEEBEEBEEBEE0EE0EB0EB0E70E300EEAAAAAA222EEECCCCCC0BB000040050040",
	x"050040030050000EB0EB0EE0EEBEE0EEBEE0EE0EE0EB0EB0EE0E70E30E000EEAAAEEE222EEEEEECCC0BB000050050040",
	x"050060050030000E70E70EE0EE0EE0EEBEEBEEBEE0EB0EE0EB0E70E300EEAAAEEEEEE222EEE222CCCCCC0BB000050050",
	x"060040060050040000E70E70EB0EE0EE0EE0EB0EB0EB0E70E70E70E300EEAAAEEEEEE222222CCCEEECCC0BB000060050",
	x"040040050040050040000E70E70E70EB0EB0EB0EB0E70E30E30E30E000000EEAAAEEECCCCCCEEEEEE0BB000050050040",
	x"050030030050060040040000E30E30E30E70E70E70E30E00E00E000000000EEAAACCCEEEEEECCCCCC0BB000060040030",
	x"030040030050060050030050000000000E30E30E30E300000000000500300000BB0BBCCCCCC0BB0BB000050050040040",
	x"0500400400500700400200400400600400000000000000400500500400400400000000BB0BB000000040040060050040",
	x"050030050050050060040050020060040040030040050060050040050050040040050000000030060040030040040040",
	x"060040040040050050050050040040030050040030050060040040050040040040060050040040070030030040040050",
	x"070040030050040050050060040050040060050020050040040050050030050050050050050050070030040040040060",
	x"060040040060050030040060060060040050060030060030050060030030050040060040060050070030040050050050"
);

constant explosion_tile : spriteROM := (
	x"100300500700700E00700700300300300100300100200300300700500700E30700900500700300300100300700700B00",
	x"300300E70500300700500500700700700200300300100300300500500700E70500700300300100100200100300500700",
	x"300700E00700200300300700E00700300300200100300500300700700E70900500300100200100300300100300300700",
	x"700EE0E70E70100B00B00500700E00700200100300500700300300EE0E30700300100200300300B00700500300E70300",
	x"300E00700100200500700700200200EB0300100700500B00700700E70500200300300100B00300500700E70B00700900",
	x"700700300100700700EE0E30E00700300100500EB0E30E70E00700E70700200200100300500B00700E70E00200200E30",
	x"300E00500B00700E70200200700500100700500700EB0200700700200200300700300500700200200E00700700700500",
	x"100200300700E00700700200200700700B00B00200EE0500500300300500500900300200B00200200700700500700300",
	x"200500700200200700900500100500B00300700700E30EB0700700500700B00E00E30200E70E00700300100100300100",
	x"300700200700900300200200100300200300300B00700700E70700200200E00700200700500E70700500500100200200",
	x"100900E30700500300300500300200100100E30100100100700E00700E00700500900300700E70200700B00300300100",
	x"200700200B00700500700900300100B00700B00100100E30500100E30B00700300300900500700EE0EB0700700300300",
	x"300300700E70E30E30200900700300300B00E00E00100E30100B00700E70700300200500300700B00E70EB0700E30300",
	x"200300300200700700500700500500700B00700300E00E00E30EB0E70EE0E00B00100200300700E00EB0EE0E30E30500",
	x"300700700200B00500300100500700E00E00500E30500E00E30E30EE0E30100100100100E70EB0EB0EE0E70E30700500",
	x"700900E00700B00300100200500B00700E70200E30EE0E30E70E30EB0E30E00200E70EB0E70E30700500700200E00700",
	x"900B00E30300300100200500300300E30E00700E70E70EE0E30E30B00E30E00100B00700700EB0300E30300500200700",
	x"E00E30E70EB0E30300200300300700E00B00700B00E70700B00500E00E00300E30700500300E70300200300E00200700",
	x"200B00E30E70EE0700300200300E00200300500700300E00E00300200300100200300200100E30200300700200E00E30",
	x"500B00500E70EB0E70EB0700300200200100200300100200300100300B00300200200200200200700E00700E00E30700",
	x"100500700EB0B00700E70E00700700700B00700300700300200500700B00200700B00700700200E00E00700900700300",
	x"300300300E70300500200700200E00E30E30B00700E30700500500500700700E00EB0E70200E00900700300100200300",
	x"200200EB0B00200300700B00500700E70E70EB0EB0EE0E70700900E30E30200200700E00200700700300200300700300",
	x"100300EB0200100200300700500700500E70E00E70EB0EE0E00700EE0700B00500B00E30E00500500300200E00700700",
	x"100300700300200100200100300100E70EB0EB0700500700E00E30E30700700500700E70700B00200B00E00B00500200",
	x"200300200300500300300200700700E70EE0700700300100100100700500300300200200E00700E30E00700700300100",
	x"300100500200200B00900300300B00200E70700500200300100500300200200300B00200200700200700B00300500300",
	x"300300200300300B00700500300700B00200E30700300700500300100100300200300700700E00200200300200500700",
	x"500700900700300300B00700E70E00E00100200EB0E70200200B00700700300300500300700E70E00E00700B00700E00",
	x"E00700200E00700200700700200700700700200EE0700500700E70E00700700500300100300700700E70EB0E00E00B00",
	x"E70200E30700E00700500E70500500700300200B00300700500200E30B00700700700300500300700B00700B00700700",
	x"700700500700B00E00E30E00500700300200100300100300300700E70E00B00B00200700500300100300500500700500"
);

shared variable row_int : integer range 0 to 31 := 0;
		shared variable col_int : integer range 0 to 31 := 0;
		shared variable sprite_idx : integer range 0 to 383 := 0;

begin
	sprite_proc : process(sprite_id, sprite_row, sprite_col)


		begin
				row_int := to_integer(unsigned(sprite_row));
				col_int := to_integer(unsigned(sprite_col));
				sprite_idx := 383 - 12 * col_int;
				case sprite_id is
					when x"0" => 	red_sprite <= empty_tile(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= empty_tile(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= empty_tile(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when x"1" => 	red_sprite <= explosion_tile(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= explosion_tile(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= explosion_tile(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when x"D" => 	red_sprite <= bomb_tile(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= bomb_tile(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= bomb_tile(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when x"E" => 	red_sprite <= destroyable_tile(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= destroyable_tile(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= destroyable_tile(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when x"F" => 	red_sprite <= undestroyable_tile(row_int)(sprite_idx downto (sprite_idx - 3));
										green_sprite <= undestroyable_tile(row_int)((sprite_idx - 4) downto (sprite_idx - 7));
										blue_sprite <= undestroyable_tile(row_int)((sprite_idx - 8) downto (sprite_idx - 11));
					when others => red_sprite <= x"0"; -- not allowed to set RGB here
										green_sprite <= x"0";
										blue_sprite <= x"0";
				end case;
		end process sprite_proc;


end SpriteROM_Behav;
