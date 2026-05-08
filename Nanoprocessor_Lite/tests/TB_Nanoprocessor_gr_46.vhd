----------------------------------------------------------------------------------
-- Create Date: 05/01/2026 05:05:30 PM
-- Module Name: TB_Nanoprocessor_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Constants_gr_46.all;
use work.Buses_gr_46.all;
use work.Cpu_Components_gr_46.all;
use work.ALU_H_gr_46.all;

entity TB_Nanoprocessor_gr_46 is
end TB_Nanoprocessor_gr_46;

architecture Behavioral of TB_Nanoprocessor_gr_46 is
    signal Clock : std_logic;
    signal Reset : std_logic;
    signal Data : data_bus;
    signal Overflow : std_logic;
    signal Zero : std_logic;
    signal Next_Address, Current_Address, Selected_Address, Jump_Address : instruction_address;
    signal Jump_Flag : std_logic;
    signal Instruction : instruction_bus;
    signal Load_Selection : std_logic;
    signal Immediate_Value : data_bus;
    signal OprASelect, OprBSelect : register_address;
    signal OprAData, OprBData, Operation_Res : data_bus;
    signal Register_Data : data_buses;
    signal AddSubSelect : Operation_Sel;
    signal Register_Enable : register_address;
    signal Selected_Load : data_bus;
    signal ALU_Zero, ALU_Overflow, ALU_Carry, ALU_Negative : std_logic;
    signal RAM_Addr_Internal : ram_address;
    signal RAM_Dout_Internal : data_bus;
    signal RAM_WE, RAM_OE : std_logic;
begin
    Program_Counter: PC_gr_46 port map(
        A=>Selected_Address, Clk=>Clock, Res=>Reset, M=>Current_Address);
    PC_Incrementer: PC_Inc_gr_46 port map(
        A_in=>Current_Address, A_out=>Next_Address);
    Address_Selector_0: Address_Selector_gr_46 port map(
        PC=>Next_Address, JA=>Jump_Address, J=>Jump_Flag, A=>Selected_Address);
    Program_ROM_0: Program_ROM_gr_46 port map(
        ROM_address=>Current_Address, I=>Instruction);
    Instruction_Decoder: IDecoder_gr_46 port map(
        I=>Instruction, RCJump=>OprAData,
        Zero_Flag=>ALU_Zero, Carry_Flag=>ALU_Carry, Negative_Flag=>ALU_Negative,
        REn=>Register_Enable, RSA=>OprASelect, RSB=>OprBSelect,
        OpS=>AddSubSelect, IM=>Immediate_Value,
        J=>Jump_Flag, JA=>Jump_Address, L=>Load_Selection,
        RAM_Addr=>RAM_Addr_Internal, RAM_WE=>RAM_WE, RAM_OE=>RAM_OE);
    RAM_Module: entity work.RAM_gr_46 port map(
        Clk=>Clock, Res=>Reset, RAM_Addr=>RAM_Addr_Internal,
        RAM_Din=>OprAData, RAM_Dout=>RAM_Dout_Internal,
        RAM_WE=>RAM_WE, RAM_OE=>RAM_OE);
    Load_Selector_0: Load_Selector_gr_46 port map(
        LS=>Load_Selection, IM=>Immediate_Value, R=>RAM_Dout_Internal, O=>Selected_Load);
    Opr_Selector_A: Opr_Selector_gr_46 port map(
        Control=>OprASelect, Data=>Register_Data, Selected=>OprAData);
    Opr_Selector_B: Opr_Selector_gr_46 port map(
        Control=>OprBSelect, Data=>Register_Data, Selected=>OprBData);
    Arithmetic_Unit_0: AU_gr_46 port map(
        I1=>OprAData, I2=>OprBData, O=>Operation_Res,
        Overflow=>ALU_Overflow, Zero=>ALU_Zero,
        Carry=>ALU_Carry, Negative=>ALU_Negative,
        Operation=>AddSubSelect);
    Register_Bank_0: Register_Bank_gr_46 port map(
        Reg_EN=>Register_Enable, Res=>Reset, Clk=>Clock,
        Data=>Selected_Load, Data_Buses=>Register_Data);
    Overflow <= ALU_Overflow;
    Zero <= ALU_Zero;
    Data <= Register_Data(3);

    clk_process: process begin
        Clock<='0'; wait for clk_half_period;
        Clock<='1'; wait for clk_half_period;
    end process;
    reset_process: process begin
        Reset<='1'; wait for clk_period; Reset<='0'; wait;
    end process;
end Behavioral;
