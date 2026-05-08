----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 23:55:10
-- Design Name: 
-- Module Name: TB_Program_counter_gr_46 - Behavioral
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

entity TB_Program_counter_gr_46 is
--  Port ( );
end TB_Program_counter_gr_46;

architecture Behavioral of TB_Program_counter_gr_46 is

    component Program_counter_gr_46
        Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
               Res : in STD_LOGIC;
               Clk : in STD_LOGIC;
               Q : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    signal D     : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal Res   : STD_LOGIC ;
    signal Clk   : STD_LOGIC := '0';
    signal Q     : STD_LOGIC_VECTOR(2 downto 0);
begin
    uut: Program_counter_gr_46 Port Map (
        D => D,
        Res => Res,
        Clk => Clk,
        Q => Q
    );
    process
        begin
        while true loop
            Clk <= '0';
            wait for 10 ns;
            Clk <= '1';
            wait for 10 ns;
        end loop;
    end process;
    
    process
        begin
            Res <= '0';
            D <= "000";
            wait for 20 ns;
    
            D <= "001";
            wait for 20 ns;
            
            D <= "010";
            wait for 20 ns;
            
            D <= "011";
            wait for 20 ns;
            Res <= '1';
            
            D <= "100";
            wait for 20 ns;
            
            D <= "101";
            wait for 20 ns;
            
            D <= "110";
            wait for 20 ns;
            
            D <= "111";
            wait for 20 ns;
           
            Res <= '1';
            D <= "000";
            wait for 20 ns;
    
            D <= "001";
            wait for 20 ns;
            
            D <= "010";
            wait for 20 ns;
            
            D <= "011";
            wait for 20 ns;
            Res <= '0';
            
            D <= "100";
            wait for 20 ns;
            
            D <= "101";
            wait for 20 ns;
            
            D <= "110";
            wait for 20 ns;
            
            D <= "111";
            wait for 20 ns;
            wait;
    end process;

end Behavioral;
