----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 20:10:51
-- Design Name: 
-- Module Name: Instruction_Decoder_gr_46 - Behavioral
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

entity Instruction_Decoder_gr_46 is
     Port ( Instruction : in STD_LOGIC_VECTOR (11 downto 0);
           Reg_Check_Jump : in STD_LOGIC_VECTOR (3 downto 0);
           Add_Sub_Sel : out STD_LOGIC;
           RegA: out STD_LOGIC_VECTOR (2 downto 0);
           RegB : out STD_LOGIC_VECTOR (2 downto 0);
           Immediate_Value : out STD_LOGIC_VECTOR (3 downto 0);
           Load_Sel : out STD_LOGIC;
           Reg_EN : out STD_LOGIC_VECTOR (2 downto 0);
           Jump_Flag : out STD_LOGIC;
           Jump_Address : out STD_LOGIC_VECTOR (2 downto 0));
end Instruction_Decoder_gr_46;

architecture Behavioral of Instruction_Decoder_gr_46 is

signal Operator : std_logic_vector (1 downto 0);

begin
    Operator <= Instruction(11 downto 10);
    
    process (Operator, Instruction, Reg_Check_Jump) begin
        
        Add_Sub_Sel <= '0';
        Jump_Flag <= '0';
        Load_Sel <= '0';
        RegA <= "000"; 
        RegB <= "000";
        Immediate_Value <= "0000";
        Reg_EN <= "000";
        Jump_Address <= "000";
 
        if Operator = "00" then --ADD
            RegA <= Instruction(9 downto 7);
            RegB <= Instruction(6 downto 4);           
            Reg_EN <= Instruction(9 downto 7);
           
        elsif Operator = "01" then --NEG
            Reg_EN <= Instruction(9 downto 7);
            RegB <= Instruction(9 downto 7);
            Add_Sub_Sel <= '1';
                                            
        elsif Operator = "10" then --MOVI   
            Immediate_Value <= Instruction(3 downto 0);
            Reg_EN <= Instruction(9 downto 7);
            Load_Sel <= '1'; 
               
        elsif Operator = "11" then --JZR
            Jump_Address <= Instruction(2 downto 0);
            RegA <= Instruction(9 downto 7); 
            if Reg_Check_Jump = "0000" then 
                Jump_Flag <= '1';             
            end if;                             
        end if;
        
    end process;

end Behavioral;
