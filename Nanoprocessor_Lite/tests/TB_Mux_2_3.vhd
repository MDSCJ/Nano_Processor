library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Mux_2_3 is
    -- port();
end TB_Mux_2_3;

architecture Behavioral of TB_Mux_2_3 is

-- Uses generic Mux_2_N with N=3
component Mux_2_N is
    generic(
        N : integer
    );
    port(
        S: in std_logic; -- Control Bit (0 - A, 1 - B)
        A: in std_logic_vector(N - 1 downto 0); -- Data Bus A
        B: in std_logic_vector(N - 1 downto 0); -- Data Bus B
        O : out std_logic_vector(N-1 downto 0)
    );
end component;

signal S: std_logic;
signal InA: std_logic_vector(2 downto 0);
signal InB: std_logic_vector(2 downto 0);
signal Y: std_logic_vector(2 downto 0);

begin

    uut: Mux_2_N 
        generic map(N => 3)
        port map(
            S => S,
            A => InA,
            B => InB,
            O => Y
        );

    process
    begin
        -- Selecting 1 digit from a pair of digits in the index numbers
        -- 210479L and 210344U using the MUX
        InA <= "011"; -- 3
        InB <= "100"; -- 4
        S <= '0';
        wait for 10 ns;
        S <= '1';
        wait for 10 ns;
        InA <= "100"; -- 4
        InB <= "111"; -- 7
        S <= '0';
        wait for 10 ns;
        S <= '1';
        wait for 10 ns;
        wait;
    end process;    

end Behavioral;