library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Buses is

    -- Basic used buses
    subtype bus_2 is std_logic_vector(1 downto 0); -- 2 bit bus
    subtype bus_3 is std_logic_vector(2 downto 0); -- 3 bit bus
    subtype bus_4 is std_logic_vector(3 downto 0); -- 4 bit bus
    subtype bus_8 is std_logic_vector(7 downto 0); -- 8 bit bus
    subtype bus_12 is std_logic_vector(11 downto 0); -- 12 bit bus
    subtype bus_16 is std_logic_vector(15 downto 0); -- 16 bit bus

    -- Array of buses
    type buses_16_8 is array (15 downto 0) of bus_8; -- 16 buses of 8 bits each
    type buses_4_8 is array (3 downto 0) of bus_8; -- 4 buses of 8 bits each
    type buses_8_4 is array (7 downto 0) of bus_4; -- 8 buses of 4 bits each 
    
    -- Extended Custom Buses for 8-bit system
    subtype data_buses is buses_4_8;  -- 4 registers × 8 bits each
    subtype instruction_address is bus_4; -- 4-bit instruction address (16 instructions)
    subtype instruction_bus is bus_8; -- 8-bit instruction format
    subtype data_bus is bus_8; -- 8-bit data bus
    subtype register_address is bus_2; -- 2-bit register address (4 registers)
    subtype ram_address is bus_4; -- 4-bit RAM address (16 memory locations)
    
end package Buses;