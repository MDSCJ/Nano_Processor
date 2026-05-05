library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.instruction_address;
use work.Cpu_Components.Reg;

-- Program Counter: 4-bit counter for instruction addressing
entity PC is
    Port (
        A : in instruction_address;    -- 4-bit address input
        Res : in STD_LOGIC;             -- Reset
        Clk : in STD_LOGIC;             -- Clock
        M : out instruction_address     -- 4-bit address output
    );
end PC;

architecture Behavioral of PC is
begin
    -- 4-bit register for 16 instruction locations
    Reg_0 : Reg
        generic map (N => 4)
        port map(
            D => A,
            Res => Res,
            EN => '1',
            Clk => Clk,
            Q => M
        );
end Behavioral;
