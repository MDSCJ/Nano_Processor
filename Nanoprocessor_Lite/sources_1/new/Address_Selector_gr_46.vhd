----------------------------------------------------------------------------------
-- Module Name: Address_Selector_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Buses_gr_46.instruction_address;
use work.Logic_Components_gr_46.Mux_2_N_gr_46;

entity Address_Selector_gr_46 is
    port(
        PC : in instruction_address;
        JA : in instruction_address;
        J : in std_logic;
        A : out instruction_address
    );
end Address_Selector_gr_46;

architecture Behavioral of Address_Selector_gr_46 is
begin
    Mux : Mux_2_N_gr_46 generic map(N => 4)
        port map(S => J, A => PC, B => JA, O => A);
end Behavioral;
