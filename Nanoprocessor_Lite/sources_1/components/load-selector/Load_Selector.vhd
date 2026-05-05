library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.data_bus;
use work.logic_components.Mux_2_N;
use work.constants.Immediate_Load;

-- Load Selector: Multiplexer between Immediate, ALU Result, and RAM Data
-- For 8-bit data
entity Load_Selector is
    port(
        LS : in std_logic;      -- Load Select (0=Immediate, 1=Register/ALU/RAM)
        IM : in data_bus;       -- Immediate Value (8-bit)
        R : in data_bus;        -- Register/ALU/RAM Value (8-bit)
        O : out data_bus        -- Output Value (8-bit)
    );
end Load_Selector;

architecture Behavioral of Load_Selector is

begin
    Mux_2_8 : Mux_2_N
    generic map(
        N => 8  -- 8-bit data bus
    )
    port map(
        S => LS,
        A => IM,
        B => R,
        O => O
    );

end Behavioral;

