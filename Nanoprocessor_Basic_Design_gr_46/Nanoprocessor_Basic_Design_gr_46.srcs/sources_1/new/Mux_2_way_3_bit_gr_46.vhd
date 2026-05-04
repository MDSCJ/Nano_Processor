----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 08:50:55
-- Design Name: 
-- Module Name: Mux_2_way_3_bit_gr_46 - Behavioral
-- Project Name: 
-- Target Devices: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux_2_way_3_bit_gr_46 is
    Port ( I0, I1 : in STD_LOGIC_VECTOR(2 downto 0);
           Sel : in STD_LOGIC;
           RegOut : out STD_LOGIC_VECTOR(2 downto 0));
end Mux_2_way_3_bit_gr_46;

architecture Behavioral of Mux_2_way_3_bit_gr_46 is

begin
    process(I0, I1, Sel)
    begin
        if Sel = '0' then
            RegOut <= I0;
        else
            RegOut <= I1;
        end if;
    end process;

end Behavioral;

