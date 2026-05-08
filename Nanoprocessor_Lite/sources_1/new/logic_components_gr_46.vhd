----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2026 04:40:55 PM
-- Design Name: 
-- Module Name: Logic_Components_gr_46 - Package
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Logic component declarations
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
use work.Buses_gr_46.all;

package Logic_Components_gr_46 is

    component Mux_2_N_gr_46 is
        generic(
            N : integer
        );
        port(
            S: in std_logic;
            A: in std_logic_vector(N - 1 downto 0);
            B: in std_logic_vector(N - 1 downto 0);
            O : out std_logic_vector(N-1 downto 0)
        );
    end component;

    component Mux_4_to_1_8bit_gr_46 is
        port(
            S : in std_logic_vector(1 downto 0);
            D : in data_buses;
            Y : out data_bus
        );
    end component;

    component Decoder_2_to_4_gr_46
        Port ( I : in STD_LOGIC_VECTOR (1 downto 0);
                EN: in STD_LOGIC;
               Y : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    component D_FF_gr_46
        Port ( D : in STD_LOGIC := '0';
            Res : in STD_LOGIC;
            Clk : in STD_LOGIC;
            En : in STD_LOGIC;
            Q : out STD_LOGIC;
            Qbar : out STD_LOGIC);
    end component;

end package Logic_Components_gr_46;
