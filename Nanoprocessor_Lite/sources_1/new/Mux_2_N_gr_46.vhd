----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2026 09:45:20 AM
-- Design Name: 
-- Module Name: Mux_2_N_gr_46 - Behavioral
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

entity Mux_2_N_gr_46 is
    generic( N : integer );
    port(
        S: in std_logic;
        A: in std_logic_vector(N - 1 downto 0);
        B: in std_logic_vector(N - 1 downto 0);
        O : out std_logic_vector(N-1 downto 0)
    );
end Mux_2_N_gr_46;

architecture Behavioral of Mux_2_N_gr_46 is
begin
    process(S, A, B) begin
        if S = '0' then O <= A; else O <= B; end if;
    end process;
end Behavioral;
