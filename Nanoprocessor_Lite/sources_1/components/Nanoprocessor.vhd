library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;
use work.cpu_components.all;
use work.ALU_H.all;

-- 8-Bit Nanoprocessor with RAM support
-- Supports Arithmetic, Move, and Jump operations
-- 4 registers × 8 bits each
-- 16 instruction × 8 bits program memory
-- 16 word × 8 bits data memory (RAM)
entity Nanoprocessor is
    port(
        Clk : in std_logic;         -- Clock
        Res : in std_logic;         -- Reset
        Overflow : out std_logic;   -- Overflow Flag
        Zero : out std_logic;       -- Zero Flag
        Data : out data_bus;        -- Last Register output
        RAM_Addr : out ram_address; -- RAM address for external debugging
        RAM_Dout : out data_bus     -- RAM data output for external debugging
    );
end Nanoprocessor;

architecture Behavioral of Nanoprocessor is

signal Clock : std_logic;
signal Reset : std_logic;

    -- PC and Address signals
    signal Next_Address : instruction_address;      -- From PC Incrementer
    signal Current_Address : instruction_address;   -- From PC
    signal Selected_Address : instruction_address;  -- From Address Selector
    signal Jump_Address : instruction_address;      -- From Instruction Decoder
    signal Jump_Flag : std_logic;                   -- From Instruction Decoder
    signal Instruction : instruction_bus;           -- From Program ROM
    
    -- Instruction Decoder outputs
    signal Load_Selection : std_logic;              -- From Instruction Decoder
    signal Immediate_Value : data_bus;             -- From Instruction Decoder
    signal OprASelect : register_address;          -- Operand A register select
    signal OprBSelect : register_address;          -- Operand B register select
    signal OprAData : data_bus;                    -- From Operand Selector A
    signal OprBData : data_bus;                    -- From Operand Selector B
    signal Operation_Res : data_bus;               -- From ALU
    signal Register_Data : data_buses;             -- From Register Bank
    signal AddSubSelect : Operation_Sel;           -- ALU operation select
    signal Register_Enable : register_address;     -- Register write enable
    signal Selected_Load : data_bus;               -- From Load Selector
    
    -- ALU Flags for jump conditions
    signal ALU_Zero : std_logic;                   -- Zero flag
    signal ALU_Overflow : std_logic;               -- Overflow flag
    signal ALU_Carry : std_logic;                  -- Carry flag
    signal ALU_Negative : std_logic;               -- Negative flag
    
    -- RAM signals
    signal RAM_Addr_Internal : ram_address;        -- RAM address
    signal RAM_Din : data_bus;                     -- RAM data input
    signal RAM_Dout_Internal : data_bus;           -- RAM data output
    signal RAM_WE : std_logic;                     -- RAM write enable
    signal RAM_OE : std_logic;                     -- RAM output enable
    
begin

    Clock <= Clk;
    Reset <= Res;
    
    -- Expose RAM signals for debugging
    RAM_Addr <= RAM_Addr_Internal;
    RAM_Dout <= RAM_Dout_Internal;
    
    -- Program Counter
    Program_Counter : PC port map(
        A => Selected_Address,
        Clk => Clock,
        Res => Reset,
        M => Current_Address
    );
    
    -- Program Counter Incrementer
    PC_Incrementer : PC_Inc port map(
        A_in => Current_Address,
        A_out => Next_Address
    );
    
    -- Address Selector
    Address_Selector_0 : Address_Selector port map(
        PC => Next_Address,
        JA => Jump_Address,
        J => Jump_Flag,
        A => Selected_Address
    );
    
    -- Program ROM
    Program_ROM_0 : Program_ROM port map(
        ROM_address => Current_Address,
        I => Instruction
    );
    
    -- Instruction Decoder
    Instruction_Decoder : IDecoder port map(
        I => Instruction,
        RCJump => Register_Data(0),  -- Use R0 for conditional jumps
        Zero_Flag => ALU_Zero,
        Carry_Flag => ALU_Carry,
        Negative_Flag => ALU_Negative,
        REn => Register_Enable,
        RSA => OprASelect,
        RSB => OprBSelect,
        OpS => AddSubSelect,
        IM => Immediate_Value,
        J => Jump_Flag,
        JA => Jump_Address,
        L => Load_Selection,
        RAM_Addr => RAM_Addr_Internal,
        RAM_WE => RAM_WE,
        RAM_OE => RAM_OE
    );
    
    -- RAM Module
    RAM_Module : entity work.RAM port map(
        Clk => Clock,
        Res => Reset,
        RAM_Addr => RAM_Addr_Internal,
        RAM_Din => OprAData,          -- Source register data for store
        RAM_Dout => RAM_Dout_Internal,
        RAM_WE => RAM_WE,
        RAM_OE => RAM_OE
    );
    
    -- Load Selector: Choose between Immediate, ALU result, or RAM data
    Load_Selector_0 : Load_Selector port map(
        LS => Load_Selection,
        IM => Immediate_Value,
        R => RAM_Dout_Internal,       -- RAM data or ALU result
        O => Selected_Load
    );
    
    -- Operand Selector A
    Opr_Selector_A : Opr_Selector port map(
        Control => OprASelect,
        Data => Register_Data,
        Selected => OprAData
    );
    
    -- Operand Selector B
    Opr_Selector_B : Opr_Selector port map(
        Control => OprBSelect,
        Data => Register_Data,
        Selected => OprBData
    );
    
    -- Arithmetic Unit
    Arithmetic_Unit_0 : AU port map(
        I1 => OprAData,
        I2 => OprBData,
        O => Operation_Res,
        Overflow => Overflow,
        Zero => ALU_Zero,
        Carry => ALU_Carry,
        Negative => ALU_Negative,
        Operation => AddSubSelect
    );
    
    -- Expose ALU Zero flag to top-level output as well
    Zero <= ALU_Zero;
    
    -- Register Bank (4 registers × 8 bits)
    Register_Bank_0 : Register_Bank port map(
        Reg_EN => Register_Enable,
        Res => Reset,
        Clk => Clock,
        Data => Selected_Load,
        Data_Buses => Register_Data
    );
    
    Data <= Register_Data(3);  -- Output last register (R3)
    
end Behavioral;

        );
    
        -- Operand Selector (Multiplexer) B
        Opr_Selector_B : Opr_Selector port map(
            Control => OprBSelect, -- From Instruction Decoder
            Data => Register_Data, -- From Register Bank
            Selected => OprBData -- To AU
        );
    
        -- Arithmetic Unit
        Arithmetic_Unit_0 : AU port map(
            I1 => OprAData, -- From Operand Selector A
            I2 => OprBData, -- From Operand Selector B
            O => Operation_Res, -- To Load Selector
            Overflow => Overflow, -- To Overflow Flag
            Zero => Zero, -- To Zero Flag
            Operation => AddSubSelect -- From Instruction Decoder
        );
    
        -- Register Bank
        Register_Bank_0 : Register_Bank port map(
            Reg_EN => Register_Enable, -- From Instruction Decoder
            Res => Reset, -- Reset
            Clk => Clock,
            Data => Selected_Load, -- From Load Selector
            Data_Buses => Register_Data -- To Operand Selectors
        );
    
        Data <= Register_Data(7); -- Last Register Data
        
    end Behavioral;
