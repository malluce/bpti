library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VGA_ent is
	port(
		clk : in std_logic;
		rst : in std_logic;
		hsync : out std_logic;
		vsync : out std_logic;
		red_0 : out std_logic;
		red_1 : out std_logic;
		red_2 : out std_logic;
		red_3 : out std_logic;
		blue_0 : out std_logic;
		blue_1 : out std_logic;
		blue_2 : out std_logic;
		blue_3 : out std_logic;
		green_0 : out std_logic;
		green_1 : out std_logic;
		green_2 : out std_logic;
		green_3 : out std_logic
	);
end VGA_ent;

architecture VGA_struct of VGA_ent is
		component sync_gen_ent
			port(clk_sync : in std_logic;
				  rst_sync : in std_logic;
				  hsync_gen : out std_logic;
				  vsync_gen : out std_logic;
				  row_sync : out std_logic_vector(8 downto 0);
				  col_sync : out std_logic_vector(9 downto 0));
		end component;
		
		component pixel_gen_ent
			port(row : in std_logic_vector(8 downto 0);
				  col : in std_logic_vector(9 downto 0);
				  red : out std_logic_vector(3 downto 0); 
				  green : out std_logic_vector(3 downto 0);
				  blue : out std_logic_vector(3 downto 0)
			);
		end component;
		
		component rgb_assign_ent
			port(red_assign : in std_logic_vector(3 downto 0); 
				  green_assign : in std_logic_vector(3 downto 0);
				  blue_assign : in std_logic_vector(3 downto 0);
				  red_assign_0 : out std_logic;
				  red_assign_1 : out std_logic;
				  red_assign_2 : out std_logic;
			     red_assign_3 : out std_logic;
				  blue_assign_0 : out std_logic;
				  blue_assign_1 : out std_logic;
				  blue_assign_2 : out std_logic;
				  blue_assign_3 : out std_logic;
				  green_assign_0 : out std_logic;
				  green_assign_1 : out std_logic;
				  green_assign_2 : out std_logic;
				  green_assign_3 : out std_logic);
		end component;
		
		signal row_fwd : std_logic_vector(8 downto 0);
		signal col_fwd : std_logic_vector(9 downto 0);
		signal red_fwd : std_logic_vector(3 downto 0);
		signal green_fwd : std_logic_vector(3 downto 0);
		signal blue_fwd : std_logic_vector(3 downto 0);

begin
	sync : sync_gen_ent port map(
		clk,
		rst,
		hsync,
		vsync,
		row_fwd,
		col_fwd
	);
	
	pixel : pixel_gen_ent port map(
		row_fwd,
		col_fwd,
		red_fwd,
		green_fwd,
		blue_fwd
	);
	
	assign : rgb_assign_ent port map(
		red_fwd,
		green_fwd,
		blue_fwd,
		red_0,
		red_1,
		red_2,
		red_3,
		blue_0,
		blue_1,
		blue_2,
		blue_3,
		green_0,
		green_1,
		green_2,
		green_3
	);
	
end VGA_struct;

