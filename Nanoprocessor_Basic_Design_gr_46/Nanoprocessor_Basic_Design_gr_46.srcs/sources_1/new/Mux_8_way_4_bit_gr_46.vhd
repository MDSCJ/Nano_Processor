----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 10:48:10
-- Design Name: 
-- Module Name: Mux_8_way_4_bit_gr_46 - Behavioral
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

entity Mux_8_way_4_bit_gr_46 is
    Port ( I0, I1, I2, I3, I4, I5, I6, I7 : in STD_LOGIC_VECTOR(3 downto 0);
           Sel : in STD_LOGIC_VECTOR(2 downto 0);
           RegOut : out STD_LOGIC_VECTOR(3 downto 0));
end Mux_8_way_4_bit_gr_46;

architecture Behavioral of Mux_8_way_4_bit_gr_46 is


begin
    with Sel select
    RegOut <= I0 when "000",
              I1 when "001",
              I2 when "010",
              I3 when "011",
              I4 when "100",
              I5 when "101",
              I6 when "110",
              I7 when "111",
              (others => '0') when others;

end Behavioral;

