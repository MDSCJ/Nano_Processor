library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.clk_period;
use work.constants.clk_half_period;
use work.buses.all;
use work.cpu_components.all;
use work.ALU_H.all;


entity TB_Nanoprocessor is
    -- port();
end TB_Nanoprocessor;

architecture Behavioral of TB_Nanoprocessor is

    signal Clock : std_logic; -- Clock
    signal Reset : std_logic; -- Reset
    signal Data : data_bus;
    signal Overflow: std_logic;
    signal Zero : std_logic;
    
    signal Next_Address : instruction_address; -- From PC Incrementer to Address Selector
    signal Current_Address : instruction_address; -- From PC to ROM
    signal Selected_Address : instruction_address; -- From Address Selector to PC
    signal Jump_Address : instruction_address; -- From Instruction Decoder to Address Selector
    signal Jump_Flag : std_logic; -- From Instruction Decoder to Address Selector
    signal Instruction : instruction_bus; -- From Program ROM to Instruction Decoder
    
    signal Load_Selection : std_logic; -- From Instruction Decoder to Load Selector
    signal Immediate_Value : data_bus; -- From Instruction Decoder to Load Selector
    signal OprASelect : register_address; -- From Instruction Decoder to Operand Selector A
    signal OprBSelect : register_address; -- From Instruction Decoder to Operand Selector B
    signal OprAData : data_bus; -- From Operand Selector A to AU
    signal OprBData : data_bus; -- From Operand Selector B to AU
    signal Operation_Res : data_bus; -- From AU to Load Selector
    signal Register_Data : data_buses; -- From Register Bank to Operand Selectors
    signal AddSubSelect : Operation_Sel; -- From Instruction Decoder to AU
    signal Register_Enable : register_address; -- From Instruction Decoder to Register Bank
    signal Selected_Load : data_bus; -- From Load Selector to Register Bank
    
    -- ALU Flags
    signal ALU_Zero : std_logic;
    signal ALU_Overflow : std_logic;
    signal ALU_Carry : std_logic;
    signal ALU_Negative : std_logic;
    
    -- RAM signals
    signal RAM_Addr_Internal : ram_address;
    signal RAM_Dout_Internal : data_bus;
    signal RAM_WE : std_logic;
    signal RAM_OE : std_logic;
    
    begin
    
        -- Program Counter
        Program_Counter : PC port map(
            A => Selected_Address, -- From Address Selector
            Clk => Clock,
            Res => Reset,
            M => Current_Address -- Goes to ROM
        );
    
        -- Program Counter Incrementer
        PC_Incrementer : PC_Inc port map(
            A_in => Current_Address, -- From PC
            A_out => Next_Address -- To Address Selector
        );
    
        -- Address Selector
        Address_Selector_0 : Address_Selector port map(
            PC => Next_Address, -- From PC Incrementer
            JA => Jump_Address, -- From Instruction Decoder
            J => Jump_Flag, -- From Instruction Decoder
            A => Selected_Address -- To Program Counter
        );
    
        -- Program ROM
        Program_ROM_0 : Program_ROM port map(
            ROM_address => Current_Address, -- From PC
            I => Instruction -- To Instruction Decoder
        ); 
    
        -- Instruction Decoder
        Instruction_Decoder : IDecoder port map(
            I => Instruction, -- From Program ROM
            RCJump => OprAData, -- From Operand Selector A
            Zero_Flag => ALU_Zero, -- From AU
            Carry_Flag => ALU_Carry, -- From AU
            Negative_Flag => ALU_Negative, -- From AU
            REn => Register_Enable, -- To Register Bank 
            RSA => OprASelect, -- To Operand Selector A
            RSB => OprBSelect, -- To Operand Selector B
            OpS => AddSubSelect, -- To AU
            IM => Immediate_Value, -- To Load Selector
            J => Jump_Flag, -- To Address Selector
            JA => Jump_Address, -- To Address Selector
            L => Load_Selection, -- To Load Selector
            RAM_Addr => RAM_Addr_Internal, -- To RAM
            RAM_WE => RAM_WE, -- To RAM
            RAM_OE => RAM_OE -- To RAM
        );
    
        -- RAM Module
        RAM_Module : entity work.RAM port map(
            Clk => Clock,
            Res => Reset,
            RAM_Addr => RAM_Addr_Internal,
            RAM_Din => OprAData,
            RAM_Dout => RAM_Dout_Internal,
            RAM_WE => RAM_WE,
            RAM_OE => RAM_OE
        );
    
        -- Load Selector
        Load_Selector_0 : Load_Selector port map(
            LS => Load_Selection, -- From Instruction Decoder
            IM => Immediate_Value, -- From Instruction Decoder
            R => RAM_Dout_Internal, -- From RAM
            O => Selected_Load -- To Register Bank
        );
    
        -- Operand Selector (Multiplexer) A
        Opr_Selector_A : Opr_Selector port map(
            Control => OprASelect, -- From Instruction Decoder
            Data => Register_Data, -- From Register Bank
            Selected => OprAData -- To AU
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
            Overflow => ALU_Overflow, -- Overflow Flag
            Zero => ALU_Zero, -- Zero Flag
            Carry => ALU_Carry, -- Carry Flag
            Negative => ALU_Negative, -- Negative Flag
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
    
        -- Expose top-level signals
        Overflow <= ALU_Overflow;
        Zero <= ALU_Zero;
        Data <= Register_Data(3); -- Last Register Data (R3)

        clk_process : process
        begin
            Clock <= '0';
            wait for clk_half_period;
            Clock <= '1';
            wait for clk_half_period;
        end process;

        reset_process : process
        begin
            Reset <= '1';
            wait for clk_period;
            Reset <= '0';
            wait;
        end process;

        
    end Behavioral;