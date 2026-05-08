----------------------------------------------------------------------------------
-- Module Name: Load_Selector_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Buses_gr_46.data_bus;
use work.Logic_Components_gr_46.Mux_2_N_gr_46;

entity Load_Selector_gr_46 is
    port(
        LS : in std_logic;
        IM : in data_bus;
        R: in data_bus;
        O: out data_bus
    );
end Load_Selector_gr_46;

architecture Behavioral of Load_Selector_gr_46 is
begin
    Mux : Mux_2_N_gr_46 generic map(N => 8)
        port map(S => LS, A => IM, B => R, O => O);
end Behavioral;
