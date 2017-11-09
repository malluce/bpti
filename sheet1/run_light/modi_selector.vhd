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
	type DIR is (FWD, BWD);
	type MODUS_0_STATES is (D10_D11, D9_D12, D8_D13, D7_D14);
	type MODUS_1_STATES is (INIT_1, D14_D13, D12_D11, D10_D9, D8_D7);
	signal modus_pressed : std_logic := '0';
	signal direction_pressed : std_logic := '0';
	
begin
	set_process : process(clock_sel, reset_sel)
	variable modus_0_state : MODUS_0_STATES := D10_D11;
	variable modus_1_state : MODUS_1_STATES := INIT_1;
	variable modus_2_state : MODUS_1_STATES := INIT_1;
	variable modus : integer range 0 to 2 := 0;
	variable direction : DIR := FWD;
	begin
		if reset_sel = '0' then
			vector_sel <= "00000000";
			modus := 0;
			direction := FWD;
			modus_0_state := D10_D11;
			modus_1_state := INIT_1;
			modus_2_state := INIT_1;
		else 
			if clock_sel'event and clock_sel = '1' then
				if  modus_sel = '1' and modus_pressed = '0' then	
					modus_pressed <= '1';
					modus := modus + 1;
					MODUS_INIT : case modus is
						when 0 => modus_0_state := D10_D11;
						when 1 => modus_1_state := INIT_1;
						when 2 => modus_2_state := INIT_1;
					end case MODUS_INIT;
				elsif direction_sel ='1' and direction_pressed = '0' then
					if (direction = FWD) then
						direction := BWD;
					else 
						direction := FWD;
					end if;
					direction_pressed <= '1';	
				elsif modus_sel = '0' and modus_pressed = '1' then
					modus_pressed <= '0';
				elsif direction_sel = '0' and direction_pressed = '1' then
					direction_pressed <= '0';
				end if;		
				
				if (modus = 0 and direction = FWD) then 
					MODUS_0_CASE_FWD : case modus_0_state is
						when D10_D11 => modus_0_state := D9_D12; 
											 vector_sel <= "00011000";
						when D9_D12 => modus_0_state := D8_D13;
											vector_sel <= "00100100";
						when D8_D13 => modus_0_state := D7_D14;
											vector_sel <= "01000010";
						when D7_D14 => modus_0_state := D10_D11;
											vector_sel <= "10000001";
					end case MODUS_0_CASE_FWD;
				elsif (modus = 0 and direction = BWD) then
					MODUS_0_CASE_BWD : case modus_0_state is
						when D10_D11 => modus_0_state := D7_D14; 
											 vector_sel <= "00011000";
						when D9_D12 => modus_0_state := D10_D11;
											vector_sel <= "00100100";
						when D8_D13 => modus_0_state := D9_D12;
											vector_sel <= "01000010";
						when D7_D14 => modus_0_state := D8_D13;
											vector_sel <= "10000001";
					end case MODUS_0_CASE_BWD;
					
				elsif (modus = 1 and direction = FWD) then
					MODUS_1_CASE_FWD : case modus_1_state is
						when INIT_1 => modus_1_state := D14_D13;
										 vector_sel <= "00000000";
						when D14_D13 => modus_1_state := D12_D11;
											 vector_sel <= "00000011";
						when D12_D11 => modus_1_state := D10_D9;
											 vector_sel <= "00001111";
						when D10_D9 => modus_1_state := D8_D7;
											vector_sel <= "00111111";
						when D8_D7 => modus_1_state := INIT_1;
										  vector_sel <= "11111111";
					end case MODUS_1_CASE_FWD;
				elsif (modus = 1 and direction = BWD) then
					MODUS_1_CASE_BWD : case modus_1_state is
						when INIT_1 => modus_1_state := D8_D7;
										 vector_sel <= "11111111";
						when D14_D13 => modus_1_state := INIT_1;
											 vector_sel <= "00000000";
						when D12_D11 => modus_1_state := D14_D13;
											 vector_sel <= "00000011";
						when D10_D9 => modus_1_state := D12_D11;
											vector_sel <= "00001111";
						when D8_D7 => modus_1_state := D10_D9;
										  vector_sel <= "00111111";
					end case MODUS_1_CASE_BWD;
					
				elsif (modus = 2 and direction = FWD) then
					MODUS_2_CASE_FWD : case modus_2_state is
						when INIT_1 => modus_2_state := D14_D13;
										 vector_sel <= "00000000";
						when D14_D13 => modus_2_state := D8_D7;
											 vector_sel <= "00000011";
						when D12_D11 => modus_2_state := D10_D9;
											 vector_sel <= "11001111";
						when D10_D9 => modus_2_state := INIT_1;
											vector_sel <= "11111111";
						when D8_D7 => modus_2_state := D12_D11;
										  vector_sel <= "11000011";
					end case MODUS_2_CASE_FWD;
				elsif (modus = 2 and direction = BWD) then
					MODUS_2_CASE_BWD : case modus_2_state is
						when INIT_1 => modus_2_state := D14_D13;
										 vector_sel <= "11111111";
						when D14_D13 => modus_2_state := D8_D7;
											 vector_sel <= "11001111";
						when D12_D11 => modus_2_state := D10_D9;
											 vector_sel <= "00000011";
						when D10_D9 => modus_2_state := INIT_1;
											vector_sel <= "00000000";
						when D8_D7 => modus_2_state := D12_D11;
										  vector_sel <= "11000011";
					end case MODUS_2_CASE_BWD;
					
				end if;
			end if;
		end if;
	end process set_process;
end modi_selector_behav;

