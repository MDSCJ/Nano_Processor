
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Divider_8bit_tb is
-- No ports
end Divider_8bit_tb;

architecture Behavioral of Divider_8bit_tb is

    -- Component under test (CUT)
    component Divider_8bit
        Port (
            Dividend  : in  STD_LOGIC_VECTOR(7 downto 0);
            Divisor   : in  STD_LOGIC_VECTOR(7 downto 0);
            Quotient  : out STD_LOGIC_VECTOR(7 downto 0);
            Remainder : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals for connecting to CUT
    signal Dividend  : STD_LOGIC_VECTOR(7 downto 0);
    signal Divisor   : STD_LOGIC_VECTOR(7 downto 0);
    signal Quotient  : STD_LOGIC_VECTOR(7 downto 0);
    signal Remainder : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instantiate the Divider
    uut: Divider_8bit
        Port map (
            Dividend  => Dividend,
            Divisor   => Divisor,
            Quotient  => Quotient,
            Remainder => Remainder
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test Case 1: 150 / 12 = 12 R 6
        Dividend <= std_logic_vector(to_unsigned(150, 8));
        Divisor  <= std_logic_vector(to_unsigned(12, 8));
        wait for 10 ns;

        -- Test Case 2: 240 / 16 = 15 R 0
        Dividend <= std_logic_vector(to_unsigned(240, 8));
        Divisor  <= std_logic_vector(to_unsigned(16, 8));
        wait for 10 ns;

        -- Test Case 3: 47 / 5 = 9 R 2
        Dividend <= std_logic_vector(to_unsigned(47, 8));
        Divisor  <= std_logic_vector(to_unsigned(5, 8));
        wait for 10 ns;

        -- Test Case 4: Divide by zero (Edge Case)
        Dividend <= std_logic_vector(to_unsigned(88, 8));
        Divisor  <= std_logic_vector(to_unsigned(0, 8));
        wait for 10 ns;

        -- Finish simulation
        wait;
    end process;

end Behavioral;