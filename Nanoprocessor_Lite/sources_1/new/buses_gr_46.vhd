----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2026 02:15:30 PM
-- Design Name: 
-- Module Name: buses_gr_46 - Behavioral
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

package Buses_gr_46 is

    -- Basic used buses
    subtype bus_2 is std_logic_vector(1 downto 0);
    subtype bus_3 is std_logic_vector(2 downto 0);
    subtype bus_4 is std_logic_vector(3 downto 0);
    subtype bus_8 is std_logic_vector(7 downto 0);
    subtype bus_12 is std_logic_vector(11 downto 0);
    subtype bus_16 is std_logic_vector(15 downto 0);

    -- Array of buses
    type buses_16_8 is array (15 downto 0) of bus_8;
    type buses_4_8 is array (3 downto 0) of bus_8;
    type buses_8_4 is array (7 downto 0) of bus_4;

    -- Extended Custom Buses for 8-bit system
    subtype data_buses is buses_4_8;
    subtype instruction_address is bus_4;
    subtype instruction_bus is bus_8;
    subtype data_bus is bus_8;
    subtype register_address is bus_2;
    subtype ram_address is bus_4;

end package Buses_gr_46;
