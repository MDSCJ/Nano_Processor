----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2026 02:45:10 PM
-- Design Name: 
-- Module Name: constants_gr_46 - Behavioral
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Constants_gr_46 is

    constant clk_period : time := 10 ns;
    constant clk_half_period : time := clk_period / 2;

    constant Immediate_Load : std_logic := '0';
    constant Register_Load : std_logic := '0';  -- '0' selects A=AU result in Load_Selector MUX
    constant RAM_Load      : std_logic := '1';  -- '1' selects B=RAM data in Load_Selector MUX

    constant ARITHMETIC_OP : std_logic_vector(1 downto 0) := "00";
    constant LOAD_OP : std_logic_vector(1 downto 0) := "01";
    constant STORE_OP : std_logic_vector(1 downto 0) := "10";
    constant JUMP_OP : std_logic_vector(1 downto 0) := "11";

    constant ADD_SUBOP : std_logic_vector(1 downto 0) := "00";
    constant SUB_SUBOP : std_logic_vector(1 downto 0) := "01";
    constant MUL_SUBOP : std_logic_vector(1 downto 0) := "10";
    constant DIV_SUBOP : std_logic_vector(1 downto 0) := "11";

    constant JUMP_UNCOND : std_logic_vector(1 downto 0) := "00";
    constant JUMP_ZERO : std_logic_vector(1 downto 0) := "01";
    constant JUMP_CARRY : std_logic_vector(1 downto 0) := "10";
    constant JUMP_NEGATIVE : std_logic_vector(1 downto 0) := "11";

end package Constants_gr_46;
