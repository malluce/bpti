library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity movement_ent is
	generic(X_INIT_MOVE, Y_INIT_MOVE, PLAYER_SIZE_MOVE, TILE_SIZE_MOVE : integer);
	port(
		fast_clk_move : in std_logic;
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
end movement_ent;

architecture movement_behav of movement_ent is

	--directly return the tile at the position (X,Y)
	impure function GET_TILE (X,Y : integer) return std_logic_vector is
		variable col : integer range 0 to 14;
		variable row : std_logic_vector(59 downto 0);
	begin
		case ((Y - 1) / TILE_SIZE_MOVE) is
			when 0 => row := row0_move;
			when 1 => row := row1_move;
			when 2 => row := row2_move;
			when 3 => row := row3_move;
			when 4 => row := row4_move;
			when 5 => row := row5_move;
			when 6 => row := row6_move;
			when 7 => row := row7_move;
			when 8 => row := row8_move;
			when 9 => row := row9_move;
			when 10 => row := row10_move;
			when 11 => row := row11_move;
			when 12 => row := row12_move;
			when 13 => row := row13_move;
			when 14 => row := row14_move;
			when others => row := x"000000000000000";
		end case;

		col := (X - 1) / TILE_SIZE_MOVE;
		return row(59 - col * 4 downto 56 - col * 4);
	end GET_TILE;

	constant BOMB_CODING : std_logic_vector(3 downto 0) := x"D";
	shared variable x_int : integer range 0 to 480 := X_INIT_MOVE;
	shared variable y_int : integer range 0 to 480 := Y_INIT_MOVE;
	shared variable x_right_bottom : integer range 0 to 480 := X_INIT_MOVE + PLAYER_SIZE_MOVE - 1;
	shared variable y_right_bottom : integer range 0 to 480 := Y_INIT_MOVE + PLAYER_SIZE_MOVE - 1;
	
begin
	
	move_up_down : process(clk_move, rst_move)
	
	variable left_tile : std_logic_vector(3 downto 0);
	variable right_tile : std_logic_vector(3 downto 0);
	variable speed : integer range 0 to 5 := 1;

	begin
		if(rst_move = '0') then
			y_int := Y_INIT_MOVE;
			y_right_bottom := Y_INIT_MOVE + PLAYER_SIZE_MOVE - 1;
			speed := 1;
		elsif(clk_move'event and clk_move = '1') then
			if(up_move='0') then
				if((y_int - 1) mod TILE_SIZE_MOVE /= 0) then -- no row change
					y_int := y_int - speed;
				else
					left_tile := GET_TILE(x_int, y_int - 1);
					right_tile := GET_TILE(x_right_bottom, y_int - 1);
					if(to_integer(unsigned(left_tile))  < to_integer(unsigned(BOMB_CODING)) and to_integer(unsigned(right_tile))  < to_integer(unsigned(BOMB_CODING))) then -- next tile is allowed
						y_int := y_int - speed;
					end if;
				end if;
			elsif(down_move= '0') then
				if((y_int + PLAYER_SIZE_MOVE - 1) mod TILE_SIZE_MOVE /= 0) then
					y_int := y_int + speed;
				else
					left_tile := GET_TILE(x_int, y_int + 1 + PLAYER_SIZE_MOVE - 1);
					right_tile := GET_TILE(x_right_bottom, y_int + 1 + PLAYER_SIZE_MOVE - 1);
					if(to_integer(unsigned(left_tile))  < to_integer(unsigned(BOMB_CODING)) and to_integer(unsigned(right_tile)) < to_integer(unsigned(BOMB_CODING))) then
						y_int := y_int + speed;
					end if;
				end if;
			end if;
			y_right_bottom := y_int + PLAYER_SIZE_MOVE - 1;
		end if;
	end process move_up_down;


	move_left_right : process(clk_move, rst_move)
	
	variable upper_tile : std_logic_vector(3 downto 0);
	variable lower_tile : std_logic_vector(3 downto 0);
	variable speed : integer range 0 to 5 := 1;

	begin
		if(rst_move = '0') then
			x_int := X_INIT_MOVE;
			x_right_bottom := X_INIT_MOVE + PLAYER_SIZE_MOVE - 1;
			speed := 1;
		elsif(clk_move'event and clk_move = '1') then
			if(left_move='0') then
				if((x_int - 1) mod TILE_SIZE_MOVE /= 0) then
					x_int := x_int - speed;
				else
					upper_tile := GET_TILE(x_int - 1, y_int);
					lower_tile := GET_TILE(x_int - 1, y_int + PLAYER_SIZE_MOVE - 1);
					if(to_integer(unsigned(upper_tile)) < to_integer(unsigned(BOMB_CODING)) and to_integer(unsigned(lower_tile)) < to_integer(unsigned(BOMB_CODING))) then
						x_int := x_int - speed;
					end if;
				end if;
			elsif(right_move= '0') then
				if((x_int + PLAYER_SIZE_MOVE - 1) mod TILE_SIZE_MOVE /= 0) then
					x_int := x_int + speed;
				else
					upper_tile := GET_TILE(x_int + PLAYER_SIZE_MOVE - 1 + 1, y_int);
					lower_tile := GET_TILE(x_int + PLAYER_SIZE_MOVE - 1 + 1, y_int + PLAYER_SIZE_MOVE - 1);
					if(to_integer(unsigned(upper_tile)) < to_integer(unsigned(BOMB_CODING)) and to_integer(unsigned(lower_tile)) < to_integer(unsigned(BOMB_CODING))) then
						x_int := x_int + speed;
					end if;
				end if;
			end if;
			x_right_bottom := X_INIT_MOVE + PLAYER_SIZE_MOVE - 1;
		end if;
	end process move_left_right;
	
	output : process(fast_clk_move, rst_move)
	begin
		if(fast_clk_move'event and fast_clk_move = '1') then
			x_move <= std_logic_vector(to_unsigned(x_int, 9));
			y_move <= std_logic_vector(to_unsigned(y_int, 9));
		end if;
	end process output;
end movement_behav;
