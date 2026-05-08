----------------------------------------------------------------------------------
-- Create Date: 05/01/2026 04:00:15 PM
-- Module Name: TB_Mux_2_3_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Mux_2_3_gr_46 is
end TB_Mux_2_3_gr_46;

architecture Behavioral of TB_Mux_2_3_gr_46 is
    component Mux_2_N_gr_46 is
        generic(N:integer);
        port(S:in std_logic; A:in std_logic_vector(N-1 downto 0);
             B:in std_logic_vector(N-1 downto 0); O:out std_logic_vector(N-1 downto 0));
    end component;
    signal S:std_logic; signal InA,InB,Y:std_logic_vector(2 downto 0);
begin
    uut: Mux_2_N_gr_46 generic map(N=>3)
        port map(S=>S, A=>InA, B=>InB, O=>Y);
    process begin
        -- Digits from index numbers 240278 and 240238
        InA<="010"; InB<="100"; S<='0'; wait for 10 ns; S<='1'; wait for 10 ns;
        InA<="111"; InB<="011"; S<='0'; wait for 10 ns; S<='1'; wait for 10 ns;
        InA<="101"; InB<="010"; S<='0'; wait for 10 ns; S<='1'; wait for 10 ns;
        wait;
    end process;
end Behavioral;
