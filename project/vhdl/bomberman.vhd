library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bomberman_ent is
    port(
        clk : in std_logic;
        rst : in std_logic;
        p1_up : in std_logic;
        p1_down : in std_logic;
        p1_left : in std_logic;
        p1_right : in std_logic;
        p1_bomb : in std_logic;
        p2_up : in std_logic;
        p2_down : in std_logic;
        p2_left : in std_logic;
        p2_right : in std_logic;
        p2_bomb : in std_logic;
        hsync : out std_logic;
		vsync : out std_logic;
		red_0 : out std_logic;
		red_1 : out std_logic;
		red_2 : out std_logic;
		red_3 : out std_logic;
		blue_0 : out std_logic;
		blue_1 : out std_logic;
		blue_2 : out std_logic;
		blue_3 : out std_logic;
		green_0 : out std_logic;
		green_1 : out std_logic;
		green_2 : out std_logic;
		green_3 : out std_logic
    );
end bomberman_ent;

architecture bomberman_struct of bomberman_ent is

end bomberman_struct;
