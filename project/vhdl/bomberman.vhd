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
    component sync_gen_ent
        port(
            clk_sync : in std_logic;
            rst_sync : in std_logic;
            hsync_gen : out std_logic;
            vsync_gen : out std_logic;
            row_sync : out std_logic_vector(8 downto 0);
            col_sync : out std_logic_vector(9 downto 0)
        );
    end component;

    component game_mechanic_ent
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
    end component;

    component pixel_gen_ent
        port(
            p1_x_coord_pixel : out std_logic_vector(9 downto 0);
            p1_y_coord_pixel : out std_logic_vector(9 downto 0);
            p1_enable_pixel : out std_logic;
            p2_x_coord_pixel : out std_logic_vector(9 downto 0);
            p2_y_coord_pixel : out std_logic_vector(9 downto 0);
            p2_enable_pixel : out std_logic;
            row0_pixel : out std_logic_vector(47 downto 0);
            row1_pixel : out std_logic_vector(47 downto 0);
            row2_pixel : out std_logic_vector(47 downto 0);
            row3_pixel : out std_logic_vector(47 downto 0);
            row4_pixel : out std_logic_vector(47 downto 0);
            row5_pixel : out std_logic_vector(47 downto 0);
            row6_pixel : out std_logic_vector(47 downto 0);
            row7_pixel : out std_logic_vector(47 downto 0);
            row8_pixel : out std_logic_vector(47 downto 0);
            row9_pixel : out std_logic_vector(47 downto 0);
            row10_pixel : out std_logic_vector(47 downto 0);
            row11_pixel : out std_logic_vector(47 downto 0)
            red_pixel : out std_logic_vector(3 downto 0);
            green_pixel : out std_logic_vector(3 downto 0);
            blue_pixel : out std_logic_vector(3 downto 0)
        );
    end component;

    component rgb_assign_ent
        port(
            red_assign : in std_logic_vector(3 downto 0);
            green_assign : in std_logic_vector(3 downto 0);
            blue_assign : in std_logic_vector(3 downto 0);
            red_assign_0 : out std_logic;
            red_assign_1 : out std_logic;
            red_assign_2 : out std_logic;
            red_assign_3 : out std_logic;
            blue_assign_0 : out std_logic;
            blue_assign_1 : out std_logic;
            blue_assign_2 : out std_logic;
            blue_assign_3 : out std_logic;
            green_assign_0 : out std_logic;
            green_assign_1 : out std_logic;
            green_assign_2 : out std_logic;
            green_assign_3 : out std_logic
        );
    end component;

end bomberman_struct;
