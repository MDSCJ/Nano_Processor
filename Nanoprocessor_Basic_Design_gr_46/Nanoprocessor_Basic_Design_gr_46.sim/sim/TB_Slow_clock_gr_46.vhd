----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2026 01:25:26
-- Design Name: 
-- Module Name: TB_Slow_clock - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Slow_clock is
--  Port ( );
end TB_Slow_clock;

architecture Behavioral of TB_Slow_clock is
    component Slow_clock_gr_46
        Port ( Clk_in : in STD_LOGIC;
               Clk_out : out STD_LOGIC);
    end component;
    
   signal Clk_in_tb : STD_LOGIC := '0';
   signal Clk_out_tb : STD_LOGIC;
   constant Clk_Period : time := 10 ns;

begin
    uut: Slow_clock_gr_46
    port map (
        Clk_in => Clk_in_tb,
        Clk_out => Clk_out_tb
    );
    process
        begin
            while now < 1 ms loop  
                Clk_in_tb <= '0';
                wait for Clk_Period/2;
                Clk_in_tb <= '1';
                wait for Clk_Period/2;
        end loop;
        wait;
    end process;

end Behavioral;
