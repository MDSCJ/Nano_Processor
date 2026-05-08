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
        -- Accumulate 1+2+3=6 step-by-step in R3 (shown on 7-seg display)
        -- R3 starts at 0 after reset. RAM[n]=n pre-initialised.
        "01010001",  -- 0: LOAD R1, RAM[1]  -> R1 = 1
        "00001101",  -- 1: ADD  R3, R1      -> R3 = 0+1 = 1  (display: 1)
        "01010010",  -- 2: LOAD R1, RAM[2]  -> R1 = 2
        "00001101",  -- 3: ADD  R3, R1      -> R3 = 1+2 = 3  (display: 3)
        "01010011",  -- 4: LOAD R1, RAM[3]  -> R1 = 3
        "00001101",  -- 5: ADD  R3, R1      -> R3 = 3+3 = 6  (display: 6)
        "11000110",  -- 6: JMP  6           -> halt (loop forever)
        "00000000",  -- 7: NOP
        "00000000",  -- 8: NOP
        "00000000",  -- 9: NOP
        "00000000",  -- 10: NOP
        "00000000",  -- 11: NOP
        "00000000",  -- 12: NOP
        "00000000",  -- 13: NOP
        "00000000",  -- 14: NOP
        "00000000"   -- 15: NOP
    );
begin
    I <= program(to_integer(unsigned(ROM_address)));
end Behavioral;
