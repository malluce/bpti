library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity movement_testbench_ent is
end movement_testbench_ent;

architecture movement_testbench_behav of movement_testbench_ent is
    component movement
        generic(X_INIT_MOVE, Y_INIT_MOVE, PLAYER_SIZE_MOVE, TILE_SIZE_MOVE : integer);
        port(
            clk_move : in std_logic;
            rst_move : in std_logic;
            up_move : in std_logic;
            down_move : in std_logic;
            left_move : in std_logic;
            right_move : in std_logic;
            row0_move : in std_logic_vector(59 downto 0);
            row1_move : in std_logic_vector(59 downto 0);
            row2_move : in std_logic_vector(59 downto 0);
            row3_move : in std_logic_vector(59 downto 0);
            row4_move : in std_logic_vector(59 downto 0);
            row5_move : in std_logic_vector(59 downto 0);
            row6_move : in std_logic_vector(59 downto 0);
            row7_move : in std_logic_vector(59 downto 0);
            row8_move : in std_logic_vector(59 downto 0);
            row9_move : in std_logic_vector(59 downto 0);
            row10_move : in std_logic_vector(59 downto 0);
            row11_move : in std_logic_vector(59 downto 0);
            row12_move : in std_logic_vector(59 downto 0);
            row13_move : in std_logic_vector(59 downto 0);
            row14_move : in std_logic_vector(59 downto 0);
            x_move : out std_logic_vector(8 downto 0);
            y_move : out std_logic_vector(8 downto 0)
        );
    end component;

    --Inputs
    signal clk_move : std_logic;
    signal rst_move : std_logic;
    signal up_move : std_logic;
    signal down_move : std_logic;
    signal left_move : std_logic;
    signal right_move : std_logic;
    signal row0_move : std_logic_vector(59 downto 0);
    signal row1_move : std_logic_vector(59 downto 0);
    signal row2_move : std_logic_vector(59 downto 0);
    signal row3_move : std_logic_vector(59 downto 0);
    signal row4_move : std_logic_vector(59 downto 0);
    signal row5_move : std_logic_vector(59 downto 0);
    signal row6_move : std_logic_vector(59 downto 0);
    signal row7_move : std_logic_vector(59 downto 0);
    signal row8_move : std_logic_vector(59 downto 0);
    signal row9_move : std_logic_vector(59 downto 0);
    signal row10_move : std_logic_vector(59 downto 0);
    signal row11_move : std_logic_vector(59 downto 0);
    signal row12_move : std_logic_vector(59 downto 0);
    signal row13_move : std_logic_vector(59 downto 0);
    signal row14_move : std_logic_vector(59 downto 0);

    --Outputs
    signal x_move : std_logic_vector(8 downto 0);
    signal y_move : std_logic_vector(8 downto 0);

begin
    mov : movement_ent
    generic map(33, 33, 32, 32)
    port map(
        clk_move,
        rst_move,
        up_move,
        down_move,
        left_move,
        right_move,
        row0_move,
        row1_move,
        row2_move,
        row3_move,
        row4_move,
        row5_move,
        row6_move,
        row7_move,
        row8_move,
        row9_move,
        row10_move,
        row11_move,
        row12_move,
        row13_move,
        row14_move,
        x_move,
        y_move
    );
end movement_testbench_behav;
