----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2026 07:00:38 PM
-- Design Name: 
-- Module Name: Add_Sub_Unit_gr_46 - Behavioral
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


entity Add_Sub_Unit_gr_46 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Add_Sub_Sel : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Carry : out STD_LOGIC;
           Zero : out STD_LOGIC);
end Add_Sub_Unit_gr_46;

architecture Behavioral of Add_Sub_Unit_gr_46 is
    component RCA_4_gr_46
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               C_in : in STD_LOGIC;
               S : out STD_LOGIC_VECTOR (3 downto 0);
               C_out : out STD_LOGIC);
    end component;

    signal B_new, Sum : std_logic_vector (3 downto 0);
    signal C_out_sig : std_logic;
begin
    B_new(0) <= Add_Sub_Sel XOR B(0);
    B_new(1) <= Add_Sub_Sel XOR B(1);
    B_new(2) <= Add_Sub_Sel XOR B(2);
    B_new(3) <= Add_Sub_Sel XOR B(3);

    RCA_4_0: RCA_4_gr_46
        Port map (
            A => A,
            B => B_new,
            C_in => Add_Sub_Sel, -- Adds 1 for two's complement subtraction
            S => Sum,
            C_out => C_out_sig);

    S <= Sum;
    Carry <= C_out_sig;

    process (Sum, C_out_sig)
    begin
        if Sum = "0000" and C_out_sig = '0' then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;
end Behavioral;