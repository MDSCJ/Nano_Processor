----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 03:20:14 PM
-- Design Name: 
-- Module Name: Program_ROM_gr_46 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use work.Buses_gr_46.all;

entity Program_ROM_gr_46 is
    port(
        ROM_address : in instruction_address;
        I : out instruction_bus
    );
end Program_ROM_gr_46;

architecture Behavioral of Program_ROM_gr_46 is
    type rom_type is array (0 to 15) of std_logic_vector(7 downto 0);
    signal program : rom_type := (
        "00000101",  -- 0: ADD R1, R1
        "00010110",  -- 1: SUB R1, R2
        "00100111",  -- 2: MUL R1, R3
        "00111000",  -- 3: DIV R2, R0
        "01001111",  -- 4: LOAD R1, RAM[15]
        "01010101",  -- 5: LOAD R1, RAM[5]
        "01000011",  -- 6: LOAD R0, RAM[3]
        "10000100",  -- 7: STORE R0, RAM[4]
        "10010010",  -- 8: STORE R0, RAM[2]
        "10101010",  -- 9: STORE R2, RAM[10]
        "11000001",  -- 10: JMP 1
        "11010100",  -- 11: JZ 4
        "11101000",  -- 12: JC 8
        "11110000",  -- 13: JN 0
        "00000000",  -- 14: NOP
        "00000000"   -- 15: NOP
    );
begin
    I <= program(to_integer(unsigned(ROM_address)));
end Behavioral;
