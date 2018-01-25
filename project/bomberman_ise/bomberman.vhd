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
            tiles_mech : out std_logic_vector(899 downto 0)
        );
    end component;

    component pixel_gen_ent
		generic(PLAYER_SIZE_PIX, TILE_SIZE_PIX : integer);
        port(
            row_pixel : in std_logic_vector(8 downto 0);
            col_pixel : in std_logic_vector(9 downto 0);
            p1_x_coord_pixel : in std_logic_vector(8 downto 0);
            p1_y_coord_pixel : in std_logic_vector(8 downto 0);
            p1_enable_pixel : in std_logic;
            p2_x_coord_pixel : in std_logic_vector(8 downto 0);
            p2_y_coord_pixel : in std_logic_vector(8 downto 0);
            p2_enable_pixel : in std_logic;
            tiles_pixel : in std_logic_vector(899 downto 0);
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
            green_assign_0 : out std_logic;
            green_assign_1 : out std_logic;
            green_assign_2 : out std_logic;
            green_assign_3 : out std_logic;
            blue_assign_0 : out std_logic;
            blue_assign_1 : out std_logic;
            blue_assign_2 : out std_logic;
            blue_assign_3 : out std_logic
        );
    end component;

	constant TILE_SIZE : integer range 0 to 32 := 32; -- do NOT change this!!
	constant PLAYER_SIZE : integer range 0 to TILE_SIZE := 32;
	
    signal row_fwd : std_logic_vector(8 downto 0);
    signal col_fwd : std_logic_vector(9 downto 0);
    signal p1_x_coord_fwd : std_logic_vector(8 downto 0);
    signal p1_y_coord_fwd : std_logic_vector(8 downto 0);
    signal p1_enable_fwd : std_logic;
    signal p2_x_coord_fwd : std_logic_vector(8 downto 0);
    signal p2_y_coord_fwd : std_logic_vector(8 downto 0);
    signal p2_enable_fwd : std_logic;
    signal tiles_fwd : std_logic_vector(899 downto 0);
    signal red_fwd : std_logic_vector(3 downto 0);
    signal green_fwd : std_logic_vector(3 downto 0);
    signal blue_fwd : std_logic_vector(3 downto 0);

begin
    sync : sync_gen_ent port map(
        clk,
        rst,
        hsync,
        vsync,
        row_fwd,
        col_fwd
    );

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
        tiles_fwd
    );

    pixel : pixel_gen_ent 
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
        tiles_fwd,
        red_fwd,
        green_fwd,
        blue_fwd
    );

    rgb_assign : rgb_assign_ent port map(
        red_fwd,
        green_fwd,
        blue_fwd,
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
