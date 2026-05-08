----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2026 05:30:00 PM
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

    component RCA_4_gr_46
        Port(A : in STD_LOGIC_VECTOR (3 downto 0);
            B : in STD_LOGIC_VECTOR (3 downto 0);
            C_in : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR(3 DOWNTO 0);
            C_out : out STD_LOGIC);
    end component;

    component RCA_3_gr_46 is
        Port ( A : in STD_LOGIC_VECTOR(2 DOWNTO 0);
                B: in STD_LOGIC_VECTOR(2 DOWNTO 0);
               C_in : in STD_LOGIC;
               S : out STD_LOGIC_VECTOR(2 DOWNTO 0);
               C_out : out STD_LOGIC);
    end component;

    component FA_gr_46
        Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S : out STD_LOGIC;
           C_out : out STD_LOGIC);
    end component;

    component HA_gr_46
    port(
        A: in std_logic;
        B: in std_logic;
        S: out std_logic;
        C: out std_logic);
    end component;

end package Adders_gr_46;
