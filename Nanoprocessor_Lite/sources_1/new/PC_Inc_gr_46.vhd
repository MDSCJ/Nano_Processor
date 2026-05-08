----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2026 09:15:48 AM
-- Design Name: 
-- Module Name: PC_Inc_gr_46 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use work.Buses_gr_46.instruction_address;

entity PC_Inc_gr_46 is
    port(
        A_in: in instruction_address;
        A_out: out instruction_address
    );
end PC_Inc_gr_46;

architecture Behavioral of PC_Inc_gr_46 is
begin
    A_out <= std_logic_vector(unsigned(A_in) + 1);
end Behavioral;
