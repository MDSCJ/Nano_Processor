----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 16:05:47
-- Design Name: 
-- Module Name: Register_bank_gr_46 - Behavioral
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

entity Register_bank_gr_46 is
    Port ( Clk : in STD_LOGIC;
           RegEN : in STD_LOGIC_VECTOR (2 downto 0);
           Data : in STD_LOGIC_VECTOR (3 downto 0);
           Reset : in STD_LOGIC;
           Reg0 : out STD_LOGIC_VECTOR (3 downto 0);
           Reg1 : out STD_LOGIC_VECTOR (3 downto 0);
           Reg2 : out STD_LOGIC_VECTOR (3 downto 0);
           Reg3 : out STD_LOGIC_VECTOR (3 downto 0);
           Reg4 : out STD_LOGIC_VECTOR (3 downto 0);
           Reg5 : out STD_LOGIC_VECTOR (3 downto 0);
           Reg6 : out STD_LOGIC_VECTOR (3 downto 0);
           Reg7 : out STD_LOGIC_VECTOR (3 downto 0));
end Register_bank_gr_46;

architecture Behavioral of Register_bank_gr_46 is

component Register_4_bit_gr_46
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
       EN : in STD_LOGIC;
       Clk : in STD_LOGIC;
       Reset : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Decoder_3_to_8_gr_46
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC ;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal Select_Reg : STD_LOGIC_VECTOR (7 downto 0);

begin
    Decoder_3_to_8_0 : Decoder_3_to_8_gr_46
              Port map( I=>RegEN,
                        EN=>'1',
                        Y=>Select_Reg );
                        
    Reg_0 : Register_4_bit_gr_46
                Port map ( D=>"0000", EN=>Select_Reg(0), Clk=>Clk, Reset=>Reset, Q=> Reg0 ); --Hardcoded to zero
    Reg_1 : Register_4_bit_gr_46
                Port map ( D=>Data, EN=>Select_Reg(1), Clk=>Clk, Reset=>Reset, Q=> Reg1 );
    Reg_2 : Register_4_bit_gr_46
                Port map ( D=>Data, EN=>Select_Reg(2), Clk=>Clk, Reset=>Reset, Q=> Reg2 );
    Reg_3 : Register_4_bit_gr_46
                Port map ( D=>Data, EN=>Select_Reg(3), Clk=>Clk, Reset=>Reset, Q=> Reg3 );
    Reg_4 : Register_4_bit_gr_46
                Port map ( D=>Data, EN=>Select_Reg(4), Clk=>Clk, Reset=>Reset, Q=> Reg4 );
    Reg_5 : Register_4_bit_gr_46
                Port map ( D=>Data, EN=>Select_Reg(5), Clk=>Clk, Reset=>Reset, Q=> Reg5 );
    Reg_6 : Register_4_bit_gr_46
                Port map ( D=>Data, EN=>Select_Reg(6), Clk=>Clk, Reset=>Reset, Q=> Reg6 );
    Reg_7 : Register_4_bit_gr_46
                Port map ( D=>Data, EN=>Select_Reg(7), Clk=>Clk, Reset=>Reset, Q=> Reg7 );                      
                  
end Behavioral;

