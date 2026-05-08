----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 01:45:38 PM
-- Design Name: 
-- Module Name: AU_gr_46 - Behavioral
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: 8-Bit Arithmetic Unit with structural ADD/SUB (RCA_4 chain)
--              and behavioral MUL/DIV
-- 
-- Dependencies: RCA_4_gr_46
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
use work.ALU_H_gr_46.all;
use work.Adders_gr_46.RCA_4_gr_46;

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
    -- Structural adder/subtractor signals
    signal B_modified : data_bus;            -- I2 XOR ctrl (for subtract)
    signal sub_ctrl : std_logic;             -- '0'=add, '1'=subtract
    signal carry_mid : std_logic;            -- carry between low and high nibble
    signal carry_out : std_logic;            -- final carry out
    signal addsub_result : data_bus;         -- structural add/sub result

    -- Behavioral mul/div signals
    signal mul_result : std_logic_vector(15 downto 0);
    signal div_result : std_logic_vector(7 downto 0);

    -- Final result
    signal result_8 : data_bus;
    signal overflow_internal : std_logic;
begin

    -- ===== STRUCTURAL 8-BIT ADDER/SUBTRACTOR =====
    -- Uses two chained RCA_4 (HA -> FA -> RCA_4 -> RCA_4)
    -- For SUB: B_modified = I2 XOR "11111111", carry_in = '1' (2's complement)
    -- For ADD: B_modified = I2, carry_in = '0'

    sub_ctrl <= '1' when Operation = AU_SUB_SIGNAL else '0';

    B_modify: for i in 0 to 7 generate
        B_modified(i) <= I2(i) XOR sub_ctrl;
    end generate B_modify;

    -- Low nibble adder (bits 3:0)
    RCA_4_Low : RCA_4_gr_46
        port map(
            A => I1(3 downto 0),
            B => B_modified(3 downto 0),
            C_in => sub_ctrl,
            S => addsub_result(3 downto 0),
            C_out => carry_mid
        );

    -- High nibble adder (bits 7:4) - chained carry from low nibble
    RCA_4_High : RCA_4_gr_46
        port map(
            A => I1(7 downto 4),
            B => B_modified(7 downto 4),
            C_in => carry_mid,
            S => addsub_result(7 downto 4),
            C_out => carry_out
        );

    -- ===== BEHAVIORAL MUL/DIV (structural multiplier is impractical) =====
    mul_result <= std_logic_vector(unsigned(I1) * unsigned(I2));

    process(I1, I2) begin
        if unsigned(I2) = 0 then
            div_result <= (others => '1');  -- Division by zero: 0xFF
        else
            div_result <= std_logic_vector(unsigned(I1) / unsigned(I2));
        end if;
    end process;

    -- ===== RESULT SELECTION =====
    process(Operation, addsub_result, mul_result, div_result) begin
        case Operation is
            when AU_ADD_SIGNAL | AU_SUB_SIGNAL =>
                result_8 <= addsub_result;
            when AU_MUL_SIGNAL =>
                result_8 <= mul_result(7 downto 0);
            when AU_DIV_SIGNAL =>
                result_8 <= div_result;
            when others =>
                result_8 <= (others => '0');
        end case;
    end process;

    -- ===== FLAGS =====
    -- Overflow
    process(Operation, carry_out, mul_result) begin
        case Operation is
            when AU_ADD_SIGNAL | AU_SUB_SIGNAL =>
                overflow_internal <= carry_out;
            when AU_MUL_SIGNAL =>
                if mul_result(15 downto 8) /= "00000000" then
                    overflow_internal <= '1';
                else
                    overflow_internal <= '0';
                end if;
            when others =>
                overflow_internal <= '0';
        end case;
    end process;

    -- Zero flag
    process(result_8) begin
        if result_8 = "00000000" then Zero <= '1'; else Zero <= '0'; end if;
    end process;

    -- Negative flag (MSB)
    Negative <= result_8(7);

    -- Carry flag
    process(Operation, carry_out, I1, I2, mul_result) begin
        case Operation is
            when AU_ADD_SIGNAL =>
                Carry <= carry_out;
            when AU_SUB_SIGNAL =>
                if unsigned(I1) < unsigned(I2) then
                    Carry <= '1';
                else
                    Carry <= '0';
                end if;            when AU_MUL_SIGNAL =>
                if mul_result(15 downto 8) /= "00000000" then
                    Carry <= '1';
                else
                    Carry <= '0';
                end if;            when others =>
                Carry <= '0';
        end case;
    end process;

    O <= result_8;
    Overflow <= overflow_internal;

end Behavioral;
