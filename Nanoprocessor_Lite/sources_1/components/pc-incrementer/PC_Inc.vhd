library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.instruction_address;

-- Program Counter Incrementer: Increments 4-bit instruction address
entity PC_Inc is
    port(
        A_in : in instruction_address;   -- 4-bit input address
        A_out : out instruction_address  -- 4-bit output address (input + 1)
    );
end PC_Inc;

architecture Behavioral of PC_Inc is
begin
    -- Simple increment by 1
    A_out <= std_logic_vector(unsigned(A_in) + 1);
end Behavioral;

