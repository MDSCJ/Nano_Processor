----------------------------------------------------------------------------------
-- Create Date: 05/01/2026 04:35:18 PM
-- Module Name: TB_PC_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_PC_gr_46 is
end TB_PC_gr_46;

architecture Behavioral of TB_PC_gr_46 is
    component PC_gr_46 is
        port(A:in STD_LOGIC_VECTOR(3 downto 0); Res:in STD_LOGIC;
             Clk:in STD_LOGIC; M:out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    signal A,M:STD_LOGIC_VECTOR(3 downto 0);
    signal Res,Clk:STD_LOGIC;
    constant clk_period:time:=10 ns;
begin
    uut: PC_gr_46 port map(A=>A, Res=>Res, Clk=>Clk, M=>M);
    clock: process begin
        Clk<='0'; wait for clk_period/2; Clk<='1'; wait for clk_period/2;
    end process;
    stim: process begin
        Res<='1'; wait for clk_period/2; Res<='0';
        A<="0010"; wait for clk_period;
        A<="0001"; wait for clk_period;
        A<="0000"; wait for clk_period;
        A<="0100"; wait for clk_period;
        A<="0111"; wait for clk_period;
        A<="1111"; wait for clk_period;
        Res<='1'; wait;
    end process;
end Behavioral;
