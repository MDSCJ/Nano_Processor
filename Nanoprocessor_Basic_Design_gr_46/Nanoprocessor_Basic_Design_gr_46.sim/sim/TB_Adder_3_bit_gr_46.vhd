----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2026 08:35:28
-- Design Name: 
-- Module Name: TB_Adder_3_bit_gr_46 - Behavioral
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

entity TB_Adder_3_bit_gr_46 is
--  Port ( );
end TB_Adder_3_bit_gr_46;

architecture Behavioral of TB_Adder_3_bit_gr_46 is

component Adder_3_bit_gr_46 
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (2 downto 0);
           C_out : out STD_LOGIC);
end component;

signal a,s : std_logic_vector (2 downto 0);
signal c : std_logic;

begin
UUT :Adder_3_bit_gr_46 port map(
        A => a,
        S => s,
        C_out => c
    );
    
process begin
   a <= "000";
   wait for 100 ns;

   a <= "001";
   wait for 100 ns;
   
   a <= "010";
   wait for 100 ns;
   
   a <= "011";
   wait for 100 ns;
   
   a <= "100";
   wait for 100 ns;
   
   a <= "101";
   wait for 100 ns;
   
   a <= "110";
   wait for 100 ns;
   
   a <= "111";
   wait;
   
end process;

end Behavioral;

