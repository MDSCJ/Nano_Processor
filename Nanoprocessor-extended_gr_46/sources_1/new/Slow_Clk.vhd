
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Slow_Clk is
    Port (
        Clk_in   : in  STD_LOGIC;
        Clk_out  : out STD_LOGIC
    );
end Slow_Clk;

architecture Behavioral of Slow_Clk is

    -- Signals for IP connection
    signal counter_q        : std_logic_vector(25 downto 0);  -- 25-bit counter
    signal terminal_count   : std_logic;

    -- Component declaration from Binary Counter IP
    component c_counter_binary_1
        Port (
            CLK      : in  STD_LOGIC;
            CE       : in  STD_LOGIC;
            Q        : out STD_LOGIC_VECTOR (25 downto 0)
        );
    end component;

begin

    -- Instantiate the Binary Counter
    U_BinCounter : c_counter_binary_1
        port map (
            CLK      => Clk_in,
            CE       => '1',
            Q        => counter_q
        );

    Clk_out <= counter_q(25);

end Behavioral;

