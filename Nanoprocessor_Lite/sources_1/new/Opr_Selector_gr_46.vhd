----------------------------------------------------------------------------------
-- Module Name: Opr_Selector_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Buses_gr_46.all;

entity Opr_Selector_gr_46 is
    port (Control : in register_address;
          Data : in data_buses;
          Selected : out data_bus);
end Opr_Selector_gr_46;

architecture Behavioral of Opr_Selector_gr_46 is
begin
    process(Control, Data) begin
        case Control is
            when "00" => Selected <= Data(0);
            when "01" => Selected <= Data(1);
            when "10" => Selected <= Data(2);
            when "11" => Selected <= Data(3);
            when others => Selected <= (others => '0');
        end case;
    end process;
end Behavioral;
