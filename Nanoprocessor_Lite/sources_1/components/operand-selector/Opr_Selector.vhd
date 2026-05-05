library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.data_bus;
use work.buses.data_buses;
use work.buses.register_address;

-- Operand Selector: Multiplexer to select one of 4 registers
-- Selects 8-bit data from 4 × 8-bit register bank
entity Opr_Selector is
    port (
        Control : in register_address;  -- 2-bit address for 4 registers
        Data : in data_buses;           -- 4 × 8-bit register data
        Selected : out data_bus         -- Selected 8-bit data
    );
end Opr_Selector;

architecture Behavioral of Opr_Selector is
begin
    process(Control, Data)
    begin
        case to_integer(unsigned(Control)) is
            when 0 =>
                Selected <= Data(0);
            when 1 =>
                Selected <= Data(1);
            when 2 =>
                Selected <= Data(2);
            when 3 =>
                Selected <= Data(3);
            when others =>
                Selected <= (others => '0');
        end case;
    end process;
end Behavioral;
