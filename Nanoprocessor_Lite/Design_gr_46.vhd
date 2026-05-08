----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2026 02:30:45 PM
-- Design Name: 
-- Module Name: Design_gr_46 - Behavioral
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Top-level Basys3 wrapper
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

entity Design_gr_46 is
    Port ( ClkIn : in STD_LOGIC;
           ResetIn : in STD_LOGIC;
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC;
           Display : out STD_LOGIC_VECTOR(3 downto 0);
           seg : out STD_LOGIC_VECTOR(6 downto 0);
           led : out STD_LOGIC_VECTOR(7 downto 0);
           ram_addr_led : out STD_LOGIC_VECTOR(3 downto 0);
           ram_data_led : out STD_LOGIC_VECTOR(7 downto 0));
end Design_gr_46;

architecture Behavioral of Design_gr_46 is

    component Slow_Clk_gr_46 is
         Port ( ClkIn : in STD_LOGIC;
             Clk_out : out STD_LOGIC);
    end component;

    component Nanoprocessor_gr_46 is
        Port ( Clock : in STD_LOGIC;
               Reset : in STD_LOGIC;
               Overflow : out STD_LOGIC;
               Zero : out STD_LOGIC;
               Data : out data_bus;
               ram_addr_out : out ram_address;
               ram_data_out : out data_bus);
    end component;

    component SevenSegmentLUT_gr_46 is
        Port ( address : in STD_LOGIC_VECTOR(3 downto 0);
               seg : out STD_LOGIC_VECTOR(6 downto 0));
    end component;

    signal Slow_Clock : STD_LOGIC;
    signal Data_Out : data_bus;
    signal RAM_Addr_Debug : ram_address;
    signal RAM_Data_Debug : data_bus;

begin
    Display <= "1110";

    Slow_Clock_0 : Slow_Clk_gr_46 port map(
        ClkIn => ClkIn, Clk_out => Slow_Clock);

    Nanoprocessor_0 : Nanoprocessor_gr_46 port map(
        Clock => Slow_Clock, Reset => ResetIn,
        Overflow => Overflow, Zero => Zero, Data => Data_Out,
        ram_addr_out => RAM_Addr_Debug, ram_data_out => RAM_Data_Debug);

    SevenSegment_0 : SevenSegmentLUT_gr_46 port map(
        address => Data_Out(3 downto 0), seg => seg);

    led <= Data_Out;
    ram_addr_led <= RAM_Addr_Debug;
    ram_data_led <= RAM_Data_Debug;

end Behavioral;
