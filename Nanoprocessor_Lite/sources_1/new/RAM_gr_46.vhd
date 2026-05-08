----------------------------------------------------------------------------------
-- Module Name: RAM_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Buses_gr_46.all;

entity RAM_gr_46 is
    port(
        Clk : in std_logic;
        Res : in std_logic;
        RAM_Addr : in ram_address;
        RAM_Din : in data_bus;
        RAM_Dout : out data_bus;
        RAM_WE : in std_logic;
        RAM_OE : in std_logic
    );
end RAM_gr_46;

architecture Behavioral of RAM_gr_46 is
    type ram_type is array (0 to 15) of std_logic_vector(7 downto 0);
    signal ram_mem : ram_type := (
        x"00", x"01", x"02", x"03",
        x"04", x"05", x"06", x"07",
        x"08", x"09", x"0A", x"0B",
        x"0C", x"0D", x"0E", x"0F"
    );
begin
    process(Clk) begin
        if rising_edge(Clk) then
            if Res = '1' then
                ram_mem <= (
                    x"00", x"01", x"02", x"03",
                    x"04", x"05", x"06", x"07",
                    x"08", x"09", x"0A", x"0B",
                    x"0C", x"0D", x"0E", x"0F"
                );
            elsif RAM_WE = '1' then
                ram_mem(to_integer(unsigned(RAM_Addr))) <= RAM_Din;
            end if;
        end if;
    end process;

    RAM_Dout <= ram_mem(to_integer(unsigned(RAM_Addr))) when RAM_OE = '1' else
                (others => '0');
end Behavioral;
