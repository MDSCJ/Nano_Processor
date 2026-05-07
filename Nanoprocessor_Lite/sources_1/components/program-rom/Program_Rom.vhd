library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all;

-- 8-bit Program ROM with 4-bit addressing
-- 16 instruction locations × 8-bit instructions
-- 
-- INSTRUCTION FORMAT (8 bits, MSB to LSB [7:0]):
-- Bits [7:6] - Primary Opcode:
--   00 = Arithmetic (ALU)
--   01 = Load (RAM to Register)
--   10 = Store (Register to RAM)
--   11 = Jump (Control Flow)
--
-- ARITHMETIC (00): Bits [5:4]=ALU sub-op, Bits [3:2]=Dest&Src1 Reg, Bits [1:0]=Src2 Reg
--   Sub-ops: 00=Add, 01=Sub, 10=Mul, 11=Div
--   Example: 00 00 01 10 = ADD R1, R2 (R1 = R1 + R2)
--
-- LOAD (01): Bits [5:4]=Dest Reg, Bits [3:0]=RAM Address
--   Example: 01 10 1111 = Load from RAM[15] into R2
--
-- STORE (10): Bits [5:4]=Src Reg, Bits [3:0]=RAM Address
--   Example: 10 00 0100 = Store R0 to RAM[4]
--
-- JUMP (11): Bits [5:4]=Condition, Bits [3:0]=Jump Address
--   Conditions: 00=Unconditional, 01=if Zero, 10=if Carry, 11=if Negative
--   Example: 11 00 1000 = Unconditional jump to address 8
entity Program_ROM is
    port(
        ROM_address : in instruction_address;  -- 4-bit address (16 locations)
        I : out instruction_bus                -- 8-bit instruction
    );
end Program_ROM;

architecture Behavioral of Program_ROM is

type rom_type is array (0 to 15) of std_logic_vector(7 downto 0);

signal program : rom_type := (
    -- Example program demonstrating all instruction types
    
    -- Arithmetic operations
    "00000101",  -- 0: ADD R1, R2     (00=Arith, 00=Add, 01=R1, 01=R2)
    "00010110",  -- 1: SUB R1, R2     (00=Arith, 01=Sub, 01=R1, 10=R2)
    "00100111",  -- 2: MUL R1, R3     (00=Arith, 10=Mul, 01=R1, 11=R3)
    "00111000",  -- 3: DIV R2, R0     (00=Arith, 11=Div, 10=R2, 00=R0)
    
    -- Load from RAM (01=Load opcode)
    "01001111",  -- 4: LOAD R2, RAM[15]  (01=Load, 10=R2, 1111=address 15)
    "01010101",  -- 5: LOAD R1, RAM[5]   (01=Load, 01=R1, 0101=address 5)
    "01000011",  -- 6: LOAD R0, RAM[3]   (01=Load, 00=R0, 0011=address 3)
    
    -- Store to RAM (10=Store opcode)
    "10000100",  -- 7: STORE R0, RAM[4]  (10=Store, 00=R0, 0100=address 4)
    "10010010",  -- 8: STORE R1, RAM[2]  (10=Store, 01=R1, 0010=address 2)
    "10101010",  -- 9: STORE R2, RAM[10] (10=Store, 10=R2, 1010=address 10)
    
    -- Jump operations (11=Jump opcode)
    "11000001",  -- 10: JUMP (uncond) addr 1   (11=Jump, 00=Uncond, 0001=addr 1)
    "11010100",  -- 11: JUMP if Zero addr 4    (11=Jump, 01=if Zero, 0100=addr 4)
    "11101000",  -- 12: JUMP if Carry addr 8   (11=Jump, 10=if Carry, 1000=addr 8)
    "11110000",  -- 13: JUMP if Negative addr 0 (11=Jump, 11=if Neg, 0000=addr 0)
    
    "00000000",  -- 14: (unused/padding)
    "00000000"   -- 15: (unused/padding)
);

begin
    I <= program(to_integer(unsigned(ROM_address)));
end Behavioral;

