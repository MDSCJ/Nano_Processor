----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 03:55:28 PM
-- Design Name: 
-- Module Name: Add_Sub_4_bit_gr_46 - Behavioral
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: 4-bit Adder-Subtractor using RCA_4
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
use work.Adders_gr_46.RCA_4_gr_46;

entity Add_Sub_4_bit_gr_46 is
    Port(A_AS : in STD_LOGIC_VECTOR (3 DOWNTO 0);
         B_AS : in STD_LOGIC_VECTOR (3 DOWNTO 0);
         CTRL : in STD_LOGIC;
         S_AS : out STD_LOGIC_VECTOR(3 DOWNTO 0);
         Zero : out STD_LOGIC;
         OverFlow : out STD_LOGIC);
end Add_Sub_4_bit_gr_46;

architecture Behavioral of Add_Sub_4_bit_gr_46 is
    SIGNAL B_inter, S_inter: STD_LOGIC_VECTOR(3 DOWNTO 0);
begin
    RCA_4_0 : RCA_4_gr_46
        port map(A => A_AS, B => B_inter, C_in => CTRL, S => S_inter, C_out => OverFlow);
    B_inter(0) <= B_AS(0) XOR CTRL;
    B_inter(1) <= B_AS(1) XOR CTRL;
    B_inter(2) <= B_AS(2) XOR CTRL;
    B_inter(3) <= B_AS(3) XOR CTRL;
    process (S_inter) begin
        if S_inter = "0000" then Zero <= '1'; else Zero <= '0'; end if;
    end process;
    S_AS <= S_inter;
end Behavioral;
