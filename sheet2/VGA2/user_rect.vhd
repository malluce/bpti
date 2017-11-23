library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity user_rect is
	 generic(user_width_rect, user_height_rect : positive);
    Port ( clk_user_rect : in std_logic;
			  rst_user_rect : in std_logic;
			  button_up : in  STD_LOGIC;
           button_down : in  STD_LOGIC;
           button_left : in  STD_LOGIC;
           button_right : in  STD_LOGIC;
			  x_rect_out : out std_logic_vector(9 downto 0);
			  y_rect_out : out std_logic_vector(8 downto 0));
end user_rect;

architecture user_behav of user_rect is
begin
	button_process : process(clk_user_rect, rst_user_rect)
	variable x_rect_int : integer range 1 to 640 := 1;
	variable y_rect_int : integer range 1 to 480 := 1;
	variable up_pressed : std_logic := '0';
	variable down_pressed : std_logic := '0';
	variable left_pressed : std_logic := '0';
	variable right_pressed : std_logic := '0';
	constant x_factor : integer range 0 to 64 := 64; 
	constant y_factor : integer range 0 to 48 := 48;
	begin
		if(rst_user_rect = '0') then
			up_pressed := '0';
			down_pressed := '0';
			left_pressed := '0';
			right_pressed := '0';
			x_rect_int := 1;
			y_rect_int := 1;
		elsif(clk_user_rect'event and clk_user_rect = '1') then
			if(button_up = '1' and up_pressed = '0') then
				if((y_rect_int - y_factor) >= 1) then
					y_rect_int := y_rect_int - y_factor;
				else 
					y_rect_int := 1;
				end if;
				up_pressed := '1';
			elsif(button_up = '0' and up_pressed = '1') then
				up_pressed := '0';
			elsif(button_down = '1' and down_pressed = '0') then
				if((y_rect_int + y_factor + user_height_rect) <= 480) then
					y_rect_int := y_rect_int + y_factor;
				else 
					y_rect_int := 480 - user_height_rect;
				end if;
				down_pressed := '1';
			elsif(button_down = '0' and down_pressed = '1') then
				down_pressed := '0';
			end if;
			
			if(button_left = '1' and left_pressed = '0') then
				if((x_rect_int - x_factor) >= 1) then
					x_rect_int := x_rect_int - x_factor;
				else
					x_rect_int := 1;
				end if;
				left_pressed := '1';
			elsif(button_left = '0' and left_pressed = '1') then
				left_pressed := '0';
			elsif(button_right = '1' and right_pressed = '0') then
				if((x_rect_int + x_factor + user_width_rect) <= 640) then
					x_rect_int := x_rect_int + x_factor;
				else 
					x_rect_int := 640 - user_width_rect;
				end if;
				right_pressed := '1';
			elsif(button_right = '0' and right_pressed = '1') then
				 right_pressed := '0';
			end if;
			x_rect_out <= std_logic_vector(to_unsigned(x_rect_int, 10));
			y_rect_out <= std_logic_vector(to_unsigned(y_rect_int, 9));
		end if;
	end process button_process;
end user_behav;

