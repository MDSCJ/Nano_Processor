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
    -- Bits 7-6: Operation Type
    constant ARITHMETIC_OP : std_logic_vector(1 downto 0) := "00";
    constant MOVE_OP : std_logic_vector(1 downto 0) := "01";
    constant JUMP_OP : std_logic_vector(1 downto 0) := "11";
    constant NOP_OP : std_logic_vector(1 downto 0) := "10";

    -- Arithmetic Sub-operations (bits 5-4)
    constant ADD_SUBOP : std_logic_vector(1 downto 0) := "00";
    constant SUB_SUBOP : std_logic_vector(1 downto 0) := "01";
    constant MUL_SUBOP : std_logic_vector(1 downto 0) := "10";
    constant DIV_SUBOP : std_logic_vector(1 downto 0) := "11";

    -- Move Sub-operations (bits 5-4)
    constant LOAD_IMM : std_logic_vector(1 downto 0) := "00";  -- Load immediate
    constant LOAD_RAM : std_logic_vector(1 downto 0) := "01";  -- Load from RAM
    constant STORE_RAM : std_logic_vector(1 downto 0) := "10"; -- Store to RAM
    constant LOAD_REG : std_logic_vector(1 downto 0) := "11";  -- Load from register

end package Constants;