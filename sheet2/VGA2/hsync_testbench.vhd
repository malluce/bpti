LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY hsync_testbench IS
END hsync_testbench;
 
ARCHITECTURE behavior OF hsync_testbench IS 
 
    COMPONENT hsync_ent
    PORT(
         clk_hsync : IN  std_logic;
         rst_hsync : IN  std_logic;
         hsync_out : OUT  std_logic;
         col_hsync : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_hsync : std_logic := '0';
   signal rst_hsync : std_logic := '0';

 	--Outputs
   signal hsync_out : std_logic;
   signal col_hsync : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant clk_hsync_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: hsync_ent PORT MAP (
          clk_hsync => clk_hsync,
          rst_hsync => rst_hsync,
          hsync_out => hsync_out,
          col_hsync => col_hsync
        );

   -- Clock process definitions
   clk_hsync_process :process
   begin
		clk_hsync <= '0';
		wait for clk_hsync_period/2;
		clk_hsync <= '1';
		wait for clk_hsync_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 704 ns;	
      wait for clk_hsync_period*10;

      -- insert stimulus here 
		
		
      wait;
   end process;

END;
