library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modi_selector is
	port(
		clock_sel : in std_logic;
		modus_sel : in std_logic;
		direction_sel : in std_logic;
		reset_sel : in std_logic;
		vector_sel : out std_logic_vector(7 downto 0)
	);
end modi_selector;

architecture modi_selector_behav of modi_selector is
	type DIR is (FWD, BWD); -- type for current direction
	type MODUS_STATES is (INIT, FIRST, SECOND, THIRD, FOURTH); -- type for current state (every modus has 5 states)
	signal modus_pressed : std_logic := '0';
	signal direction_pressed : std_logic := '0';
	
begin
	set_process : process(clock_sel, reset_sel)
	variable state : MODUS_STATES := INIT;
	variable modus : integer range 0 to 3 := 0;
	variable direction : DIR := FWD;
	begin
		if reset_sel = '0' then
			vector_sel <= "00000000";
			modus := 0;
			direction := FWD;
			state := INIT;
		else 
			if clock_sel'event and clock_sel = '1' then
				-- increment modus and go to INIT state
				if  modus_sel = '1' and modus_pressed = '0' then	
					modus_pressed <= '1';
					modus := modus + 1;
					state := INIT;
				-- possibly toggle direction
				elsif direction_sel ='1' and direction_pressed = '0' then
					if (direction = FWD) then
						direction := BWD;
					else 
						direction := FWD;
					end if;
					direction_pressed <= '1';
				-- reset modus and direction when not pressed	
				elsif modus_sel = '0' and modus_pressed = '1' then
					modus_pressed <= '0';
				elsif direction_sel = '0' and direction_pressed = '1' then
					direction_pressed <= '0';
				end if;
				
				-- state changes (forwards or backwards)
				if(direction = FWD) then
					STATE_FWD : case state is
						when INIT => state := FIRST;
						when FIRST => state := SECOND;
						when SECOND => state := THIRD;
						when THIRD => state := FOURTH;
						when FOURTH => state := INIT;
					end case STATE_FWD;
				elsif(direction = BWD) then
					STATE_BWD : case state is
						when INIT => state := FOURTH;
						when FIRST => state := INIT;
						when SECOND => state := FIRST;
						when THIRD => state := SECOND;
						when FOURTH => state := THIRD;
					end case STATE_BWD;
				end if;
				

				-- in the following every modus has a certain output depending on current state
				if (modus = 0) then 
					MODUS_0_CASE : case state is
						when INIT => vector_sel <= "00000000";
						when FIRST => vector_sel <= "00011000";
						when SECOND => vector_sel <= "00100100";
						when THIRD => vector_sel <= "01000010";
						when FOURTH => vector_sel <= "10000001";
					end case MODUS_0_CASE;
					
				elsif (modus = 1) then
					MODUS_1_CASE : case state is
						when INIT => vector_sel <= "00000000";
						when FIRST => vector_sel <= "00000011";
						when SECOND => vector_sel <= "00001111";
						when THIRD => vector_sel <= "00111111";
						when FOURTH => vector_sel <= "11111111";
					end case MODUS_1_CASE;
					
				elsif (modus = 2) then
					MODUS_2_CASE : case state is
						when INIT => vector_sel <= "00000000";
						when FIRST => vector_sel <= "00000011";
						when SECOND => vector_sel <= "11000011";
						when THIRD => vector_sel <= "11001111";
						when FOURTH => vector_sel <= "11111111";
					end case MODUS_2_CASE;
					
				elsif (modus = 3) then
					MODUS_3_CASE : case state is
						when INIT => vector_sel <= "00000000";
						when FIRST => vector_sel <= "11000011";
						when SECOND => vector_sel <= "01100110";
						when THIRD => vector_sel <= "00111100";
						when FOURTH => vector_sel <= "00011000";
					end case MODUS_3_CASE;
					
				end if;
			end if;
		end if;
	end process set_process;
end modi_selector_behav;

