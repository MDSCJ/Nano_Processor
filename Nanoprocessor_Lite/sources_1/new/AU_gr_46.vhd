----------------------------------------------------------------------------------
-- Module Name: AU_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Buses_gr_46.all;
use work.ALU_H_gr_46.all;

entity AU_gr_46 is
    Port(
        I1 : in data_bus;
        I2 : in data_bus;
        O : out data_bus;
        Overflow : out std_logic;
        Zero : out std_logic;
        Carry : out std_logic;
        Negative : out std_logic;
        Operation : in Operation_Sel
    );
end AU_gr_46;

architecture Behavioral of AU_gr_46 is
    signal result : std_logic_vector(15 downto 0);
    signal result_8 : std_logic_vector(7 downto 0);
    signal I1_extended : std_logic_vector(15 downto 0);
    signal I2_extended : std_logic_vector(15 downto 0);
    signal add_result : std_logic_vector(15 downto 0);
    signal sub_result : std_logic_vector(15 downto 0);
    signal mul_result : std_logic_vector(15 downto 0);
    signal div_result : std_logic_vector(15 downto 0);
begin
    I1_extended <= (15 downto 8 => '0') & I1;
    I2_extended <= (15 downto 8 => '0') & I2;
    add_result <= std_logic_vector(unsigned(I1_extended) + unsigned(I2_extended));
    sub_result <= std_logic_vector(unsigned(I1_extended) - unsigned(I2_extended));
    mul_result <= std_logic_vector(unsigned(I1) * unsigned(I2));

    process(I1, I2) begin
        if unsigned(I2) = 0 then
            div_result <= x"00FF";
        else
            div_result <= (15 downto 8 => '0') & std_logic_vector(unsigned(I1) / unsigned(I2));
        end if;
    end process;

    process(Operation, add_result, sub_result, mul_result, div_result) begin
        case Operation is
            when AU_ADD_SIGNAL => result <= add_result;
            when AU_SUB_SIGNAL => result <= sub_result;
            when AU_MUL_SIGNAL => result <= mul_result;
            when AU_DIV_SIGNAL => result <= div_result;
            when others => result <= (others => '0');
        end case;
    end process;

    result_8 <= result(7 downto 0);

    process(Operation, result) begin
        case Operation is
            when AU_ADD_SIGNAL | AU_SUB_SIGNAL | AU_MUL_SIGNAL =>
                if result(15 downto 8) /= "00000000" then Overflow <= '1'; else Overflow <= '0'; end if;
            when others => Overflow <= '0';
        end case;
    end process;

    process(result_8) begin
        if result_8 = "00000000" then Zero <= '1'; else Zero <= '0'; end if;
    end process;

    Negative <= result_8(7);

    process(Operation, result, I1, I2) begin
        case Operation is
            when AU_ADD_SIGNAL =>
                Carry <= '1' when result(15 downto 8) /= "00000000" else '0';
            when AU_SUB_SIGNAL =>
                Carry <= '1' when unsigned(I1) < unsigned(I2) else '0';
            when AU_MUL_SIGNAL =>
                Carry <= '1' when result(15 downto 8) /= "00000000" else '0';
            when others => Carry <= '0';
        end case;
    end process;

    O <= result_8;
end Behavioral;
