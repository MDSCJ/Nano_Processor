----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 23:20:06
-- Design Name: 
-- Module Name: Program_ROM_gr_46 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Program_ROM_gr_46 is
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           instructions : out STD_LOGIC_VECTOR (11 downto 0));
end Program_ROM_gr_46;

architecture Behavioral of Program_ROM_gr_46 is

type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
    signal ROM : rom_type := ( 
    "100010000001", -- MOVI R1, 1
    "100100000010", -- MOVI R2, 2
    "100110000011", -- MOVI R3, 3
    "101110000000", -- MOVI R7, 0
    "001110010000", -- ADD R7, R1
    "001110100000", -- ADD R7, R2
    "001110110000", -- ADD R7, R3
    "110000000111" -- JZR, R0
    );
 
begin

instructions <= ROM(to_integer(unsigned(address)));

end Behavioral;
