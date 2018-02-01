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
            row0_pixel : in std_logic_vector(59 downto 0);
            row1_pixel : in std_logic_vector(59 downto 0);
            row2_pixel : in std_logic_vector(59 downto 0);
            row3_pixel : in std_logic_vector(59 downto 0);
            row4_pixel : in std_logic_vector(59 downto 0);
            row5_pixel : in std_logic_vector(59 downto 0);
            row6_pixel : in std_logic_vector(59 downto 0);
            row7_pixel : in std_logic_vector(59 downto 0);
            row8_pixel : in std_logic_vector(59 downto 0);
            row9_pixel : in std_logic_vector(59 downto 0);
            row10_pixel : in std_logic_vector(59 downto 0);
            row11_pixel : in std_logic_vector(59 downto 0);
				row12_pixel : in std_logic_vector(59 downto 0);
				row13_pixel : in std_logic_vector(59 downto 0);
				row14_pixel : in std_logic_vector(59 downto 0);
            sprite_id_pixel : out std_logic_vector(3 downto 0);
				sprite_row_pixel : out std_logic_vector(4 downto 0);
				sprite_col_pixel : out std_logic_vector(4 downto 0);
				player_id_pixel : out std_logic_vector(3 downto 0);
				player_x_pixel : out std_logic_vector(4 downto 0);
				player_y_pixel : out std_logic_vector(4 downto 0)
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
	 
	component SpriteROM
		port(
			sprite_id : in std_logic_vector(3 downto 0);
			sprite_row : in std_logic_vector(4 downto 0);
			sprite_col : in std_logic_vector(4 downto 0);
			red_sprite : out std_logic_vector(3 downto 0);
			green_sprite : out std_logic_vector(3 downto 0);
			blue_sprite : out std_logic_vector(3 downto 0)
		);
	end component;
	
	component PlayerROM
		port(
			id_player : in std_logic_vector(3 downto 0);
			x_player : in std_logic_vector(4 downto 0);
			y_player : in std_logic_vector(4 downto 0);
			red_in_player : in std_logic_vector(3 downto 0);
			green_in_player : in std_logic_vector(3 downto 0);
			blue_in_player : in std_logic_vector(3 downto 0);
			red_out_player : out std_logic_vector(3 downto 0);
			green_out_player : out std_logic_vector(3 downto 0);
			blue_out_player : out std_logic_vector(3 downto 0)
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
    signal red_fwd : std_logic_vector(3 downto 0);
    signal green_fwd : std_logic_vector(3 downto 0);
    signal blue_fwd : std_logic_vector(3 downto 0);
	 signal red_player_fwd : std_logic_vector(3 downto 0);
    signal green_player_fwd : std_logic_vector(3 downto 0);
    signal blue_player_fwd : std_logic_vector(3 downto 0);
	 signal sprite_id_fwd : std_logic_vector(3 downto 0);
	 signal sprite_row_fwd : std_logic_vector(4 downto 0);
	 signal sprite_col_fwd : std_logic_vector(4 downto 0);
	 signal player_id_sprite_fwd : std_logic_vector(3 downto 0);
	 signal player_x_sprite_fwd : std_logic_vector(4 downto 0);
	 signal player_y_sprite_fwd : std_logic_vector(4 downto 0);

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
        sprite_id_fwd,
        sprite_row_fwd,
        sprite_col_fwd,
		  player_id_sprite_fwd,
		  player_x_sprite_fwd,
		  player_y_sprite_fwd
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
	 
	 board_sprites : SpriteROM port map(
		sprite_id_fwd,
      sprite_row_fwd,
      sprite_col_fwd,
		red_player_fwd,
		green_player_fwd,
		blue_player_fwd
	 );
	 
	 player_sprites : PlayerROM port map(
		player_id_sprite_fwd,
		player_x_sprite_fwd,
		player_y_sprite_fwd,
		red_player_fwd,
		green_player_fwd,
		blue_player_fwd,
		red_fwd,
		green_fwd,
		blue_fwd
	 );

end bomberman_struct;
