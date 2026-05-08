library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.clk_period;
use work.constants.clk_half_period;
use work.buses.all;
use work.ALU_H.Operation_Sel;

entity TB_IDecoder is
    -- port();
end TB_IDecoder;

architecture Behavioral of TB_IDecoder is

    component IDecoder is
        port(
            I : in instruction_bus;
            RCJump : in data_bus;
            Zero_Flag : in std_logic;
            Carry_Flag : in std_logic;
            Negative_Flag : in std_logic;
            REn : out register_address;
            RSA : out register_address;
            RSB : out register_address;
            OpS : out Operation_Sel;
            IM : out data_bus;
            J : out std_logic;
            JA : out instruction_address;
            L : out std_logic;
            RAM_Addr : out ram_address;
            RAM_WE : out std_logic;
            RAM_OE : out std_logic
        );
    end component;

    signal I : instruction_bus := (others => '0');
    signal RCJump : data_bus := (others => '0');
    signal Zero_Flag : std_logic := '0';
    signal Carry_Flag : std_logic := '0';
    signal Negative_Flag : std_logic := '0';
    signal REn : register_address;
    signal RSA : register_address;
    signal RSB : register_address;
    signal AS : Operation_Sel;
    signal IM : data_bus;
    signal J : std_logic;
    signal JA : instruction_address;
    signal L : std_logic;
    signal RAM_Addr : ram_address;
    signal RAM_WE : std_logic;
    signal RAM_OE : std_logic;

begin
    UUT: IDecoder port map(
        I => I,
        RCJump => RCJump,
        Zero_Flag => Zero_Flag,
        Carry_Flag => Carry_Flag,
        Negative_Flag => Negative_Flag,
        REn => REn,
        RSA => RSA,
        RSB => RSB,
        OpS => AS,
        IM => IM,
        J => J,
        JA => JA,
        L => L,
        RAM_Addr => RAM_Addr,
        RAM_WE => RAM_WE,
        RAM_OE => RAM_OE
    );

    stim: process
    begin
        -- Test 1: Arithmetic ADD R1, R2 (00 00 01 10)
        I <= "00000110";
        wait for clk_period;

        -- Test 2: Arithmetic SUB R2, R1 (00 01 10 01)
        I <= "00011001";
        wait for clk_period;

        -- Test 3: Arithmetic MUL R1, R3 (00 10 01 11)
        I <= "00100111";
        wait for clk_period;

        -- Test 4: Load R2 from RAM[5] (01 10 0101)
        I <= "01100101";
        wait for clk_period;

        -- Test 5: Store R1 to RAM[3] (10 01 0011)
        I <= "10010011";
        wait for clk_period;

        -- Test 6: Unconditional Jump to addr 7 (11 00 0111)
        I <= "11000111";
        wait for clk_period;

        -- Test 7: Jump if Zero to addr 4 (11 01 0100) with Zero_Flag = 0
        Zero_Flag <= '0';
        I <= "11010100";
        wait for clk_period;

        -- Test 8: Jump if Zero to addr 4 (11 01 0100) with Zero_Flag = 1
        Zero_Flag <= '1';
        I <= "11010100";
        wait for clk_period;

        -- Test 9: Jump if Carry to addr 2 (11 10 0010) with Carry_Flag = 1
        Zero_Flag <= '0';
        Carry_Flag <= '1';
        I <= "11100010";
        wait for clk_period;

        -- Test 10: Jump if Negative to addr 0 (11 11 0000) with Negative_Flag = 1
        Carry_Flag <= '0';
        Negative_Flag <= '1';
        I <= "11110000";
        wait for clk_period;

        wait;
    end process stim;

end Behavioral;
