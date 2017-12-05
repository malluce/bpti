library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sync_gen_ent is
	port(
		clk_sync : in std_logic;
		rst_sync : in std_logic;
		hsync_gen : out std_logic;
		vsync_gen : out std_logic;
		row_sync : out std_logic_vector(8 downto 0);
		col_sync : out std_logic_vector(9 downto 0)
	);
end sync_gen_ent;

architecture sync_gen_struct of sync_gen_ent is
	component hsync_ent
		port(
			clk_hsync : in std_logic;
			rst_hsync : in std_logic;
			hsync_out : out std_logic;
			col_hsync : out std_logic_vector(9 downto 0);
			row_hsync : out std_logic_vector(8 downto 0)
		);
	end component;

	component vsync_ent
		port(
			hsync_in : in std_logic;
			rst_vsync : in std_logic;
			vsync_out : out std_logic
		);
	end component;

	signal hsync_fwd : std_logic;

begin
	hsync : hsync_ent port map(
		clk_sync,
		rst_sync,
		hsync_fwd,
		col_sync,
		row_sync
	);

	vsync : vsync_ent port map(
		hsync_fwd,
		rst_sync,
		vsync_gen
	);

	hsync_gen <= hsync_fwd;

end sync_gen_struct;
