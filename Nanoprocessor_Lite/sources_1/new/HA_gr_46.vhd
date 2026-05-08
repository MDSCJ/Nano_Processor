----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 09:30:15 AM
-- Design Name: 
-- Module Name: HA_gr_46 - Behavioral
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Half Adder
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

entity HA_gr_46 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           S : out STD_LOGIC;
           C : out STD_LOGIC);
end HA_gr_46;

architecture Behavioral of HA_gr_46 is
begin
    S <= A XOR B;
    C <= A AND B;
end Behavioral;
