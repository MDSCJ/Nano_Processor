library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all;

-- 8-bit Program ROM with 4-bit addressing
-- 16 instruction locations × 8-bit instructions
entity Program_ROM is
    port(
        ROM_address : in instruction_address;  -- 4-bit address (16 locations)
        I : out instruction_bus                -- 8-bit instruction
    );
end Program_ROM;

architecture Behavioral of Program_ROM is

type rom_type is array (0 to 15) of std_logic_vector(7 downto 0);

-- 8-bit Instruction Format:
-- Bits 7-6: Operation (00=Arithmetic, 01=Move, 11=Jump)
-- For Arithmetic (bits 7-6 = 00):
--   Bits 5-4: Sub-operation (00=Add, 01=Sub, 10=Mul, 11=Div)
--   Bits 3-2: Register A
--   Bits 1-0: Register B
-- For Move (bits 7-6 = 01):
--   Bits 5-4: Mode (00=LoadImm, 01=LoadRAM, 10=StoreRAM, 11=LoadReg)
--   Bits 3-0: Register/Address/Value

signal program : rom_type := (
    -- Example program: Load immediate values and perform arithmetic
    "01000001",  -- 0: MOVI R1, immediate (01=Move, 00=LoadImm, 00=R1, 01=val_lo)
    "01000011",  -- 1: MOVI R2, immediate (01=Move, 00=LoadImm, 01=R2, 11=val_lo)
    "00000101",  -- 2: ADD R1, R2 (00=Arith, 00=Add, 01=R1, 01=R2)
    "00010110",  -- 3: SUB R1, R2 (00=Arith, 01=Sub, 01=R1, 10=R2)
    "00100111",  -- 4: MUL R1, R3 (00=Arith, 10=Mul, 01=R1, 11=R3)
    "00111000",  -- 5: DIV R2, R3 (00=Arith, 11=Div, 10=R2, 00=R0)
    "11000000",  -- 6: JUMP if zero (11=Jump, 00=Cond, 0000=addr)
    x"00",       -- 7: (unused)
    x"00",       -- 8: (unused)
    x"00",       -- 9: (unused)
    x"00",       -- 10: (unused)
    x"00",       -- 11: (unused)
    x"00",       -- 12: (unused)
    x"00",       -- 13: (unused)
    x"00",       -- 14: (unused)
    x"00"        -- 15: (unused)
);

begin
    I <= program(to_integer(unsigned(ROM_address)));
end Behavioral;

