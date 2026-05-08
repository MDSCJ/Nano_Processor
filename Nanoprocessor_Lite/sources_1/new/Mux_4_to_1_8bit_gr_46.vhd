----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2026 02:50:16 PM
-- Design Name: 
-- Module Name: Mux_4_to_1_8bit_gr_46 - Behavioral
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: 4-to-1 8-bit Multiplexer for register data selection
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
use work.Buses_gr_46.all;

entity Mux_4_to_1_8bit_gr_46 is
    port(
        S : in std_logic_vector(1 downto 0);
        D : in data_buses;
        Y : out data_bus
    );
end Mux_4_to_1_8bit_gr_46;

architecture Behavioral of Mux_4_to_1_8bit_gr_46 is
begin
    process(S, D) begin
        case S is
            when "00" => Y <= D(0);
            when "01" => Y <= D(1);
            when "10" => Y <= D(2);
            when "11" => Y <= D(3);
            when others => Y <= (others => '0');
        end case;
    end process;
end Behavioral;
