----------------------------------------------------------------------------------
-- Create Date: 05/01/2026 04:50:42 PM
-- Module Name: TB_Register_Bank_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Buses_gr_46.all;

entity TB_Register_Bank_gr_46 is
end TB_Register_Bank_gr_46;

architecture Behavioral of TB_Register_Bank_gr_46 is
    component Register_Bank_gr_46
        Port(Reg_En:in STD_LOGIC_VECTOR(1 downto 0); Res:in STD_LOGIC;
             Clk:in STD_LOGIC; Data:in STD_LOGIC_VECTOR(7 downto 0);
             Data_Buses:out data_buses);
    end component;
    signal Reg_En:STD_LOGIC_VECTOR(1 downto 0);
    signal Res,Clk:STD_LOGIC;
    signal Reg_Data_Buses:data_buses;
    signal Data:STD_LOGIC_VECTOR(7 downto 0);
    constant clk_period:time:=100 ns;
begin
    uut: Register_Bank_gr_46 port map(Reg_En=>Reg_En, Res=>Res,
        Clk=>Clk, Data=>Data, Data_Buses=>Reg_Data_Buses);
    clock: process begin
        Clk<='0'; wait for clk_period/2; Clk<='1'; wait for clk_period/2;
    end process;
    stim: process begin
        Res<='1'; wait for clk_period; Res<='0';
        Reg_En<="01"; Data<="00000010"; wait for clk_period;
        Reg_En<="10"; Data<="00000101"; wait for clk_period;
        Reg_En<="11"; Data<="00001111"; wait for clk_period;
        Reg_En<="01"; Data<="00000111"; wait for clk_period;
        Reg_En<="10"; Res<='1'; wait for clk_period;
    end process;
end Behavioral;
