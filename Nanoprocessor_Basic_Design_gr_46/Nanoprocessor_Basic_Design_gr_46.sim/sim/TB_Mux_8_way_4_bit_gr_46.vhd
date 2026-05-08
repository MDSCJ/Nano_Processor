----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 11:08:40
-- Design Name: 
-- Module Name: TB_Mux_8_way_4_bit_gr_46 - Behavioral
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

entity TB_Mux_8_way_4_bit_gr_46 is
--  Port ( );
end TB_Mux_8_way_4_bit_gr_46;

architecture Behavioral of TB_Mux_8_way_4_bit_gr_46 is

   component Mux_8_way_4_bit_gr_46
        Port (
            I0, I1, I2, I3, I4, I5, I6, I7 : in STD_LOGIC_VECTOR(3 downto 0);
            Sel : in STD_LOGIC_VECTOR(2 downto 0);
            RegOut : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    signal I0_tb, I1_tb, I2_tb, I3_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal I4_tb, I5_tb, I6_tb, I7_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal Sel_tb : STD_LOGIC_VECTOR(2 downto 0);
    signal RegOut_tb : STD_LOGIC_VECTOR(3 downto 0);
    
begin
    uut: Mux_8_way_4_bit_gr_46
    port map (
        I0 => I0_tb, I1 => I1_tb, I2 => I2_tb, I3 => I3_tb,
        I4 => I4_tb, I5 => I5_tb, I6 => I6_tb, I7 => I7_tb,
        Sel => Sel_tb,
        RegOut => RegOut_tb );

process
    begin
    -- 240272 => I0="0000", I1="1001"
    -- 240278 => I2="0110", I3="1001"
    -- 240255 => I4="1111", I5="0111" 
    -- 240238 => I6="1110", I7="0110" 

    I0_tb <= "0000";
    I1_tb <= "1001";
    I2_tb <= "0110";
    I3_tb <= "1001";
    I4_tb <= "1111"; 
    I5_tb <= "0111";
    I6_tb <= "1110";
    I7_tb <= "0110";
    
    
    Sel_tb <= "000"; wait for 100 ns; -- I0 (0000)
    Sel_tb <= "001"; wait for 100 ns; -- I1 (1001)
    Sel_tb <= "010"; wait for 100 ns; -- I2 (0110)
    Sel_tb <= "011"; wait for 100 ns; -- I3 (1001)
    Sel_tb <= "100"; wait for 100 ns; -- I4 (1111)
    Sel_tb <= "101"; wait for 100 ns; -- I5 (0111)
    Sel_tb <= "110"; wait for 100 ns; -- I6 (1110)
    Sel_tb <= "111"; wait for 100 ns; -- I7 (0110)
    
    
    Sel_tb <= "UUU"; wait for 100 ns; 
    
    wait; 
    end process;
end Behavioral;

