library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all;
use work.constants.all;
use work.ALU_H.all;

-- 8-bit Instruction Decoder
-- Instruction Format (8 bits, MSB to LSB):
-- Bits [7:6] - Primary Opcode:
--   00 = Arithmetic (ALU)
--   01 = Load (RAM to Register)
--   10 = Store (Register to RAM)
--   11 = Jump (Control Flow)
--
-- Arithmetic (00): Bits [5:4]=sub-op, Bits [3:2]=Dest/Src1, Bits [1:0]=Src2
-- Load (01): Bits [5:4]=Dest Register, Bits [3:0]=RAM Address
-- Store (10): Bits [5:4]=Source Register, Bits [3:0]=RAM Address
-- Jump (11): Bits [5:4]=Condition, Bits [3:0]=Jump Address
entity IDecoder is
    port(
        I : in instruction_bus;         -- 8-bit instruction
        RCJump : in data_bus;           -- Register value for conditional jump (ALU result)
        Zero_Flag : in std_logic;       -- Zero flag from ALU
        Carry_Flag : in std_logic;      -- Carry flag from ALU
        Negative_Flag : in std_logic;   -- Negative flag from ALU
        REn : out register_address;     -- Register Enable (which register to write)
        RSA : out register_address;     -- Register Select A (operand 1)
        RSB : out register_address;     -- Register Select B (operand 2)
        OpS : out Operation_Sel;        -- Operation Select (add/sub/mul/div)
        IM : out data_bus;              -- Immediate value
        J : out std_logic;              -- Jump flag
        JA : out instruction_address;   -- Jump Address
        L : out std_logic;              -- Load Select (0=Immediate, 1=Register)
        RAM_Addr : out ram_address;     -- RAM address for load/store
        RAM_WE : out std_logic;         -- RAM Write Enable
        RAM_OE : out std_logic          -- RAM Output Enable (Read)
    );
end IDecoder;

architecture Behavioral of IDecoder is
    signal Op_Type : std_logic_vector(1 downto 0);  -- Operation type (bits 7-6)
    signal Sub_Op : std_logic_vector(1 downto 0);   -- Sub-operation (bits 5-4)
    signal Dest_Reg : register_address;             -- Destination register (bits 3-2) or field bits
    signal Addr_Lo : std_logic_vector(1 downto 0);  -- Address/register low bits (bits 1-0)
    
begin
    -- Decode instruction bits
    Op_Type <= I(7 downto 6);
    Sub_Op <= I(5 downto 4);
    Dest_Reg <= I(3 downto 2);
    Addr_Lo <= I(1 downto 0);
    
    decode : process(Op_Type, Sub_Op, Dest_Reg, Addr_Lo, I, Zero_Flag, Carry_Flag, Negative_Flag)
    begin
        -- Default assignments
        J <= '0';
        RAM_WE <= '0';
        RAM_OE <= '0';
        RAM_Addr <= (others => '0');
        JA <= (others => '0');
        IM <= (others => '0');
        REn <= (others => '0');
        RSA <= (others => '0');
        RSB <= (others => '0');
        OpS <= AU_ADD_SIGNAL;
        L <= Immediate_Load;
        
        case Op_Type is
            
            -- ARITHMETIC OPERATIONS (00)
            -- Bits [5:4]: ALU sub-op, Bits [3:2]: Dest/Src1 Reg, Bits [1:0]: Src2 Reg
            when ARITHMETIC_OP =>
                REn <= Dest_Reg;        -- Destination register
                RSA <= Dest_Reg;        -- First operand from destination register
                RSB <= Addr_Lo;         -- Second operand from source register (bits 1-0)
                L <= Register_Load;     -- Load from ALU result
                
                case Sub_Op is
                    when ADD_SUBOP =>
                        OpS <= AU_ADD_SIGNAL;
                    when SUB_SUBOP =>
                        OpS <= AU_SUB_SIGNAL;
                    when MUL_SUBOP =>
                        OpS <= AU_MUL_SIGNAL;
                    when DIV_SUBOP =>
                        OpS <= AU_DIV_SIGNAL;
                    when others =>
                        OpS <= AU_ADD_SIGNAL;
                end case;
            
            -- LOAD OPERATIONS (01)
            -- Bits [5:4]: Destination Register, Bits [3:0]: RAM Address
            when LOAD_OP =>
                REn <= Sub_Op;          -- Destination register (from bits [5:4])
                RAM_Addr <= I(3 downto 0);  -- RAM address (bits [3:0])
                RAM_OE <= '1';          -- Enable RAM read
                RAM_WE <= '0';          -- No write
                L <= RAM_Load;          -- Load from RAM
            
            -- STORE OPERATIONS (10)
            -- Bits [5:4]: Source Register, Bits [3:0]: RAM Address
            when STORE_OP =>
                RSA <= Sub_Op;          -- Source register (from bits [5:4])
                RAM_Addr <= I(3 downto 0);  -- RAM address (bits [3:0])
                RAM_WE <= '1';          -- Enable RAM write
                RAM_OE <= '0';          -- No read
                REn <= (others => '0'); -- Don't write to registers
            
            -- JUMP OPERATIONS (11)
            -- Bits [5:4]: Jump Condition, Bits [3:0]: Jump Address
            when JUMP_OP =>
                JA <= I(3 downto 0);    -- Jump address (bits [3:0])
                
                -- Decode jump condition (bits [5:4])
                case Sub_Op is
                    when JUMP_UNCOND =>
                        -- Unconditional jump (00)
                        J <= '1';
                    when JUMP_ZERO =>
                        -- Jump if Zero Flag is set (01)
                        J <= Zero_Flag;
                    when JUMP_CARRY =>
                        -- Jump if Carry Flag is set (10)
                        J <= Carry_Flag;
                    when JUMP_NEGATIVE =>
                        -- Jump if Negative Flag is set (11)
                        J <= Negative_Flag;
                    when others =>
                        J <= '0';
                end case;
            
            when others =>
                -- Undefined opcode - no operation
                null;
                
        end case;
    end process decode;

end Behavioral;

