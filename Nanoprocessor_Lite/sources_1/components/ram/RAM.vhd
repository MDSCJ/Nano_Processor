library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all;

-- 8-bit Data Memory (RAM) - 16 x 8 bits
-- 4-bit address, 8-bit data
entity RAM is
    port(
        Clk : in std_logic;                 -- Clock
        Res : in std_logic;                 -- Reset
        RAM_Addr : in ram_address;          -- 4-bit address (16 locations)
        RAM_Din : in data_bus;              -- 8-bit data input
        RAM_Dout : out data_bus;            -- 8-bit data output
        RAM_WE : in std_logic;              -- Write Enable
        RAM_OE : in std_logic               -- Output Enable
    );
end RAM;

architecture Behavioral of RAM is
    type ram_array is array (0 to 15) of std_logic_vector(7 downto 0);
    signal ram_mem : ram_array := (
        x"00", x"01", x"02", x"03",
        x"04", x"05", x"06", x"07",
        x"08", x"09", x"0A", x"0B",
        x"0C", x"0D", x"0E", x"0F"
    );
    
begin
    
    -- Synchronous write
    process(Clk, Res)
    begin
        if Res = '1' then
            -- Reset: initialize RAM with default values
            ram_mem <= (
                x"00", x"01", x"02", x"03",
                x"04", x"05", x"06", x"07",
                x"08", x"09", x"0A", x"0B",
                x"0C", x"0D", x"0E", x"0F"
            );
        elsif rising_edge(Clk) then
            if RAM_WE = '1' then
                ram_mem(to_integer(unsigned(RAM_Addr))) <= RAM_Din;
            end if;
        end if;
    end process;
    
    -- Asynchronous read
    RAM_Dout <= ram_mem(to_integer(unsigned(RAM_Addr))) when RAM_OE = '1' else
                (others => '0');
    
end Behavioral;
