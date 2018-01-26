entity arena_mem_ent is
  port (
    clk_arena : in std_logic;
    rst_arena : in std_logic;
    -- the new rows (may be changed by bombs/explosions)
    newRow0_arena : in std_logic_vector(59 downto 0);
    newRow1_arena : in std_logic_vector(59 downto 0);
    newRow2_arena : in std_logic_vector(59 downto 0);
    newRow3_arena : in std_logic_vector(59 downto 0);
    newRow4_arena : in std_logic_vector(59 downto 0);
    newRow5_arena : in std_logic_vector(59 downto 0);
    newRow6_arena : in std_logic_vector(59 downto 0);
    newRow7_arena : in std_logic_vector(59 downto 0);
    newRow8_arena : in std_logic_vector(59 downto 0);
    newRow9_arena : in std_logic_vector(59 downto 0);
    newRow10_arena : in std_logic_vector(59 downto 0);
    newRow11_arena : in std_logic_vector(59 downto 0);
    newRow12_arena : in std_logic_vector(59 downto 0);
    newRow13_arena : in std_logic_vector(59 downto 0);
    newRow14_arena : in std_logic_vector(59 downto 0);
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

    variable default_layout : memory := (
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

    variable current_layout : memory := default_layout;
begin
    forward : process(clk_arena, clk_state)
    begin
        if(rst_arena = '0') then
            current_layout(0) := default_layout(0);
            current_layout(1) := default_layout(1);
            current_layout(2) := default_layout(2);
            current_layout(3) := default_layout(3);
            current_layout(4) := default_layout(4);
            current_layout(5) := default_layout(5);
            current_layout(6) := default_layout(6);
            current_layout(7) := default_layout(7);
            current_layout(8) := default_layout(8);
            current_layout(9) := default_layout(9);
            current_layout(10) := default_layout(10);
            current_layout(11) := default_layout(11);
            current_layout(12) := default_layout(12);
            current_layout(13) := default_layout(13);
            current_layout(14) := default_layout(14);
        elsif(clk_arena = '1' and clk_arena'event) then
            -- new rows contain at least one tile which is not non destroyable
            -- hence "FFFFFFFFFFFFFFF" is used as indicator that the row has not been changed
            if(newRow0_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(0) := newRow0_arena;
            end if;
            if(newRow1_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(1) := newRow1_arena;
            end if;
            if(newRow2_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(2) := newRow2_arena;
            end if;
            if(newRow3_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(3) := newRow3_arena;
            end if;
            if(newRow4_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(4) := newRow4_arena;
            end if;
            if(newRow4_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(4) := newRow4_arena;
            end if;
            if(newRow5_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(5) := newRow5_arena;
            end if;
            if(newRow6_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(6) := newRow6_arena;
            end if;
            if(newRow7_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(7) := newRow7_arena;
            end if;
            if(newRow8_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(8) := newRow8_arena;
            end if;
            if(newRow9_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(9) := newRow9_arena;
            end if;
            if(newRow10_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(10) := newRow10_arena;
            end if;
            if(newRow11_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(11) := newRow11_arena;
            end if;
            if(newRow12_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(12) := newRow12_arena;
            end if;
            if(newRow13_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(13) := newRow13_arena;
            end if;
            if(newRow14_arena /= "FFFFFFFFFFFFFFF") then
                current_layout(14) := newRow14_arena;
            end if;

            -- always output current arena layout
            row0_arena := current_layout(0);
            row1_arena := current_layout(1);
            row2_arena := current_layout(2);
            row3_arena := current_layout(3);
            row4_arena := current_layout(4);
            row5_arena := current_layout(5);
            row6_arena := current_layout(6);
            row7_arena := current_layout(7);
            row8_arena := current_layout(8);
            row9_arena := current_layout(9);
            row10_arena := current_layout(10);
            row11_arena := current_layout(11);
            row12_arena := current_layout(12);
            row13_arena := current_layout(13);
            row14_arena := current_layout(14);
        end if;
    end process forward;
end architecture;
