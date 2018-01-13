library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bomb_testbench_ent is
end bomb_testbench_ent;

architecture bomb_testbench_behav of bomb_testbench_ent is
    component bomb_ent
        generic(TILE_SIZE_BOMB : integer);
        port(
            clk_bomb : in std_logic;
            rst_bomb : in std_logic;
            col_player : in std_logic_vector(3 downto 0);
            row_player : in std_logic_vector(3 downto 0);
            plant_bomb : in std_logic;
            row_bomb : out std_logic_vector(3 downto 0);
            col_bomb : out std_logic_vector(3 downto 0);
            enable_bomb : out std_logic;
            explode_bomb : out std_logic
        );
    end component;

    --Inputs
    signal clk_bomb : std_logic;
    signal rst_bomb : std_logic;
    signal col_player : std_logic_vector(3 downto 0);
    signal row_player : std_logic_vector(3 downto 0);
    signal plant_bomb : std_logic;

    --Outputs
    signal row_bomb : std_logic_vector(3 downto 0);
    signal col_bomb : std_logic_vector(3 downto 0);
    signal enable_bomb : std_logic;
    signal explode_bomb : std_logic;

begin
    boom : bomb_ent
        generic map(32)
        port map(
            clk_bomb,
            rst_bomb,
            col_player.
            row_player,
            plant_bomb,
            row_bomb,
            col_bomb,
            enable_bomb,
            explode_bomb
        );

end bomb_testbench_behav;
