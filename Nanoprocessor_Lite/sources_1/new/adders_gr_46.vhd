----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2026 04:05:22 PM
-- Design Name: 
-- Module Name: Adders_gr_46 - Package
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Adder component declarations
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

package Adders_gr_46 is

    component HA_gr_46
        port(A: in std_logic; B: in std_logic;
             S: out std_logic; C: out std_logic);
    end component;

    component FA_gr_46
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; C_in : in STD_LOGIC;
               S : out STD_LOGIC; C_out : out STD_LOGIC);
    end component;

    component RCA_4_gr_46
        Port(A : in STD_LOGIC_VECTOR (3 downto 0);
            B : in STD_LOGIC_VECTOR (3 downto 0);
            C_in : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR(3 DOWNTO 0);
            C_out : out STD_LOGIC);
    end component;

    component Add_Sub_4_bit_gr_46 is
        Port(A_AS : in STD_LOGIC_VECTOR (3 DOWNTO 0);
         B_AS : in STD_LOGIC_VECTOR (3 DOWNTO 0);
         CTRL : in STD_LOGIC;
         S_AS : out STD_LOGIC_VECTOR(3 DOWNTO 0);
         Zero : out STD_LOGIC;
         OverFlow : out STD_LOGIC);
    end component;

end package Adders_gr_46;
