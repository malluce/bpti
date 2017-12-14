library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity movement_ent is
	generic(x_init, y_init : positive); 
	port(
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

	function X_TO_COL (X : integer) return integer is
	begin
		return (X - 1) / 32;
	end X_TO_COL;

	impure function Y_TO_ROW (Y : integer) return std_logic_vector is
	begin
		case ((Y - 1) / 32) is
			when 0 => return row0_move;
			when 1 => return row1_move;
			when 2 => return row2_move;
			when 3 => return row3_move;
			when 4 => return row4_move;
			when 5 => return row5_move;
			when 6 => return row6_move;
			when 7 => return row7_move;
			when 8 => return row8_move;
			when 9 => return row9_move;
			when 10 => return row10_move;
			when 11 => return row11_move;
			when 12 => return row12_move;
			when 13 => return row13_move;
			when 14 => return row14_move;
			when others => return x"000000000000000";
		end case;
	end Y_TO_ROW;

begin
	collission : process(clk_move, rst_move)
	
	constant SIZE : integer range 0 to 32 := 32;
	variable x_int : integer range 0 to 480 := x_init;
	variable y_int : integer range 0 to 480 := y_init;
	variable x_right_bottom : integer range 0 to 480 := x_init + SIZE - 1;
	variable y_right_bottom : integer range 0 to 480 := y_init + SIZE - 1;
	variable col_left : integer range 0 to 14;
	variable col_right : integer range 0 to 14;
	variable row_player : std_logic_vector(59 downto 0);
	variable row_upper : std_logic_vector(59 downto 0);
	variable row_lower : std_logic_vector(59 downto 0);
	variable row_next : std_logic_vector(59 downto 0);
	variable speed : integer range 0 to 5 := 1;
		


	begin
		if(clk_move'event and clk_move = '1') then
			if(up_move='1') then
				if((y_int - 1) mod 32 /= 0) then -- no row change
					y_int := y_int - speed;
				else
					col_left := X_TO_COL(x_int);
					col_right := X_TO_COL(x_right_bottom);
					row_next := Y_TO_ROW(y_int - 1);
					if(row_next(59 - col_left * 4 downto 56 - col_left * 4)  /= x"F" and -- next row is allowed
				   		row_next(59 - col_left * 4 downto 56 - col_left * 4)  /= x"1" and 
						row_next(59 - col_left * 4 downto 56 - col_left * 4)  /= x"2" and
						row_next(59 - col_right * 4 downto 56 - col_right * 4)  /= x"F" and 
				   		row_next(59 - col_right * 4 downto 56 - col_right * 4)  /= x"1" and 
						row_next(59 - col_right * 4 downto 56 - col_right * 4)  /= x"2") then
						y_int := y_int - speed;
					end if;
				end if;
			elsif(down_move= '1') then
				if((y_int + SIZE - 1) mod 32 /= 0) then
					y_int := y_int + speed;
				else
					col_left := X_TO_COL(x_int);
					col_right := X_TO_COL(x_right_bottom);
					row_next := Y_TO_ROW(y_int + 1 + SIZE - 1);
					if(row_next(59 - col_left * 4 downto 56 - col_left * 4)  /= x"F" and -- next row is allowed
				   		row_next(59 - col_left * 4 downto 56 - col_left * 4)  /= x"1" and 
						row_next(59 - col_left * 4 downto 56 - col_left * 4)  /= x"2" and
						row_next(59 - col_right * 4 downto 56 - col_right * 4)  /= x"F" and 
				   		row_next(59 - col_right * 4 downto 56 - col_right * 4)  /= x"1" and 
						row_next(59 - col_right * 4 downto 56 - col_right * 4)  /= x"2") then
						y_int := y_int + speed;
					end if;
				end if;
			elsif(left_move='1') then
				if((x_int - 1) mod 32 /= 0) then
					x_int := x_int - speed;
				else
					row_upper := Y_TO_ROW(y_int);
					row_lower := Y_TO_ROW(y_int + SIZE - 1);
					col_left := X_TO_COL(x_int - 1);
					if(row_upper(59 - col_left * 4 downto 56 - col_left * 4) /= x"F" and
						row_upper(59 - col_left * 4 downto 56 - col_left * 4) /= x"1" and
						row_upper(59 - col_left * 4 downto 56 - col_left * 4) /= x"2" and
						row_lower(59 - col_left * 4 downto 56 - col_left * 4) /= x"F" and
						row_lower(59 - col_left * 4 downto 56 - col_left * 4) /= x"1" and
						row_lower(59 - col_left * 4 downto 56 - col_left * 4) /= x"2") then
						x_int := x_int - speed;
					end if;
				end if;
			elsif(right_move= '1') then
				if((x_int + SIZE - 1) mod 32 /= 0) then
					x_int := x_int + speed;
				else
					row_upper := Y_TO_ROW(y_int);
					row_lower := Y_TO_ROW(y_int + SIZE - 1);
					col_left := X_TO_COL(x_int + SIZE - 1 + 1);
					if(row_upper(59 - col_left * 4 downto 56 - col_left * 4) /= x"F" and
						row_upper(59 - col_left * 4 downto 56 - col_left * 4) /= x"1" and
						row_upper(59 - col_left * 4 downto 56 - col_left * 4) /= x"2" and
						row_lower(59 - col_left * 4 downto 56 - col_left * 4) /= x"F" and
						row_lower(59 - col_left * 4 downto 56 - col_left * 4) /= x"1" and
						row_lower(59 - col_left * 4 downto 56 - col_left * 4) /= x"2") then
						x_int := x_int + speed;
					end if;
				end if;
			end if;
		end if;
		
		x_move <= std_logic_vector(to_unsigned(x_int, 9));
		y_move <= std_logic_vector(to_unsigned(y_int, 9));
	end process collission;
end movement_behav;
