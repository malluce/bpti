library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_nand is
end testbench_nand;

architecture nand_testbench of testbench_nand is

	component nand_ent
		port (
			a_nand : in std_logic;
			b_nand : in std_logic;
			c_nand : out std_logic
		);
	end component;

	signal s1, s2, s3 : std_logic;

	begin
		nand_1 : nand_ent port map (s1, s2, s3);

		test : process
		begin
			s1 <= '1';
			s2 <= '1';
			wait for 100 ns;
			assert (s3 = '0') report "Falscher Wert! 1 statt 0; 11";
			
			s1 <= '1';
			s2 <= '0';
			wait for 100 ns;
			assert (s3 = '1') report "Falscher Wert! 0 statt 1; 10";

			s1 <= '0';
			s2 <= '1';
			wait for 100 ns;
			assert (s3 = '1') report "Falscher Wert! 0 statt 1; 01";

			s1 <= '0';
			s2 <= '0';
			wait for 100 ns;
			assert (s3 = '1') report "Falscher Wert! 0 statt 1; 00";
		end process test;
end nand_testbench;
