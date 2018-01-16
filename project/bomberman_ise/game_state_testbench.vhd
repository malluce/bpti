library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity game_state_testbench is
end game_state_testbench;

architecture game_state_test of game_state_testbench is
    component game_state_ent
        generic(PLAYER_SIZE_STATE, TILE_SIZE_STATE : integer);
        port(
            clk_state : in std_logic;
            rst_state : in std_logic;
            row_player1_state : in std_logic_vector(3 downto 0);
            col_player1_state : in std_logic_vector(3 downto 0);
            enable_player1_state : in std_logic;
            row_player2_state : in std_logic_vector(3 downto 0);
            col_player2_state : in std_logic_vector(3 downto 0);
            enable_player2_state : in std_logic;
            row_bomb1_state : in std_logic_vector(3 downto 0);
            col_bomb1_state : in std_logic_vector(3 downto 0);
            explode_bomb1_state : in std_logic;
            enable_bomb1_state : in std_logic;
            row_bomb2_state : in std_logic_vector(3 downto 0);
            col_bomb2_state : in std_logic_vector(3 downto 0);
            explode_bomb2_state : in std_logic;
            enable_bomb2_state : in std_logic;

            enable_player1_state_out : out std_logic;
            enable_player2_state_out : out std_logic;
            row0_state : out std_logic_vector(59 downto 0);
            row1_state : out std_logic_vector(59 downto 0);
            row2_state : out std_logic_vector(59 downto 0);
            row3_state : out std_logic_vector(59 downto 0);
            row4_state : out std_logic_vector(59 downto 0);
            row5_state : out std_logic_vector(59 downto 0);
            row6_state : out std_logic_vector(59 downto 0);
            row7_state : out std_logic_vector(59 downto 0);
            row8_state : out std_logic_vector(59 downto 0);
            row9_state : out std_logic_vector(59 downto 0);
            row10_state : out std_logic_vector(59 downto 0);
            row11_state : out std_logic_vector(59 downto 0);
            row12_state : out std_logic_vector(59 downto 0);
            row13_state : out std_logic_vector(59 downto 0);
            row14_state : out std_logic_vector(59 downto 0)
        );
    end component;

    signal clock, reset : std_logic := '1';
    signal row_player1 : std_logic_vector(3 downto 0) := x"0";
    signal col_player1 : std_logic_vector(3 downto 0) := x"0";
    signal row_player2 : std_logic_vector(3 downto 0) := x"0";
    signal col_player2 : std_logic_vector(3 downto 0) := x"0";
    signal enable_player1, enable_player2 : std_logic := '1';
    signal row_bomb1 : std_logic_vector(3 downto 0) := x"0";
    signal col_bomb1 : std_logic_vector(3 downto 0) := x"0";
    signal row_bomb2 : std_logic_vector(3 downto 0) := x"0";
    signal col_bomb2 : std_logic_vector(3 downto 0) := x"0";
    signal explode_bomb1, enable_bomb1, explode_bomb2, enable_bomb2 : std_logic := '0';

    signal enable_player1_out, enable_player2_out : std_logic;
    signal row0, row1, row2, row3, row4, row5, row6, row7, row8, row9, row10, row11, row12, row13, row14 : std_logic_vector(59 downto 0);

    begin
        game_state_1 : game_state_ent 
        generic map(32, 32)
        port map(
            clock,
            reset,
            row_player1,
            col_player1,
            enable_player1,
            row_player2,
            col_player2,
            enable_player2,
            row_bomb1,
            col_bomb1,
            explode_bomb1,
            enable_bomb1,
            row_bomb2,
            col_bomb2,
            explode_bomb2,
            enable_bomb2,
            enable_player1_out,
            enable_player2_out,
            row0,
            row1,
            row2,
            row3,
            row4,
            row5,
            row6,
            row7,
            row8,
            row9,
            row10,
            row11,
            row12,
            row13,
            row14
        );

        clock <= not clock after 10 ns;

        test : process
        begin

            -- player_collision test
            row_player1 <= x"1";
            col_player1 <= x"1";
            row_bomb1 <= x"1";
            col_bomb1 <= x"1";
            enable_player1 <= '1';
            enable_bomb1 <= '0';
            explode_bomb1 <= '0';

            wait for 40 ns;
            assert(enable_player1_out = '1') report "enable should be 1";

            enable_bomb1 <= '1';
            explode_bomb1 <= '1';

            wait for 40 ns;

            assert(enable_player1_out = '0') report "enable should be 0";
            -- reset game_state
            reset <= '0';
            wait for 20 ns;

            -- init values from bomb_ent
            reset <= '1';
            row_bomb1 <= x"0";
            col_bomb1 <= x"0";
            enable_bomb1 <= '0';
            explode_bomb1 <= '0';
            wait for 40 ns;

            -- bomb_placement test
            assert(row0 = x"FFFFFFFFFFFFFFF") report "row0 did change but shouldnt";
            assert(row1 = x"F00EEEEEEEEE00F") report "row1 did change but shouldnt";

            row_bomb1 <= x"1";
            col_bomb1 <= x"1";
            enable_bomb1 <= '1';
            wait for 40 ns;
            assert(row1 = x"FD0EEEEEEEEE00F") report "bomb was not planted";

        end process test;
end game_state_test;
