----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2026 23:57:59
-- Design Name: 
-- Module Name: nanoprocessor_gr_46 - Behavioral
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

entity nanoprocessor_gr_46 is
    Port ( Clk : in STD_LOGIC;
       Reset : in STD_LOGIC;
       Overflow : out STD_LOGIC;
       Zero : out STD_LOGIC;
       Reg_7_Out : out STD_LOGIC_VECTOR (3 downto 0));
end nanoprocessor_gr_46;



architecture Behavioral of nanoprocessor_gr_46 is

component Register_bank_gr_46
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
end component;

component Program_counter_gr_46
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
       Res : in STD_LOGIC;
       Clk : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Program_ROM_gr_46
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
       instructions : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component Instruction_Decoder_gr_46
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
end component;

component Add_Sub_unit_gr_46
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
       B : in STD_LOGIC_VECTOR (3 downto 0);
       Add_Sub_Sel : in STD_LOGIC;
       S : out STD_LOGIC_VECTOR (3 downto 0);
       Carry : out STD_LOGIC;
       Zero : out STD_LOGIC);
end component;

component Adder_3_bit_gr_46
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
       S : out STD_LOGIC_VECTOR (2 downto 0);
       C_out : out STD_LOGIC);
end component;

component Mux_8_way_4_bit_gr_46
    Port ( I0, I1, I2, I3, I4, I5, I6, I7 : in STD_LOGIC_VECTOR(3 downto 0);
       Sel : in STD_LOGIC_VECTOR(2 downto 0);
       RegOut : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component Mux_2_way_3_bit_gr_46
    Port ( I0, I1 : in STD_LOGIC_VECTOR(2 downto 0);
       Sel : in STD_LOGIC;
       RegOut : out STD_LOGIC_VECTOR(2 downto 0));
end component;

component Mux_2_way_4_bit_gr_46
    Port ( I0, I1 : in STD_LOGIC_VECTOR(3 downto 0);
       Sel : in STD_LOGIC;
       RegOut : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component LUT_gr_46
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
       data : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal load_sel, sub, jflag : STD_LOGIC;
signal Pointer, PCaddress, reg_en, jump_add, adderOut, mux_1, mux_2 : STD_LOGIC_VECTOR (2 downto 0);
signal Instruction : STD_LOGIC_VECTOR (11 downto 0);
signal IVal, result, reg_data, r0,r1,r2,r3,r4,r5,r6,r7, data1, data2 :STD_LOGIC_VECTOR (3 downto 0);

begin

Program_Counter_0 : Program_counter_gr_46
port map(
   D => Pointer,
   Res => Reset,
   Clk => Clk,
   Q => PCaddress);

Program_Rom_0 : Program_ROM_gr_46
port map (
   address => PCaddress,
   instructions => Instruction); 
           
Instruction_Decoder_0 : Instruction_Decoder_gr_46
port map (
  Instruction => Instruction,
  Reg_Check_Jump => data1,
  Reg_EN => reg_en,
  Load_Sel => load_sel,
  Immediate_Value => IVal,
  RegA => mux_1,
  RegB => mux_2,
  Add_Sub_Sel => sub,
  Jump_Flag => jflag,
  Jump_Address => jump_add );   
                      
Register_Bank_0 : Register_bank_gr_46
port map (
  Clk    => Clk,
  RegEN  => reg_en,
  Data   => reg_data,
  Reset  => Reset,
  Reg0   => r0,
  Reg1   => r1,
  Reg2   => r2,
  Reg3   => r3,
  Reg4   => r4,
  Reg5   => r5,
  Reg6   => r6,
  Reg7   => r7);

Mux_8way_4bit_0 : Mux_8_way_4_bit_gr_46
port map (
  I0 => r0, I1 => r1, I2 => r2, I3 => r3, I4 => r4, I5 => r5, I6 => r6, I7 => r7,
  Sel => mux_1,
  RegOut => data1);

Mux_8way_4bit_1 : Mux_8_way_4_bit_gr_46
port map (
  I0 => r0, I1 => r1, I2 => r2, I3 => r3, I4 => r4, I5 => r5, I6 => r6, I7 => r7,
  Sel => mux_2,
  RegOut => data2);

Add_Sub_Unit_0 : Add_Sub_unit_gr_46
port map (
  A => data1,
  B => data2,
  Add_Sub_Sel => sub,
  S => result,
  Carry => Overflow,
  Zero => Zero);

Mux_2way_4bit_0 : Mux_2_way_4_bit_gr_46
port map (
  I0 => result,
  I1 => IVal,
  Sel => load_sel,
  RegOut => reg_data);

Adder_3bit_0 : Adder_3_bit_gr_46
port map (
  A => PCaddress,
  S => adderOut);

Mux_2way_3bit_0 : Mux_2_way_3_bit_gr_46
port map (
  I0 => adderOut,
  I1 => jump_add,
  Sel => jflag,
  RegOut => Pointer);

Reg_7_Out <= r7;
  
end Behavioral;
