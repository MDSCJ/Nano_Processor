----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2026 05:30:00 PM
-- Design Name: 
-- Module Name: ALU_H_gr_46 - Package
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: ALU operation type definitions
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
use IEEE.NUMERIC_STD.ALL;

package ALU_H_gr_46 is

    constant N_Arithemetic_Ops : integer := 4;
    constant N_Logical_Ops : integer := 0;
    constant N_Total_Ops : integer := N_Arithemetic_Ops + N_Logical_Ops;

    subtype Operation_Sel is std_logic_vector(1 downto 0);
    constant AU_ADD_SIGNAL : Operation_Sel := "00";
    constant AU_SUB_SIGNAL : Operation_Sel := "01";
    constant AU_MUL_SIGNAL : Operation_Sel := "10";
    constant AU_DIV_SIGNAL : Operation_Sel := "11";

    constant AU_ADD : integer := 0;
    constant AU_SUB : integer := 1;
    constant AU_MUL : integer := 2;
    constant AU_DIV : integer := 3;

end package ALU_H_gr_46;
