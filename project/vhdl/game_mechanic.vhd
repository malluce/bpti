library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_mechanic_ent is
    port(
        clk_mech : in std_logic;
        rst_mech : in std_logic;
        p1_up_mech : in std_logic;
        p1_down_mech : in std_logic;
        p1_left_mech : in std_logic;
        p1_right_mech : in std_logic;
        p1_bomb_mech : in std_logic;
        p2_up_mech : in std_logic;
        p2_down_mech : in std_logic;
        p2_left_mech : in std_logic;
        p2_right_mech : in std_logic;
        p2_bomb_mech : in std_logic;
        p1_x_coord_mech : out std_logic_vector(9 downto 0);
        p1_y_coord_mech : out std_logic_vector(9 downto 0);
        p1_enable_mech : out std_logic;
        p2_x_coord_mech : out std_logic_vector(9 downto 0);
        p2_y_coord_mech : out std_logic_vector(9 downto 0);
        p2_enable_mech : out std_logic;
        row0_mech : out std_logic_vector(47 downto 0);
        row1_mech : out std_logic_vector(47 downto 0);
        row2_mech : out std_logic_vector(47 downto 0);
        row3_mech : out std_logic_vector(47 downto 0);
        row4_mech : out std_logic_vector(47 downto 0);
        row5_mech : out std_logic_vector(47 downto 0);
        row6_mech : out std_logic_vector(47 downto 0);
        row7_mech : out std_logic_vector(47 downto 0);
        row8_mech : out std_logic_vector(47 downto 0);
        row9_mech : out std_logic_vector(47 downto 0);
        row10_mech : out std_logic_vector(47 downto 0);
        row11_mech : out std_logic_vector(47 downto 0)
    );
end game_mechanic_ent;

architecture game_mechanic_struct of game_mechanic_ent is

end game_mechanic_struct;
