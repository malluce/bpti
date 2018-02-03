library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity graphics_ent is
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
end graphics_ent;

architecture graphics_struct of graphics_ent is

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

    component rgb_assign_ent
        port(
            red_assign : in std_logic_vector(3 downto 0);
            green_assign : in std_logic_vector(3 downto 0);
            blue_assign : in std_logic_vector(3 downto 0);
            red_0_assign : out std_logic;
            red_1_assign : out std_logic;
            red_2_assign : out std_logic;
            red_3_assign : out std_logic;
            green_0_assign : out std_logic;
            green_1_assign : out std_logic;
            green_2_assign : out std_logic;
            green_3_assign : out std_logic;
            blue_0_assign : out std_logic;
            blue_1_assign : out std_logic;
            blue_2_assign : out std_logic;
            blue_3_assign : out std_logic
        );
    end component;

    signal sprite_id_fwd : std_logic_vector(3 downto 0);
	signal sprite_row_fwd : std_logic_vector(4 downto 0);
	signal sprite_col_fwd : std_logic_vector(4 downto 0);
	signal player_id_sprite_fwd : std_logic_vector(3 downto 0);
	signal player_x_sprite_fwd : std_logic_vector(4 downto 0);
	signal player_y_sprite_fwd : std_logic_vector(4 downto 0);
    signal red_player_fwd : std_logic_vector(3 downto 0);
    signal green_player_fwd : std_logic_vector(3 downto 0);
    signal blue_player_fwd : std_logic_vector(3 downto 0);
    signal red_fwd : std_logic_vector(3 downto 0);
    signal green_fwd : std_logic_vector(3 downto 0);
    signal blue_fwd : std_logic_vector(3 downto 0);

begin

    pixel : pixel_gen_ent
	generic map(PLAYER_SIZE_GRAPHICS, TILE_SIZE_GRAPHICS)
	port map(
        row_graphics,
        col_graphics,
        p1_x_coord_graphics,
        p1_y_coord_graphics,
        p1_enable_graphics,
        p2_x_coord_graphics,
        p2_y_coord_graphics,
        p2_enable_graphics,
        row0_graphics,
        row1_graphics,
        row2_graphics,
        row3_graphics,
        row4_graphics,
        row5_graphics,
        row6_graphics,
        row7_graphics,
        row8_graphics,
        row9_graphics,
        row10_graphics,
        row11_graphics,
		row12_graphics,
		row13_graphics,
		row14_graphics,
        sprite_id_fwd,
        sprite_row_fwd,
        sprite_col_fwd,
		player_id_sprite_fwd,
		player_x_sprite_fwd,
		player_y_sprite_fwd
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

     rgb_assign : rgb_assign_ent port map(
         red_fwd,
         green_fwd,
         blue_fwd,
         red_0_graphics,
         red_1_graphics,
         red_2_graphics,
         red_3_graphics,
         green_0_graphics,
         green_1_graphics,
         green_2_graphics,
         green_3_graphics,
         blue_0_graphics,
         blue_1_graphics,
         blue_2_graphics,
         blue_3_graphics
     );

end graphics_struct;
