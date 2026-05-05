library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all;
use work.constants.all;
use work.ALU_H.all;

-- 8-bit Instruction Decoder
-- Instruction Format (8 bits):
-- Bits 7-6: Operation type (00=Arithmetic, 01=Move, 11=Jump)
-- For Arithmetic: Bits 5-4 = sub-op, Bits 3-2 = RegA, Bits 1-0 = RegB
-- For Move: Bits 5-4 = mode, Bits 3-2 = destination reg, Bits 1-0 = source/address_lo
entity IDecoder is
    port(
        I : in instruction_bus;         -- 8-bit instruction
        RCJump : in data_bus;           -- Register value for conditional jump
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
    signal Dest_Reg : register_address;             -- Destination register (bits 3-2)
    signal Src_Addr : std_logic_vector(1 downto 0); -- Source/Address bits (bits 1-0)
    
begin
    -- Decode instruction bits
    Op_Type <= I(7 downto 6);
    Sub_Op <= I(5 downto 4);
    Dest_Reg <= I(3 downto 2);
    Src_Addr <= I(1 downto 0);
    
    decode : process(Op_Type, Sub_Op, Dest_Reg, Src_Addr, I, RCJump)
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
            when ARITHMETIC_OP =>
                REn <= Dest_Reg;        -- Destination register
                RSA <= Dest_Reg;        -- First operand from destination register
                RSB <= Src_Addr;        -- Second operand from source
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
            
            -- MOVE OPERATIONS (01)
            when MOVE_OP =>
                REn <= Dest_Reg;    -- Destination register
                
                case Sub_Op is
                    -- Load Immediate (00): Load 4-bit immediate into register
                    when LOAD_IMM =>
                        IM <= (7 downto 4 => '0') & Src_Addr & "00";  -- 4-bit immediate
                        L <= Immediate_Load;
                        RAM_WE <= '0';
                        RAM_OE <= '0';
                    
                    -- Load from RAM (01): Load from RAM address
                    when LOAD_RAM =>
                        L <= RAM_Load;
                        RAM_Addr <= (3 downto 2 => '0') & Src_Addr;
                        RAM_WE <= '0';
                        RAM_OE <= '1';  -- Enable RAM read
                    
                    -- Store to RAM (10): Store register to RAM
                    when STORE_RAM =>
                        RSA <= Dest_Reg;        -- Source register to store
                        RAM_Addr <= (3 downto 2 => '0') & Src_Addr;
                        RAM_WE <= '1';          -- Enable RAM write
                        RAM_OE <= '0';
                        REn <= "00";            -- Don't modify registers
                    
                    -- Load from Register (11): Copy register to register
                    when LOAD_REG =>
                        RSA <= Src_Addr;        -- Source register
                        L <= Register_Load;
                    
                    when others =>
                        null;
                end case;
            
            -- JUMP OPERATIONS (11)
            when JUMP_OP =>
                J <= '1';
                JA <= Sub_Op & Src_Addr & "00";  -- 4-bit jump address (instruction address)
                
                -- Check condition if Sub_Op is not "00"
                if Sub_Op /= "00" then
                    -- Conditional jump based on Zero flag
                    if Sub_Op = "01" and RCJump = x"00" then
                        -- Jump if Zero
                        J <= '1';
                    elsif Sub_Op = "10" and RCJump /= x"00" then
                        -- Jump if Not Zero
                        J <= '1';
                    else
                        J <= '0';
                    end if;
                end if;
            
            -- NOP or undefined (10)
            when others =>
                null;  -- No operation
                
        end case;
    end process decode;

end Behavioral;

