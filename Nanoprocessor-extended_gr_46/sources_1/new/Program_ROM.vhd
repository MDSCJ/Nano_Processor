

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Program_ROM is
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           instructions : out STD_LOGIC_VECTOR (20 downto 0));
end Program_ROM;

architecture Behavioral of Program_ROM is

type rom_type is array (0 to 7) of std_logic_vector(20 downto 0);
    signal ROM : rom_type := ( 
        "010001000001111101000", --MOVI R1, 3E8  1000
        "010010000000000001111", --MOVI R2, F      15
        "010011000000011111010", --MOVI R3, FA    250
        "010100000000000111101", --MOVI R4, 3d     61
        "010101000101011111111",-- MOVI R5, AFF   2815  /  -1281
        "110010100000000000000",-- MUL R2,R4      Hex=393
        "111001100000000000000",-- DIV R1,R4      Q Hex=10/ R Hex=18
        "011100000000111101111" -- JUMP 111 if R4 is 3d
    );
 
begin

instructions <= ROM(to_integer(unsigned(address)));

end Behavioral;
