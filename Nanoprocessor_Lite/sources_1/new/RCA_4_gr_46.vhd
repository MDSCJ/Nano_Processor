----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 02:40:51 PM
-- Design Name: 
-- Module Name: RCA_4_gr_46 - Behavioral
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: 4-bit Ripple Carry Adder using Full Adders
-- 
-- Dependencies: FA_gr_46
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Adders_gr_46.FA_gr_46;

entity RCA_4_gr_46 is
    Port(A : in STD_LOGIC_VECTOR (3 downto 0);
         B : in STD_LOGIC_VECTOR (3 downto 0);
         C_in : in STD_LOGIC;
         S : out STD_LOGIC_VECTOR(3 DOWNTO 0);
         C_out : out STD_LOGIC);
end RCA_4_gr_46;

architecture Behavioral of RCA_4_gr_46 is
    signal Carry : STD_LOGIC_VECTOR(4 downto 0);
begin
    Carry(0) <= C_in;
    FAs : for i in 0 to 3 generate
        FA_inst : FA_gr_46
            port map (A => A(i), B => B(i), C_in => Carry(i), S => S(i), C_out => Carry(i+1));
    end generate FAs;
    C_out <= Carry(4);
end Behavioral;
