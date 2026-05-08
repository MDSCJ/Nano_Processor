----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2026 03:25:57 PM
-- Design Name: 
-- Module Name: Slow_Clk_gr_46 - Behavioral
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

entity Slow_Clk_gr_46 is
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end Slow_Clk_gr_46;

architecture Behavioral of Slow_Clk_gr_46 is
    signal count : integer := 1;
    signal clk_status : std_logic := '0';
begin
    process (Clk_in) begin
        if rising_edge(Clk_in) then
            count <= count + 1;
            if(count = 50000000) then
                clk_status <= not clk_status;
                count <= 1;
            end if;
        end if;
    end process;

    Clk_out <= clk_status;

end Behavioral;
