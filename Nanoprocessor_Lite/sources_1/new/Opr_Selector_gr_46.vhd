----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2026 02:10:39 PM
-- Design Name: 
-- Module Name: Opr_Selector_gr_46 - Behavioral
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Operand Selector using Mux_4_to_1_8bit for register data selection
-- 
-- Dependencies: Mux_4_to_1_8bit_gr_46
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Buses_gr_46.all;

entity Opr_Selector_gr_46 is
    port (Control : in register_address;
          Data : in data_buses;
          Selected : out data_bus);
end Opr_Selector_gr_46;

architecture Behavioral of Opr_Selector_gr_46 is
    component Mux_4_to_1_8bit_gr_46 is
        port(S : in std_logic_vector(1 downto 0);
             D : in data_buses;
             Y : out data_bus);
    end component;
begin
    Mux_inst : Mux_4_to_1_8bit_gr_46
        port map(S => Control, D => Data, Y => Selected);
end Behavioral;
