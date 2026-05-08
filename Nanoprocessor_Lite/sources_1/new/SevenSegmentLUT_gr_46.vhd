----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2026 04:45:03 PM
-- Design Name: 
-- Module Name: SevenSegmentLUT_gr_46 - Behavioral
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
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

entity SevenSegmentLUT_gr_46 is
    Port ( address : in STD_LOGIC_VECTOR(3 downto 0);
           seg : out STD_LOGIC_VECTOR(6 downto 0));
end SevenSegmentLUT_gr_46;

architecture Behavioral of SevenSegmentLUT_gr_46 is
begin
    process(address) begin
        case address is
            when "0000" => seg <= "0000001"; -- 0
            when "0001" => seg <= "1001111"; -- 1
            when "0010" => seg <= "0010010"; -- 2
            when "0011" => seg <= "0000110"; -- 3
            when "0100" => seg <= "1001100"; -- 4
            when "0101" => seg <= "0100100"; -- 5
            when "0110" => seg <= "0100000"; -- 6
            when "0111" => seg <= "0001111"; -- 7
            when "1000" => seg <= "0000000"; -- 8
            when "1001" => seg <= "0000100"; -- 9
            when "1010" => seg <= "0001000"; -- A
            when "1011" => seg <= "1100000"; -- B
            when "1100" => seg <= "0110001"; -- C
            when "1101" => seg <= "1000010"; -- D
            when "1110" => seg <= "0110000"; -- E
            when "1111" => seg <= "0111000"; -- F
            when others => seg <= "1111111";
        end case;
    end process;
end Behavioral;
