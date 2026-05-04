----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2026 07:01:35 PM
-- Design Name: 
-- Module Name: Adder_3bit_gr_46 - Behavioral
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

entity Adder_3bit_gr_46 is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (2 downto 0);
           C_out : out STD_LOGIC);
end Adder_3bit_gr_46;

architecture Behavioral of Adder_3bit_gr_46 is
    component FA_gr_46
        port (
            A: in std_logic;
            B: in std_logic;
            C_in: in std_logic;
            S: out std_logic;
            C_out: out std_logic);
    end component;

    signal C1, C2, C3 : std_logic;
    signal Sum : std_logic_vector (2 downto 0);
    signal Inc : std_logic := '1';
begin
    FA_0: FA_gr_46
        port map (
            A => A(0),
            B => Inc,
            C_in => '0',
            S => Sum(0),
            C_out => C1
        );

    FA_1: FA_gr_46
        port map (
            A => A(1),
            B => '0',
            C_in => C1,
            S => Sum(1),
            C_out => C2
        );

    FA_2: FA_gr_46
        port map (
            A => A(2),
            B => '0',
            C_in => C2,
            S => Sum(2),
            C_out => C3
        );

    S <= Sum;
    C_out <= C3;
end Behavioral;
