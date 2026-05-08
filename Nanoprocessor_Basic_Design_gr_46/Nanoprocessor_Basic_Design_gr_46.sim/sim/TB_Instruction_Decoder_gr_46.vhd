----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 20:15:11
-- Design Name: 
-- Module Name: TB_Instruction_decoder_gr_46 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Instruction_decoder_gr_46 is
--  Port ( );
end TB_Instruction_decoder_gr_46;

architecture Behavioral of TB_Instruction_decoder_gr_46 is

    component Instruction_Decoder_gr_46
        Port (
            Instruction : in STD_LOGIC_VECTOR (11 downto 0);
            Reg_Check_Jump : in STD_LOGIC_VECTOR (3 downto 0);
            Add_Sub_Sel : out STD_LOGIC;
            RegA : out STD_LOGIC_VECTOR (2 downto 0);
            RegB : out STD_LOGIC_VECTOR (2 downto 0);
            Immediate_Value : out STD_LOGIC_VECTOR (3 downto 0);
            Load_Sel : out STD_LOGIC;
            Reg_EN : out STD_LOGIC_VECTOR (2 downto 0);
            Jump_Flag : out STD_LOGIC;
            Jump_Address : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    signal Instruction : STD_LOGIC_VECTOR (11 downto 0);
    signal Reg_Check_Jump : STD_LOGIC_VECTOR (3 downto 0);
    signal Add_Sub_Sel : STD_LOGIC;
    signal RegA : STD_LOGIC_VECTOR (2 downto 0);
    signal RegB : STD_LOGIC_VECTOR (2 downto 0);
    signal Immediate_Value : STD_LOGIC_VECTOR (3 downto 0);
    signal Load_Sel : STD_LOGIC;
    signal Reg_EN : STD_LOGIC_VECTOR (2 downto 0);
    signal Jump_Flag : STD_LOGIC;
    signal Jump_Address : STD_LOGIC_VECTOR (2 downto 0);

begin

    uut: Instruction_Decoder_gr_46
        port map (
            Instruction => Instruction,
            Reg_Check_Jump => Reg_Check_Jump,
            Add_Sub_Sel => Add_Sub_Sel,
            RegA => RegA,
            RegB => RegB,
            Immediate_Value => Immediate_Value,
            Load_Sel => Load_Sel,
            Reg_EN => Reg_EN,
            Jump_Flag => Jump_Flag,
            Jump_Address => Jump_Address
        );

    process
    begin
        -- 240272 = 11 1010101010 010000
        -- 240278 = 11 1010101010 010110
        -- 240255 = 11 10101010 01111111
        -- 240238 = 11 10101010 01101110
        
        -- Test ADD instruction (OpCode 00):
        -- 240272 tail: 101010010000
        Instruction <= "001010010000"; -- ADD derived from 240272
        Reg_Check_Jump <= "0001"; 
        wait for 20 ns;
        
        -- 240278 tail: 101010010110
        Instruction <= "001010010110"; -- ADD derived from 240278
        Reg_Check_Jump <= "0001";
        wait for 20 ns;
        
        -- 240255 tail: 101001111111
        Instruction <= "001010011111"; -- ADD derived from 240255
        Reg_Check_Jump <= "0001";
        wait for 20 ns;
        
        -- 240238 tail: 101001101110
        Instruction <= "001010011011"; -- ADD derived from 240238
        Reg_Check_Jump <= "0001";
        wait for 20 ns;
        
        
        -- Test NEG instruction (OpCode 01):
        -- 240272
        Instruction <= "011010100100"; -- NEG derived from 240272
        Reg_Check_Jump <= "0001"; 
        wait for 20 ns;
        -- 240278
        Instruction <= "011010100101"; -- NEG derived from 240278
        Reg_Check_Jump <= "0001"; 
        wait for 20 ns;
        -- 240255
        Instruction <= "011010100111"; -- NEG derived from 240255
        Reg_Check_Jump <= "0001"; 
        wait for 20 ns;
        -- 240238
        Instruction <= "011010100110"; -- NEG derived from 240238
        Reg_Check_Jump <= "0001";
        wait for 20 ns;
        
        
        -- Test MOVI instruction (OpCode 10):
        -- 240272 => 101010010000
        Instruction <= "101010010000"; 
        Reg_Check_Jump <= "0001"; 
        wait for 20 ns;
        -- 240278 => 101010010110
        Instruction <= "101010010110";
        Reg_Check_Jump <= "0001"; 
        wait for 20 ns;
        -- 240255 => 101001111111
        Instruction <= "101010011111";
        Reg_Check_Jump <= "0001"; 
        wait for 20 ns;
        -- 240238 => 101001101110
        Instruction <= "101010011011";
        Reg_Check_Jump <= "0001"; 
        wait for 20 ns;
        
        
        -- Test JZR instruction with zero reg (OpCode 11):
        -- 240272 => 101010010000
        Instruction <= "111010010000"; 
        Reg_Check_Jump <= "0000"; -- Zero -> Jump expected
        wait for 20 ns;
        -- 240278 => 101010010110
        Instruction <= "111010010110";
        Reg_Check_Jump <= "0000"; 
        wait for 20 ns;

        -- Test JZR instruction with non-zero reg (OpCode 11):
        -- 240255 => 101001111111
        Instruction <= "111010011111";
        Reg_Check_Jump <= "1001"; -- Non-zero -> No jump
        wait for 20 ns;
        -- 240238 => 101001101110
        Instruction <= "111010011011";
        Reg_Check_Jump <= "0001"; 
        wait for 20 ns;        
        
        wait; -- Wait forever
    end process;

end Behavioral;