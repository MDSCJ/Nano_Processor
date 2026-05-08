----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2026 04:20:33 PM
-- Design Name: 
-- Module Name: PC_gr_46 - Behavioral
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
use work.Buses_gr_46.instruction_address;
use work.Cpu_Components_gr_46.Reg_gr_46;

entity PC_gr_46 is
    Port ( A : in instruction_address;
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           M : out instruction_address);
end PC_gr_46;

architecture Behavioral of PC_gr_46 is
begin
    Reg_inst : Reg_gr_46 generic map(N => 4)
        port map(D => A, Res => Res, Clk => Clk, En => '1', Q => M);
end Behavioral;
