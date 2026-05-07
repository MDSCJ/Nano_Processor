# Nanoprocessor_Lite Instruction Set Update

## Overview
Updated the Nanoprocessor_Lite design to fully implement the complete 8-bit instruction set specification with proper support for Arithmetic, Load, Store, and Jump operations with conditional jump support.

## Changes Made

### 1. **constants.vhd** - Updated Primary Opcodes
**Previous State:**
```vhdl
constant ARITHMETIC_OP : std_logic_vector(1 downto 0) := "00";
constant MOVE_OP : std_logic_vector(1 downto 0) := "01";
constant JUMP_OP : std_logic_vector(1 downto 0) := "11";
constant NOP_OP : std_logic_vector(1 downto 0) := "10";
```

**Updated State:**
```vhdl
constant ARITHMETIC_OP : std_logic_vector(1 downto 0) := "00";  -- ALU operation
constant LOAD_OP : std_logic_vector(1 downto 0) := "01";        -- Load from RAM
constant STORE_OP : std_logic_vector(1 downto 0) := "10";       -- Store to RAM
constant JUMP_OP : std_logic_vector(1 downto 0) := "11";        -- Jump operation
```

**New Jump Condition Constants:**
```vhdl
constant JUMP_UNCOND : std_logic_vector(1 downto 0) := "00";    -- Unconditional Jump
constant JUMP_ZERO : std_logic_vector(1 downto 0) := "01";      -- Jump if Zero Flag set
constant JUMP_CARRY : std_logic_vector(1 downto 0) := "10";     -- Jump if Carry Flag set
constant JUMP_NEGATIVE : std_logic_vector(1 downto 0) := "11";  -- Jump if Negative Flag set
```

### 2. **ALU_H.vhd** - ALU Header Package
No changes needed - already supports 4 operations (Add, Sub, Mul, Div).

### 3. **AU.vhd** - Arithmetic Unit
**Added Ports:**
- `Carry : out std_logic;` - Carry flag output for jump conditions
- `Negative : out std_logic;` - Negative flag (MSB of result)

**New Logic:**
- **Carry Flag:** Set when operation produces carry out
  - ADD: Set if result > 255
  - SUB: Set if I1 < I2 (underflow)
  - MUL: Set if result > 255
  - DIV: Always 0
  
- **Negative Flag:** Set if MSB (bit 7) of result is 1 (signed representation)

### 4. **IDecoder.vhd** - Instruction Decoder (Major Rewrite)

**Added Ports:**
```vhdl
Zero_Flag : in std_logic;       -- Zero flag from ALU
Carry_Flag : in std_logic;      -- Carry flag from ALU
Negative_Flag : in std_logic;   -- Negative flag from ALU
```

**Complete Instruction Format Implementation:**

#### Arithmetic (00):
- Bits [7:6]: 00
- Bits [5:4]: ALU Sub-operation (00=Add, 01=Sub, 10=Mul, 11=Div)
- Bits [3:2]: Destination & Source 1 Register (00=R0, 01=R1, 10=R2, 11=R3)
- Bits [1:0]: Source 2 Register (00=R0, 01=R1, 10=R2, 11=R3)
- **Example:** `00 00 01 10` = R1 = R1 + R2

#### Load (01):
- Bits [7:6]: 01
- Bits [5:4]: Destination Register (00=R0, 01=R1, 10=R2, 11=R3)
- Bits [3:0]: RAM Address (0-15)
- **Example:** `01 10 1111` = Load from RAM[15] into R2

#### Store (10):
- Bits [7:6]: 10
- Bits [5:4]: Source Register (00=R0, 01=R1, 10=R2, 11=R3)
- Bits [3:0]: RAM Address (0-15)
- **Example:** `10 00 0100` = Store R0 to RAM[4]

#### Jump (11):
- Bits [7:6]: 11
- Bits [5:4]: Jump Condition
  - 00 = Unconditional Jump
  - 01 = Jump if Zero Flag is set
  - 10 = Jump if Carry Flag is set
  - 11 = Jump if Negative Flag is set
- Bits [3:0]: Jump Address (0-15)
- **Example:** `11 00 1000` = Unconditional jump to address 8

### 5. **Nanoprocessor.vhd** - Top-Level Processor

**Added Signals:**
```vhdl
signal ALU_Zero : std_logic;       -- Zero flag from ALU
signal ALU_Overflow : std_logic;   -- Overflow flag from ALU
signal ALU_Carry : std_logic;      -- Carry flag from ALU
signal ALU_Negative : std_logic;   -- Negative flag from ALU
```

**Updated Connections:**
- Connected ALU Carry and Negative flags to Instruction Decoder
- Instruction Decoder now receives all three flags for proper conditional jump evaluation
- Output mapping: `Zero <= ALU_Zero;`

### 6. **Program_ROM.vhd** - Updated Example Program

**Old Format:** Mixed immediate load and register-based operations

**New Format:** Complete demonstration of all 4 instruction types
```vhdl
-- Arithmetic operations (4 examples)
"00000101",  -- ADD R1, R2
"00010110",  -- SUB R1, R2
"00100111",  -- MUL R1, R3
"00111000",  -- DIV R2, R0

-- Load from RAM (3 examples)
"01001111",  -- LOAD R2, RAM[15]
"01010101",  -- LOAD R1, RAM[5]
"01000011",  -- LOAD R0, RAM[3]

-- Store to RAM (3 examples)
"10000100",  -- STORE R0, RAM[4]
"10010010",  -- STORE R1, RAM[2]
"10101010",  -- STORE R2, RAM[10]

-- Jump operations (4 examples)
"11000001",  -- JUMP (unconditional) to addr 1
"11010100",  -- JUMP if Zero to addr 4
"11101000",  -- JUMP if Carry to addr 8
"11110000"   -- JUMP if Negative to addr 0
```

## Instruction Set Summary

| Opcode | Name | Format | Description |
|--------|------|--------|-------------|
| 00 | Arithmetic | `00 SS DD RR` | ALU op (SS) on Dest/Src1 (DD) and Src2 (RR) |
| 01 | Load | `01 DD AAAA` | Load from RAM[A] into register D |
| 10 | Store | `10 SS AAAA` | Store register S to RAM[A] |
| 11 | Jump | `11 CC AAAA` | Jump to address A if condition C is met |

Where:
- `SS` = ALU Sub-operation: 00=Add, 01=Sub, 10=Mul, 11=Div
- `DD` = Register: 00=R0, 01=R1, 10=R2, 11=R3
- `RR` = Register: 00=R0, 01=R1, 10=R2, 11=R3
- `AAAA` = 4-bit Address (0-15)
- `CC` = Jump Condition: 00=Uncond, 01=if Zero, 10=if Carry, 11=if Negative

## Compatibility Notes

✅ **Fully Compatible:**
- All 16 instruction ROM locations
- All 4 registers (R0, R1, R2, R3)
- All 16 RAM locations
- Existing Register Bank, ALU structure

⚠️ **Changes Required:**
- Any existing test benches need to be updated to match new opcode format
- Assembly code must be updated to use new Load/Store/Jump opcodes
- Instruction ROM programs must be recompiled with new instruction encoding

## Testing Checklist

- [ ] Verify Arithmetic operations execute correctly
- [ ] Verify Load operations read from RAM correctly
- [ ] Verify Store operations write to RAM correctly
- [ ] Verify Unconditional Jump works
- [ ] Verify Jump if Zero flag is set
- [ ] Verify Jump if Carry flag is set
- [ ] Verify Jump if Negative flag is set
- [ ] Verify ALU flags propagate correctly
- [ ] Verify all register combinations work
- [ ] Verify all RAM addresses are accessible
