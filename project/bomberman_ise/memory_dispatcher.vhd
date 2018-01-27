-- Is used to handle at most six arena_mem accesses by putting them in a FIFO queue. They will be handled in at most three clock cycles (two writes per clock cycle). --
entity memory_dispatcher_ent is
  port (
    clk_dispatch : in std_logic;
    -- input write request to dispatch --

    -- used of first bomb
    enable_write_1 : in std_logic;
    adr_write_1 : in std_logic_vector(3 downto 0);
    data_write_1 : in std_logic_vector(59 downto 0);
    enable_write_2 : in std_logic;
    adr_write_2 : in std_logic_vector(3 downto 0);
    data_write_2 : in std_logic_vector(59 downto 0);
    enable_write_3 : in std_logic;
    adr_write_3 : in std_logic_vector(3 downto 0);
    data_write_3 : in std_logic_vector(59 downto 0);

    -- used of second bomb
    enable_write_4 : in std_logic;
    adr_write_4 : in std_logic_vector(3 downto 0);
    data_write_4 : in std_logic_vector(59 downto 0);
    enable_write_5 : in std_logic;
    adr_write_5 : in std_logic_vector(3 downto 0);
    data_write_5 : in std_logic_vector(59 downto 0);
    enable_write_6 : in std_logic;
    adr_write_6 : in std_logic_vector(3 downto 0);
    data_write_6 : in std_logic_vector(59 downto 0);

    -- dispatched write request --
    enable_out_1 : out std_logic;
    adr_out_1 : out std_logic_vector(3 downto 0);
    data_out_1 : out std_logic_vector(59 downto 0);
    enable_out_2 : out std_logic;
    adr_out_2 : out std_logic_vector(3 downto 0);
    data_out_2 : out std_logic_vector(59 downto 0)
  );
end entity;

architecture memory_dispatcher_behav of memory_dispatcher_ent is
    type enable_arr is array(5 downto 0) of std_logic;
    type adr_arr is array(5 downto 0) of std_logic_vector(3 downto 0);
    type data_arr is array(5 downto 0) of std_logic_vector(59 downto 0);
begin
    dispatch :
    if(clk_dispatch = '1' and clk_dispatch'event) then
        -- TODO
    end if;

end architecture;
