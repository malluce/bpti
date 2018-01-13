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

    signal clock, reset : std_logic;
    signal row_player1, col_player1, row_player2, col_player2 : std_logic_vector(3 downto 0);
    signal enable_player1, enable_player2 : std_logic;
    signal row_bomb1, col_bomb1, row_bomb2, col_bomb2 : std_logic_vector(3 downto 0);
    signal explode_bomb1, enable_bomb1, explode_bomb2, enable_bomb2 : std_logic;
    signal enable_player1_out, enable_player2_out : std_logic;
    signal row0, row1, row2, row3, row4, row5, row6, row7, row8, row9, row10, row11, row12, row13, row14 : std_logic_vector(59 downto 0);

    begin
        game_state_1 : game_state_ent port map(
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

        test : process
        begin
            clock <= '1';
            wait for 50 ns;
            clock <= '0';
            wait for 50 ns;
        end process test;
end game_state_test;
