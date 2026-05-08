----------------------------------------------------------------------------------
-- Create Date: 05/01/2026 03:45:35 PM
-- Module Name: TB_IDecoder_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Constants_gr_46.all;
use work.Buses_gr_46.all;
use work.ALU_H_gr_46.Operation_Sel;

entity TB_IDecoder_gr_46 is
end TB_IDecoder_gr_46;

architecture Behavioral of TB_IDecoder_gr_46 is
    component IDecoder_gr_46 is
        port(I:in instruction_bus; RCJump:in data_bus;
            Zero_Flag:in std_logic; Carry_Flag:in std_logic; Negative_Flag:in std_logic;
            REn:out register_address; RSA:out register_address; RSB:out register_address;
            OpS:out Operation_Sel; IM:out data_bus; J:out std_logic;
            JA:out instruction_address; L:out std_logic;
            RAM_Addr:out ram_address; RAM_WE:out std_logic; RAM_OE:out std_logic);
    end component;
    signal I:instruction_bus:=(others=>'0');
    signal RCJump:data_bus:=(others=>'0');
    signal Zero_Flag,Carry_Flag,Negative_Flag:std_logic:='0';
    signal REn,RSA,RSB:register_address;
    signal AS:Operation_Sel; signal IM:data_bus;
    signal J:std_logic; signal JA:instruction_address;
    signal L:std_logic; signal RAM_Addr:ram_address;
    signal RAM_WE,RAM_OE:std_logic;
begin
    UUT: IDecoder_gr_46 port map(I=>I, RCJump=>RCJump,
        Zero_Flag=>Zero_Flag, Carry_Flag=>Carry_Flag, Negative_Flag=>Negative_Flag,
        REn=>REn, RSA=>RSA, RSB=>RSB, OpS=>AS, IM=>IM, J=>J, JA=>JA,
        L=>L, RAM_Addr=>RAM_Addr, RAM_WE=>RAM_WE, RAM_OE=>RAM_OE);
    stim: process begin
        I<="00000110"; wait for clk_period; -- ADD R1,R2
        I<="00011001"; wait for clk_period; -- SUB R2,R1
        I<="00100111"; wait for clk_period; -- MUL R1,R3
        I<="01100101"; wait for clk_period; -- LOAD R2,RAM[5]
        I<="10010011"; wait for clk_period; -- STORE R1,RAM[3]
        I<="11000111"; wait for clk_period; -- JMP 7
        Zero_Flag<='0'; I<="11010100"; wait for clk_period; -- JZ 4 (no jump)
        Zero_Flag<='1'; I<="11010100"; wait for clk_period; -- JZ 4 (jump)
        Zero_Flag<='0'; Carry_Flag<='1'; I<="11100010"; wait for clk_period; -- JC 2
        Carry_Flag<='0'; Negative_Flag<='1'; I<="11110000"; wait for clk_period; -- JN 0
        wait;
    end process;
end Behavioral;
