library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--this entity constains all the smaller entities and connects them together

entity bomberman_ent is
    port(
        --clk and reset from the board
        clk : in std_logic;
        rst : in std_logic;

        --input from both users
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

        --hsync and vsync output
        hsync : out std_logic;
		vsync : out std_logic;

        --color of the current pixel
		red_0 : out std_logic;
		red_1 : out std_logic;
		red_2 : out std_logic;
		red_3 : out std_logic;
        green_0 : out std_logic;
		green_1 : out std_logic;
		green_2 : out std_logic;
		green_3 : out std_logic;
		blue_0 : out std_logic;
		blue_1 : out std_logic;
		blue_2 : out std_logic;
		blue_3 : out std_logic
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
		generic(PLAYER_SIZE_MECH, TILE_SIZE_MECH : integer);
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
            p1_x_coord_mech : out std_logic_vector(8 downto 0);
            p1_y_coord_mech : out std_logic_vector(8 downto 0);
            p1_enable_mech : out std_logic;
            p2_x_coord_mech : out std_logic_vector(8 downto 0);
            p2_y_coord_mech : out std_logic_vector(8 downto 0);
            p2_enable_mech : out std_logic;
            row0_mech : out std_logic_vector(59 downto 0);
            row1_mech : out std_logic_vector(59 downto 0);
            row2_mech : out std_logic_vector(59 downto 0);
            row3_mech : out std_logic_vector(59 downto 0);
            row4_mech : out std_logic_vector(59 downto 0);
            row5_mech : out std_logic_vector(59 downto 0);
            row6_mech : out std_logic_vector(59 downto 0);
            row7_mech : out std_logic_vector(59 downto 0);
            row8_mech : out std_logic_vector(59 downto 0);
            row9_mech : out std_logic_vector(59 downto 0);
            row10_mech : out std_logic_vector(59 downto 0);
            row11_mech : out std_logic_vector(59 downto 0);
			row12_mech : out std_logic_vector(59 downto 0);
			row13_mech : out std_logic_vector(59 downto 0);
			row14_mech : out std_logic_vector(59 downto 0)
        );
    end component;

    component graphics_ent
        generic(PLAYER_SIZE_GRAPHICS, TILE_SIZE_GRAPHICS : integer);
        port(
            row_graphics : in std_logic_vector(8 downto 0);
            col_graphics : in std_logic_vector(9 downto 0);
            p1_x_coord_graphics : in std_logic_vector(8 downto 0);
            p1_y_coord_graphics : in std_logic_vector(8 downto 0);
            p1_enable_graphics : in std_logic;
            p2_x_coord_graphics : in std_logic_vector(8 downto 0);
            p2_y_coord_graphics : in std_logic_vector(8 downto 0);
            p2_enable_graphics : in std_logic;
            row0_graphics : in std_logic_vector(59 downto 0);
            row1_graphics : in std_logic_vector(59 downto 0);
            row2_graphics : in std_logic_vector(59 downto 0);
            row3_graphics : in std_logic_vector(59 downto 0);
            row4_graphics : in std_logic_vector(59 downto 0);
            row5_graphics : in std_logic_vector(59 downto 0);
            row6_graphics : in std_logic_vector(59 downto 0);
            row7_graphics : in std_logic_vector(59 downto 0);
            row8_graphics : in std_logic_vector(59 downto 0);
            row9_graphics : in std_logic_vector(59 downto 0);
            row10_graphics : in std_logic_vector(59 downto 0);
            row11_graphics : in std_logic_vector(59 downto 0);
            row12_graphics : in std_logic_vector(59 downto 0);
            row13_graphics : in std_logic_vector(59 downto 0);
            row14_graphics : in std_logic_vector(59 downto 0);
            red_0_graphics : out std_logic;
            red_1_graphics : out std_logic;
            red_2_graphics : out std_logic;
            red_3_graphics : out std_logic;
            green_0_graphics : out std_logic;
            green_1_graphics : out std_logic;
            green_2_graphics : out std_logic;
            green_3_graphics : out std_logic;
            blue_0_graphics : out std_logic;
            blue_1_graphics : out std_logic;
            blue_2_graphics : out std_logic;
            blue_3_graphics : out std_logic
        );
    end component;

	constant TILE_SIZE : integer range 0 to 32 := 32; -- size of a single tile
	constant PLAYER_SIZE : integer range 0 to TILE_SIZE := 32; --size of the player

    --forward signals to connect all of the entities
    signal row_fwd : std_logic_vector(8 downto 0);
    signal col_fwd : std_logic_vector(9 downto 0);
    signal p1_x_coord_fwd : std_logic_vector(8 downto 0);
    signal p1_y_coord_fwd : std_logic_vector(8 downto 0);
    signal p1_enable_fwd : std_logic;
    signal p2_x_coord_fwd : std_logic_vector(8 downto 0);
    signal p2_y_coord_fwd : std_logic_vector(8 downto 0);
    signal p2_enable_fwd : std_logic;
    signal row0_fwd : std_logic_vector(59 downto 0);
    signal row1_fwd : std_logic_vector(59 downto 0);
    signal row2_fwd : std_logic_vector(59 downto 0);
    signal row3_fwd : std_logic_vector(59 downto 0);
    signal row4_fwd : std_logic_vector(59 downto 0);
    signal row5_fwd : std_logic_vector(59 downto 0);
    signal row6_fwd : std_logic_vector(59 downto 0);
    signal row7_fwd : std_logic_vector(59 downto 0);
    signal row8_fwd : std_logic_vector(59 downto 0);
    signal row9_fwd : std_logic_vector(59 downto 0);
    signal row10_fwd : std_logic_vector(59 downto 0);
    signal row11_fwd : std_logic_vector(59 downto 0);
	signal row12_fwd : std_logic_vector(59 downto 0);
	signal row13_fwd : std_logic_vector(59 downto 0);
	signal row14_fwd : std_logic_vector(59 downto 0);

begin
    --hsync and vsync generator
    sync : sync_gen_ent port map(
        clk,
        rst,
        hsync,
        vsync,
        row_fwd,
        col_fwd
    );

    --basically all of the game logic
    game : game_mechanic_ent
	generic map(PLAYER_SIZE, TILE_SIZE)
	port map(
        clk,
        rst,
        p1_up,
        p1_down,
        p1_left,
        p1_right,
        p1_bomb,
        p2_up,
        p2_down,
        p2_left,
        p2_right,
        p2_bomb,
        p1_x_coord_fwd,
        p1_y_coord_fwd,
        p1_enable_fwd,
        p2_x_coord_fwd,
        p2_y_coord_fwd,
        p2_enable_fwd,
        row0_fwd,
        row1_fwd,
        row2_fwd,
        row3_fwd,
        row4_fwd,
        row5_fwd,
        row6_fwd,
        row7_fwd,
        row8_fwd,
        row9_fwd,
        row10_fwd,
        row11_fwd,
		row12_fwd,
		row13_fwd,
		row14_fwd
    );

    --draws the game to the screen
    graphics : graphics_ent
    generic map(PLAYER_SIZE, TILE_SIZE)
    port map(
        row_fwd,
        col_fwd,
        p1_x_coord_fwd,
        p1_y_coord_fwd,
        p1_enable_fwd,
        p2_x_coord_fwd,
        p2_y_coord_fwd,
        p2_enable_fwd,
        row0_fwd,
        row1_fwd,
        row2_fwd,
        row3_fwd,
        row4_fwd,
        row5_fwd,
        row6_fwd,
        row7_fwd,
        row8_fwd,
        row9_fwd,
        row10_fwd,
        row11_fwd,
        row12_fwd,
        row13_fwd,
        row14_fwd,
        red_0,
        red_1,
        red_2,
        red_3,
        green_0,
        green_1,
        green_2,
        green_3,
        blue_0,
        blue_1,
        blue_2,
        blue_3
    );


end bomberman_struct;
