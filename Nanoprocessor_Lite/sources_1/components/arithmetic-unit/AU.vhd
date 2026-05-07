library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all;
use work.ALU_H.all;

-- 8-Bit Arithmetic Unit supporting Add, Subtract, Multiply, Divide
entity AU is
    Port(
        I1 : in data_bus;           -- 8-bit operand 1
        I2 : in data_bus;           -- 8-bit operand 2
        O : out data_bus;           -- 8-bit result (lower 8 bits)
        Overflow : out std_logic;   -- Overflow flag
        Zero : out std_logic;       -- Zero flag
        Carry : out std_logic;      -- Carry flag (for jump conditions)
        Negative : out std_logic;   -- Negative flag (MSB of result)
        Operation : in Operation_Sel -- 2-bit operation select
    );
end AU;

architecture Behavioral of AU is
    signal result : std_logic_vector(15 downto 0); -- 16-bit intermediate result
    signal result_8 : std_logic_vector(7 downto 0);
    signal I1_extended : std_logic_vector(15 downto 0);
    signal I2_extended : std_logic_vector(15 downto 0);
    signal add_result : std_logic_vector(15 downto 0);
    signal sub_result : std_logic_vector(15 downto 0);
    signal mul_result : std_logic_vector(15 downto 0);
    signal div_result : std_logic_vector(15 downto 0);
    signal carry_out : std_logic;
    
begin
    
    -- Extend inputs to 16 bits for multiplication
    I1_extended <= (15 downto 8 => '0') & I1;
    I2_extended <= (15 downto 8 => '0') & I2;
    
    -- Addition (unsigned)
    add_result <= std_logic_vector(unsigned(I1_extended) + unsigned(I2_extended));
    
    -- Subtraction (unsigned)
    sub_result <= std_logic_vector(unsigned(I1_extended) - unsigned(I2_extended));
    
    -- Multiplication (8-bit × 8-bit = 16-bit result, but we take lower 8 bits)
    mul_result <= std_logic_vector(unsigned(I1) * unsigned(I2));
    
    -- Division (I1 / I2, with protection against division by zero)
    process(I1, I2)
    begin
        if unsigned(I2) = 0 then
            -- Division by zero: result = 0xFF (all ones as error indicator)
            div_result <= x"00FF";
        else
            div_result <= (15 downto 8 => '0') & std_logic_vector(unsigned(I1) / unsigned(I2));
        end if;
    end process;
    
    -- Select operation result
    process(Operation, add_result, sub_result, mul_result, div_result)
    begin
        case Operation is
            when AU_ADD_SIGNAL =>
                result <= add_result;
            when AU_SUB_SIGNAL =>
                result <= sub_result;
            when AU_MUL_SIGNAL =>
                result <= mul_result;
            when AU_DIV_SIGNAL =>
                result <= div_result;
            when others =>
                result <= (others => '0');
        end case;
    end process;
    
    -- Extract lower 8 bits as result
    result_8 <= result(7 downto 0);
    
    -- Overflow detection: Set if result exceeds 8-bit range (result > 255 or result < 0 for signed)
    -- For unsigned: overflow = carry out for add/sub, msb set for mul/div
    process(Operation, result)
    begin
        case Operation is
            when AU_ADD_SIGNAL | AU_SUB_SIGNAL =>
                -- Overflow if bits 15 downto 8 are non-zero (exceeded 8-bit range)
                if result(15 downto 8) /= "00000000" then
                    Overflow <= '1';
                else
                    Overflow <= '0';
                end if;
            when AU_MUL_SIGNAL =>
                -- Overflow if any bit beyond bit 7 is set
                if result(15 downto 8) /= "00000000" then
                    Overflow <= '1';
                else
                    Overflow <= '0';
                end if;
            when AU_DIV_SIGNAL =>
                -- No overflow for division
                Overflow <= '0';
            when others =>
                Overflow <= '0';
        end case;
    end process;
    
    -- Zero flag: Set if result is zero
    process(result_8)
    begin
        if result_8 = "00000000" then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;
    
    -- Negative flag: Set if MSB (bit 7) of result is 1 (negative in signed representation)
    Negative <= result_8(7);
    
    -- Carry flag: Set if operation produced carry out (result > 255 for add/mul, borrow for sub)
    process(Operation, result, I1, I2)
    begin
        case Operation is
            when AU_ADD_SIGNAL =>
                -- Carry if result exceeds 8-bit (bits 15-8 non-zero for unsigned add)
                Carry <= '1' when result(15 downto 8) /= "00000000" else '0';
            when AU_SUB_SIGNAL =>
                -- Carry/Borrow if I1 < I2 (underflow)
                Carry <= '1' when unsigned(I1) < unsigned(I2) else '0';
            when AU_MUL_SIGNAL =>
                -- Carry if result exceeds 8 bits
                Carry <= '1' when result(15 downto 8) /= "00000000" else '0';
            when AU_DIV_SIGNAL =>
                -- No carry for division
                Carry <= '0';
            when others =>
                Carry <= '0';
        end case;
    end process;
    
    O <= result_8;

end Behavioral;

