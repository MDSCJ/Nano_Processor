library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;

entity TB_Register_Bank is
--  Port ( );
end TB_Register_Bank;

architecture Behavioral of TB_Register_Bank is

COMPONENT Register_Bank
    Port ( Reg_En : in STD_LOGIC_VECTOR (1 downto 0);
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Data : in STD_LOGIC_VECTOR(7 downto 0);
           Data_Buses : out data_buses);
END COMPONENT;

signal Reg_En : STD_LOGIC_VECTOR (1 downto 0);
signal Res, Clk : STD_LOGIC;
signal Reg_Data_Buses : data_buses;
signal Data : STD_LOGIC_VECTOR(7 downto 0);
constant clk_period : time := 100 ns;

begin

uut: Register_Bank
    port map(Reg_En => Reg_En,
             Res => Res,
             Clk => Clk,
             Data => Data,
             Data_Buses => Reg_Data_Buses);

    clock: process
    begin
        Clk <= '0';
        wait for clk_period/2;
        Clk <= '1';
        wait for clk_period/2;
    end process;
    
    stim: process
    begin
        Res <= '1';
        wait for clk_period;
        Res <= '0';

        Reg_En <= "01";          -- Enable R1
        Data <= "00000010";      -- Put 2 into R1
        wait for clk_period;

        Reg_En <= "10";          -- Enable R2
        Data <= "00000101";      -- Put 5 into R2
        wait for clk_period;

        Reg_En <= "11";          -- Enable R3
        Data <= "00001111";      -- Put 15 into R3
        wait for clk_period;

        Reg_En <= "01";          -- Enable R1
        Data <= "00000111";      -- Put 7 into R1
        wait for clk_period;

        Reg_En <= "10";          -- Enable R2
        Res <= '1';              -- Reset
        wait for clk_period;
    end process;
end Behavioral;
