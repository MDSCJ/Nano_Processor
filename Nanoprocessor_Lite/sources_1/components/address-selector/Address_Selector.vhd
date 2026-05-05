library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;
use work.logic_components.Mux_2_N;

-- Address Selector: Multiplexer to select between PC (normal) or Jump Address
-- For 4-bit instruction addresses (16 instruction locations)
entity Address_Selector is
    port(
        PC : in instruction_address;    -- Next Program Counter Address (4-bit)
        JA : in instruction_address;    -- Jump Address (4-bit)
        J : in std_logic;               -- Jump Flag (1=Jump, 0=PC)
        A : out instruction_address     -- Selected Address (4-bit)
    );
end Address_Selector;

architecture Behavioral of Address_Selector is
begin
    Mux_2_4: Mux_2_N
    generic map(
        N => 4  -- 4-bit instruction address
    )
    port map(
        S => J,
        A => PC,
        B => JA,
        O => A
    );
end Behavioral;

