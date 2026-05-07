library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Constants is

    -- Clock
    constant clk_period : time := 10 ns;
    constant clk_half_period : time := clk_period / 2;    

    -- Load Select
    constant Immediate_Load : std_logic := '0';
    constant Register_Load : std_logic := '1';
    constant RAM_Load : std_logic := '0'; -- Load from RAM

    -- 8-BIT INSTRUCTION FORMAT
    -- Bits 7-6: Primary Opcode
    constant ARITHMETIC_OP : std_logic_vector(1 downto 0) := "00";  -- ALU operation
    constant LOAD_OP : std_logic_vector(1 downto 0) := "01";        -- Load from RAM
    constant STORE_OP : std_logic_vector(1 downto 0) := "10";       -- Store to RAM
    constant JUMP_OP : std_logic_vector(1 downto 0) := "11";        -- Jump operation

    -- Arithmetic Sub-operations (bits 5-4)
    constant ADD_SUBOP : std_logic_vector(1 downto 0) := "00";
    constant SUB_SUBOP : std_logic_vector(1 downto 0) := "01";
    constant MUL_SUBOP : std_logic_vector(1 downto 0) := "10";
    constant DIV_SUBOP : std_logic_vector(1 downto 0) := "11";

    -- Jump Condition Sub-operations (bits 5-4)
    constant JUMP_UNCOND : std_logic_vector(1 downto 0) := "00";    -- Unconditional Jump
    constant JUMP_ZERO : std_logic_vector(1 downto 0) := "01";      -- Jump if Zero Flag set
    constant JUMP_CARRY : std_logic_vector(1 downto 0) := "10";     -- Jump if Carry Flag set
    constant JUMP_NEGATIVE : std_logic_vector(1 downto 0) := "11";  -- Jump if Negative Flag set

end package Constants;