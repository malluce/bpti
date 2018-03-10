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
            enable_player : in std_logic;
            row_bomb : out std_logic_vector(3 downto 0);
            col_bomb : out std_logic_vector(3 downto 0);
            enable_bomb : out std_logic;
            explode_bomb : out std_logic
        );
    end component;

    --Inputs
    signal clk_bomb : std_logic := '0';
    signal rst_bomb : std_logic := '1';
    signal col_player : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(1, 4));
    signal row_player : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(1, 4));
    signal plant_bomb : std_logic := '1';
    signal enable_player : std_logic := '1';

    --Outputs
    signal row_bomb : std_logic_vector(3 downto 0);
    signal col_bomb : std_logic_vector(3 downto 0);
    signal enable_bomb : std_logic;
    signal explode_bomb : std_logic;

begin
    boom : bomb_ent
    generic map(32)
    port map(
        clk_bomb => clk_bomb,
        rst_bomb => rst_bomb,
        col_player => col_player,
        row_player => row_player,
        plant_bomb => plant_bomb,
        enable_player => enable_player,
        row_bomb => row_bomb,
        col_bomb => col_bomb,
        enable_bomb => enable_bomb,
        explode_bomb => explode_bomb
    );

    clk_bomb <= not clk_bomb after 20 ns; --nearly frequency of 25,175 MHz

    set_bomb_test : process
    begin
      wait for 21 ns;
        assert(enable_bomb = '0') report "enable_bomb sollte 0 sein";
        assert(explode_bomb = '0') report "explode_bomb sollte 0 sein";
        plant_bomb <= '0';
        wait for 41 ns;
        assert(enable_bomb = '1') report "enable_bomb sollte 1 sein, aber ist 0";
        assert(explode_bomb = '0') report "explode_bomb sollte 0 sein, aber ist 1";
        assert(row_bomb = std_logic_vector(to_unsigned(1, 4))) report "Falsche row in der Bombe";
        assert(col_bomb = std_logic_vector(to_unsigned(1, 4))) report "Falsche col in der Bombe";
        rst_bomb <= '0';
        wait for 41 ns;
        rst_bomb <= '1';
        plant_bomb <= '0';
                wait for 41 ns;
                assert(enable_bomb = '1') report "enable_bomb sollte 1 sein, aber ist 0";
                plant_bomb <= '1';
                wait for 2957 ns;
                assert(explode_bomb = '1') report "explode_bomb sollte 1 sein, aber ist 0";
                wait for 560 ns;
                assert(enable_bomb = '0') report "enable_bomb sollte 0 sein";
                assert(explode_bomb = '0') report "explode_bomb sollte 0 sein";
    end process set_bomb_test;


end bomb_testbench_behav;
