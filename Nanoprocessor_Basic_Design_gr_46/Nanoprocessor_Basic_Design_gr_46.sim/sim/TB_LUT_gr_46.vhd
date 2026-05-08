----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 22:35:56
-- Design Name: 
-- Module Name: TB_LUT_gr_46 - Behavioral
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

entity TB_LUT_gr_46 is
--  Port ( );
end TB_LUT_gr_46;

architecture Behavioral of TB_LUT_gr_46 is
    component LUT_gr_46
        Port (
            address : in STD_LOGIC_VECTOR (3 downto 0);
            data : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;
    
    signal address_tb : STD_LOGIC_VECTOR (3 downto 0);
    signal data_tb : STD_LOGIC_VECTOR (6 downto 0);
begin
    uut: LUT_gr_46
        Port map (
            address => address_tb,
            data => data_tb
        );

process
    begin
        address_tb <= "0000"; wait for 10 ns; 
        address_tb <= "0001"; wait for 10 ns; 
        address_tb <= "0010"; wait for 10 ns; 
        address_tb <= "0011"; wait for 10 ns; 
        address_tb <= "0100"; wait for 10 ns; 
        address_tb <= "0101"; wait for 10 ns; 
        address_tb <= "0110"; wait for 10 ns; 
        address_tb <= "0111"; wait for 10 ns; 
        address_tb <= "1000"; wait for 10 ns; 
        address_tb <= "1001"; wait for 10 ns; 
        address_tb <= "1010"; wait for 10 ns; 
        address_tb <= "1011"; wait for 10 ns; 
        address_tb <= "1100"; wait for 10 ns; 
        address_tb <= "1101"; wait for 10 ns;
        address_tb <= "1110"; wait for 10 ns;
        address_tb <= "1111"; wait for 10 ns; 

        wait;
    end process;
end Behavioral;
