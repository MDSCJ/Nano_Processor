library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Mux_2_4 is
    -- port();
end TB_Mux_2_4;

architecture Behavioral of TB_Mux_2_4 is

-- Uses generic Mux_2_N with N=4
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
signal InA: std_logic_vector(3 downto 0);
signal InB: std_logic_vector(3 downto 0);
signal Y: std_logic_vector(3 downto 0);

begin
    uut : Mux_2_N 
        generic map(N => 4)
        port map(
            S => S,
            A => InA,
            B => InB,
            O => Y
        );

    process
    begin
        -- Selecting last 3 digits of index numbers
        -- 210479L and 210344U using the MUX
        InA <= "0011"; -- 3 in binary
        InB <= "0100"; -- 4 in binary
        S <= '0';
        wait for 10 ns;
        S <= '1';
        wait for 10 ns;
        InA <= "0100"; -- 4 in binary
        InB <= "0111"; -- 7 in binary
        S <= '0';
        wait for 10 ns;
        S <= '1';
        wait for 10 ns;
        InA <= "0100"; -- 4 in binary
        InB <= "1001"; -- 9 in binary
        S <= '0';
        wait for 10 ns;
        S <= '1';
        wait for 10 ns;
        -- Other test case
        InA <= "1010"; -- 10 in binary
        InB <= "1010"; -- 10 in binary
        S <= '0';
        wait for 10 ns;
        S <= '1';
        wait for 10 ns;
        wait;
    end process;

end Behavioral;