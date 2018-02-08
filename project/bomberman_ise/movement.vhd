library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity movement_ent is
	generic(X_INIT_MOVE, Y_INIT_MOVE, PLAYER_SIZE_MOVE, TILE_SIZE_MOVE : integer);
	port(
		clk_move : in std_logic;
		rst_move : in std_logic;
		up_move : in std_logic;
		down_move : in std_logic;
		left_move : in std_logic;
		right_move : in std_logic;
		row_upper_move : in std_logic_vector(59 downto 0);
		row_mid_move : in std_logic_vector(59 downto 0);
		row_lower_move : in std_logic_vector(59 downto 0);
		x_move : out std_logic_vector(8 downto 0);
		y_move : out std_logic_vector(8 downto 0)
	);
end movement_ent;

architecture movement_behav of movement_ent is
	constant BOMB_CODING : std_logic_vector(3 downto 0) := x"D";
	
	shared variable x_int : integer range 0 to 480 := X_INIT_MOVE;
	shared variable y_int : integer range 0 to 480 := Y_INIT_MOVE;
	shared variable x_right : integer range 0 to 480 := X_INIT_MOVE + PLAYER_SIZE_MOVE - 1;

begin

	move_up_down : process(clk_move, rst_move)


	-- the left/right tile which may cause collision when moving up/down
	variable left_tile : std_logic_vector(3 downto 0);
	variable right_tile : std_logic_vector(3 downto 0);
	
	-- index for accessing left/right upper/lower tile from a row vector
	variable row_idx_left : integer range 0 to 59;
	variable row_idx_right : integer range 0 to 59;
	
	variable x_tmp : integer range 0 to 480;
	variable x_right_tmp : integer range 0 to 480;
	variable y_tmp : integer range 0 to 480;
	
	variable speed : integer range 0 to 5 := 1;

	begin
		if(rst_move = '0') then
			y_int := Y_INIT_MOVE;
			speed := 1;
		elsif(clk_move'event and clk_move = '1') then
			x_tmp := x_int;
			x_right_tmp := x_right;
			y_tmp := y_int;
			row_idx_left := 59 - (x_tmp-1)/TILE_SIZE_MOVE * 4;
			row_idx_right := 59 - (x_right_tmp-1)/TILE_SIZE_MOVE * 4;
			if(up_move='0') then
				if((y_tmp - 1) mod TILE_SIZE_MOVE /= 0) then -- no row change through moving
					y_int := y_tmp - speed;
				else
					left_tile := row_upper_move(row_idx_left downto row_idx_left - 3);
					right_tile := row_upper_move(row_idx_right downto row_idx_right - 3);
					if(to_integer(unsigned(left_tile))  < to_integer(unsigned(BOMB_CODING)) and to_integer(unsigned(right_tile))  < to_integer(unsigned(BOMB_CODING))) then -- check collision
						y_int := y_tmp - speed;
					end if;
				end if;
			elsif(down_move= '0') then
				if((y_tmp + PLAYER_SIZE_MOVE - 1) mod TILE_SIZE_MOVE /= 0) then -- no row change
					y_int := y_tmp + speed;
				else
					left_tile := row_lower_move(row_idx_left downto row_idx_left - 3);
					right_tile := row_lower_move(row_idx_right downto row_idx_right - 3);
					if(to_integer(unsigned(left_tile))  < to_integer(unsigned(BOMB_CODING)) and to_integer(unsigned(right_tile))  < to_integer(unsigned(BOMB_CODING))) then -- check collision
						y_int := y_tmp + speed;
					end if;
				end if;
			end if;
			y_move <= std_logic_vector(to_unsigned(y_tmp, 9));
		end if;
	end process move_up_down;


	move_left_right : process(clk_move, rst_move)

	-- the upper/lower tile which may cause collision when moving left/right
	variable upper_tile : std_logic_vector(3 downto 0);
	variable lower_tile : std_logic_vector(3 downto 0);
	
	variable row_idx : integer range 0 to 59;
	
	variable x_tmp : integer range 0 to 480;
	variable x_right_tmp : integer range 0 to 480;
	variable y_tmp : integer range 0 to 480;
	
	variable speed : integer range 0 to 5 := 1;

	begin
		if(rst_move = '0') then
			x_int := X_INIT_MOVE;
			x_right := X_INIT_MOVE + PLAYER_SIZE_MOVE - 1;
			speed := 1;
		elsif(clk_move'event and clk_move = '1') then
			x_tmp := x_int;
			x_right_tmp := x_right;
			y_tmp := y_int;
			if(left_move='0') then
				if((x_tmp - 1) mod TILE_SIZE_MOVE /= 0) then
					x_int := x_tmp - speed;
				else
					row_idx := 59 - (x_tmp-2)/TILE_SIZE_MOVE * 4;
					if((y_tmp - 1) mod TILE_SIZE_MOVE = 0) then
						-- player is row-wise tile aligned, just need to check row_mid
						if(to_integer(unsigned(row_mid_move(row_idx downto row_idx - 3))) < to_integer(unsigned(BOMB_CODING))) then
							x_int := x_tmp - speed;
						end if;
					else
							-- player is in two tiles, need to check both
							if((y_tmp + (PLAYER_SIZE_MOVE/2 - 1)) /TILE_SIZE_MOVE = y_tmp/TILE_SIZE_MOVE) then
								upper_tile := row_upper_move(row_idx downto row_idx - 3);
								lower_tile := row_mid_move(row_idx downto row_idx - 3);
								if(to_integer(unsigned(upper_tile)) < to_integer(unsigned(BOMB_CODING)) and to_integer(unsigned(lower_tile)) < to_integer(unsigned(BOMB_CODING))) then
									x_int := x_tmp - speed;
								end if;
							else
								upper_tile := row_mid_move(row_idx downto row_idx - 3);
								lower_tile := row_lower_move(row_idx downto row_idx - 3);
								if(to_integer(unsigned(upper_tile)) < to_integer(unsigned(BOMB_CODING)) and to_integer(unsigned(lower_tile)) < to_integer(unsigned(BOMB_CODING))) then
									x_int := x_tmp - speed;
								end if;
							end if;
						end if;
				end if;
			elsif(right_move= '0') then
				if((x_tmp + PLAYER_SIZE_MOVE - 1) mod TILE_SIZE_MOVE /= 0) then
					x_int := x_tmp + speed;
				else
					row_idx := 59 - (x_right_tmp)/TILE_SIZE_MOVE * 4;
					if((y_tmp - 1) mod TILE_SIZE_MOVE = 0) then
						-- player is row-wise tile aligned, just need to check row_mid
						if(to_integer(unsigned(row_mid_move(row_idx downto row_idx - 3))) < to_integer(unsigned(BOMB_CODING))) then
							x_int := x_tmp + speed;
						end if;
					else
							-- player is in two tiles, need to check both
							if((y_tmp + (PLAYER_SIZE_MOVE/2 - 1)) /TILE_SIZE_MOVE = y_tmp/TILE_SIZE_MOVE) then
								upper_tile := row_upper_move(row_idx downto row_idx - 3);
								lower_tile := row_mid_move(row_idx downto row_idx - 3);
								if(to_integer(unsigned(upper_tile)) < to_integer(unsigned(BOMB_CODING)) and to_integer(unsigned(lower_tile)) < to_integer(unsigned(BOMB_CODING))) then
									x_int := x_tmp + speed;
								end if;
							else
								upper_tile := row_mid_move(row_idx downto row_idx - 3);
								lower_tile := row_lower_move(row_idx downto row_idx - 3);
								if(to_integer(unsigned(upper_tile)) < to_integer(unsigned(BOMB_CODING)) and to_integer(unsigned(lower_tile)) < to_integer(unsigned(BOMB_CODING))) then
									x_int := x_tmp + speed;
								end if;
							end if;
						end if;
					end if;
				end if;
			x_right := x_int + PLAYER_SIZE_MOVE - 1;
			x_move <= std_logic_vector(to_unsigned(x_int, 9));
		end if;
	end process move_left_right;

end movement_behav;
