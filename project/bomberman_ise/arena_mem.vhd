-- Contains the arena data and allows to modify it.
entity arena_mem_ent is
  port (
    clk_arena : in std_logic;
    rst_arena : in std_logic;
    enable_write_1 : in std_logic;
    adr_write_1 : in std_logic_vector(3 downto 0);
    data_write_1 : in std_logic_vector(59 downto 0);
    enable_write_2 : in std_logic;
    adr_write_2 : in std_logic_vector(3 downto 0);
    data_write_2 : in std_logic_vector(59 downto 0);
    row0_arena : out std_logic_vector(59 downto 0);
    row1_arena : out std_logic_vector(59 downto 0);
    row2_arena : out std_logic_vector(59 downto 0);
    row3_arena : out std_logic_vector(59 downto 0);
    row4_arena : out std_logic_vector(59 downto 0);
    row5_arena : out std_logic_vector(59 downto 0);
    row6_arena : out std_logic_vector(59 downto 0);
    row7_arena : out std_logic_vector(59 downto 0);
    row8_arena : out std_logic_vector(59 downto 0);
    row9_arena : out std_logic_vector(59 downto 0);
    row10_arena : out std_logic_vector(59 downto 0);
    row11_arena : out std_logic_vector(59 downto 0);
    row12_arena : out std_logic_vector(59 downto 0);
    row13_arena : out std_logic_vector(59 downto 0);
    row14_arena : out std_logic_vector(59 downto 0)
end entity;

architecture arena_mem_behav of arena_mem_ent is
    type memory is array (14 downto 0) of std_logic_vector(59 downto 0);

    -- contains the initial map state
    -- should be synthesized as ROM (dual-port)
    signal default_layout : memory := (
            x"FFFFFFFFFFFFFFF",
            x"F0F0F0F0F0F0F0F",
            x"FE0E0E0E0E0E0EF",
            x"FEF0F0F0F0F0FEF",
            x"FEE0E0E0E0E0EEF",
            x"FEF0F0F0F0F0FEF",
            x"FE0E0E0E0E0E0EF",
            x"FEF0F0F0F0F0FEF",
            x"FEE0E0E0E0E0EEF",
            x"FEF0F0F0F0F0FEF",
            x"FE0E0E0E0E0E0EF",
            x"F0F0F0F0F0F0F0F",
            x"F00EEEEEEEEE00F",
            x"FFFFFFFFFFFFFFF");

    -- contains the current map state
    -- should be synthesized as RAM (dual-port)
    signal current_layout : memory;
begin
    access_mem : process(clk_arena, clk_state)
    variable resetting : std_logic := '0'; -- indicates whether the memory is resetting i.e. current_layout is set to default_layout row-wise
    variable inited : std_logic := '0'; -- indicates whether the memory is inited i.e. current_layout had the default_layout once
    variable reset_cnt : integer range 0 to 15 := 0; -- index for ROM/RAM while resetting
    variable output_cnt : integer range 0 to 15 := 0; -- index for ROM/RAM while outputting
    begin
        if(clk_arena = '1' and clk_arena'event) then
            if(rst_arena = '0') then -- start resetting (do it in a 'loop' to not acces RAM more than twice in a clock cycle)
                resetting := '1';
            end if;
            if(resetting = '1' or init = '0') then
                if(reset_cnt = 14) then -- one more row to reset
                    current_layout(reset_cnt) <= default_layout(reset_cnt);
                    resetting := '0';
                    reset_cnt := 0;
                    inited := '1';
                elsif(reset_cnt <= 12) then -- two or more rows to reset
                    current_layout(reset_cnt) <= default_layout(reset_cnt);
                    reset_cnt := reset_cnt + 1;
                    current_layout(reset_cnt) <= default_layout(reset_cnt);
                    reset_cnt := reset_cnt + 1;
                end if;
            else -- not resetting right now
                if(enable_write_1 = '1') then
                    current_layout(to_integer(unsigned(adr_write_1))) <= data_write_1;
                end if;
                if(enable_write_2 = '1') then
                    current_layout(to_integer(unsigned(adr_write_2))) <= data_write_2;
                end if;
            end if;

            -- output 'loop' (again, to not access ram more than twice in a clock cycle)
            case( output_cnt ) is
                when 0 =>   row0_arena <= current_layout(0);
                            row1_arena <= current_layout(1);
                when 2 =>   row0_arena <= current_layout(2);
                            row1_arena <= current_layout(3);
                when 4 =>   row0_arena <= current_layout(4);
                            row1_arena <= current_layout(5);
                when 6 =>   row0_arena <= current_layout(6);
                            row1_arena <= current_layout(7);
                when 8 =>   row0_arena <= current_layout(8);
                            row1_arena <= current_layout(9);
                when 10 =>  row0_arena <= current_layout(10);
                            row1_arena <= current_layout(11);
                when 12 =>  row0_arena <= current_layout(12);
                            row1_arena <= current_layout(13);
                when 14 =>  row0_arena <= current_layout(14);
                when others => null;
            end case;

            if(output_cnt = 14) then
                output_cnt := 0;
            else
                output_cnt := output_cnt + 2;
            end if;
        end if;
    end process access_mem;
end architecture;
