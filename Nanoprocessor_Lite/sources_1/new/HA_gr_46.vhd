----------------------------------------------------------------------------------
-- Module Name: HA_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HA_gr_46 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           S : out STD_LOGIC;
           C : out STD_LOGIC);
end HA_gr_46;

architecture Behavioral of HA_gr_46 is
begin
    S <= A XOR B;
    C <= A AND B;
end Behavioral;
