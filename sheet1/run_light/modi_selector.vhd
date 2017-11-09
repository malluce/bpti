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
	signal modus_pressed : std_logic := '0';
	signal direction_pressed : std_logic := '0';
	
begin
	set_process : process(clock_sel, reset_sel)
	variable modus_0_state : MODUS_0_STATES := D10_D11;
	variable modus : integer range 0 to 2 := 0;
	variable direction : DIR := FWD;
	begin
		if reset_sel = '0' then
			vector_sel <= "00000000";
			modus := 0;
			direction := FWD;
			modus_0_state := D10_D11;
		else 
			if clock_sel'event and clock_sel = '1' then
				if  modus_sel = '1' and modus_pressed = '0' then	
					modus_pressed <= '1';
					modus := modus + 1;
					MODUS_INIT : case modus is
						when 0 => modus_0_state := D10_D11;
						when 1 => modus_0_state := D10_D11; -- platzhalter
						when 2 => modus_0_state := D10_D11; -- platzhalter
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
				end if;
			end if;
		end if;
	end process set_process;
end modi_selector_behav;

