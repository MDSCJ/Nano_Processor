

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Instruction_Decoder_TB is
end Instruction_Decoder_TB;

architecture Behavioral of Instruction_Decoder_TB is

    -- Component declaration
    component Instruction_Decoder
        Port (
            Instruction      : in  STD_LOGIC_VECTOR(12 downto 0);
            Reg_Check_Jump   : in  STD_LOGIC_VECTOR(3 downto 0);
            Add_Sub_Sel      : out STD_LOGIC;
            RegA             : out STD_LOGIC_VECTOR(2 downto 0);
            RegB             : out STD_LOGIC_VECTOR(2 downto 0);
            Immediate_Value  : out STD_LOGIC_VECTOR(3 downto 0);
            Load_Sel         : out STD_LOGIC;
            Reg_EN           : out STD_LOGIC_VECTOR(2 downto 0);
            Jump_Flag        : out STD_LOGIC;
            Jump_Address     : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    -- Signals
    signal Instruction      : STD_LOGIC_VECTOR(12 downto 0);
    signal Reg_Check_Jump   : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Add_Sub_Sel      : STD_LOGIC;
    signal RegA             : STD_LOGIC_VECTOR(2 downto 0);
    signal RegB             : STD_LOGIC_VECTOR(2 downto 0);
    signal Immediate_Value  : STD_LOGIC_VECTOR(3 downto 0);
    signal Load_Sel         : STD_LOGIC;
    signal Reg_EN           : STD_LOGIC_VECTOR(2 downto 0);
    signal Jump_Flag        : STD_LOGIC;
    signal Jump_Address     : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Instruction_Decoder
        Port Map (
            Instruction      => Instruction,
            Reg_Check_Jump   => Reg_Check_Jump,
            Add_Sub_Sel      => Add_Sub_Sel,
            RegA             => RegA,
            RegB             => RegB,
            Immediate_Value  => Immediate_Value,
            Load_Sel         => Load_Sel,
            Reg_EN           => Reg_EN,
            Jump_Flag        => Jump_Flag,
            Jump_Address     => Jump_Address
        );

    -- Stimulus process
    stimulus: process
    begin

        -- ADD: 000 AAA BBB 0000 => 000_111_001_0000
        Instruction <= "0001110010000";
        wait for 10 ns;

        -- NEG: 001 RRR 0000000 => 001_010_0000000
        Instruction <= "0010100000000";
        wait for 10 ns;

        -- MOVI: 010 RRR 000 dddd => 010_111_000_1111
        Instruction <= "0101110001111";  -- MOVI R7, #15
        wait for 10 ns;

        -- JZR: 011 RRR 0000 ddd => 011_011_0000_110
        Reg_Check_Jump <= "0101";  -- Simulate non-zero condition
        Instruction <= "0110110000110";  -- JZR R3, addr 110
        wait for 10 ns;

        -- COMP: 100 AAA BBB 0000 => 100_100_011_0000
        Instruction <= "1001000110000";
        wait for 10 ns;

        -- EVEN/ODD: 101 RRR 000 0000 => 101_001_000_0000
        Instruction <= "1010010000000";
        wait for 10 ns;

        -- MUL: 110 AAA BBB 0000 => 110_010_101_0000
        Instruction <= "1100101010000";
        wait for 10 ns;

        -- DIV: 111 AAA BBB 0000 => 111_110_010_0000
        Instruction <= "1111100100000";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;