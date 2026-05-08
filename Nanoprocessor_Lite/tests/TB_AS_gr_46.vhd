----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2026 03:30:10 PM
-- Design Name: 
-- Module Name: TB_Add_Sub_4_bit_gr_46 - Behavioral
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Testbench for 4-bit Adder-Subtractor
-- 
-- Dependencies: Add_Sub_4_bit_gr_46
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Add_Sub_4_bit_gr_46 is
end TB_Add_Sub_4_bit_gr_46;

architecture Behavioral of TB_Add_Sub_4_bit_gr_46 is
    COMPONENT Add_Sub_4_bit_gr_46
        Port(A_AS : in STD_LOGIC_VECTOR (3 DOWNTO 0);
             B_AS : in STD_LOGIC_VECTOR (3 DOWNTO 0);
             CTRL : in STD_LOGIC;
             S_AS : out STD_LOGIC_VECTOR(3 DOWNTO 0);
             Zero : out STD_LOGIC;
             OverFlow : out STD_LOGIC);
    END COMPONENT;

    signal A, B, S : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    signal CTRL, Zero : STD_LOGIC := '0';
    signal OverFlow : STD_LOGIC := '0';

begin
    uut : Add_Sub_4_bit_gr_46 port map(
        A_AS => A, B_AS => B, CTRL => CTRL,
        S_AS => S, Zero => Zero, OverFlow => OverFlow);

    process begin
        -- Index numbers: 240278, 240238, 240255
        -- Test ADD: 8 + 8 (last digits of 240278)
        CTRL <= '0';
        A <= "1000"; B <= "1000"; wait for 50 ns;

        -- Test ADD: 3 + 5 (digits from 240238 and 240255)
        A <= "0011"; B <= "0101"; wait for 50 ns;

        -- Test SUB: 7 - 2 (digits from 240278 and 240278)
        CTRL <= '1';
        A <= "0111"; B <= "0010"; wait for 50 ns;

        -- Test SUB: 5 - 5 (zero flag test, digit 5 from 240255)
        A <= "0101"; B <= "0101"; wait for 50 ns;

        -- Test ADD: 2 + 4 (first non-zero digits 240278)
        CTRL <= '0';
        A <= "0010"; B <= "0100"; wait for 50 ns;

        -- Test SUB: 8 - 3 (digits from 240278 and 240238)
        CTRL <= '1';
        A <= "1000"; B <= "0011"; wait for 50 ns;

        wait;
    end process;
end Behavioral;
