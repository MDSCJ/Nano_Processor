library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 4-to-1 Multiplexer for 8-bit data
entity Mux_4_to_1_8bit is
    port (
        S : in std_logic_vector(1 downto 0);   -- 2-bit select signal
        D : in std_logic_vector(31 downto 0);  -- 4 × 8-bit inputs (D0, D1, D2, D3)
        EN : in std_logic := '1';              -- Enable signal
        Y : out std_logic_vector(7 downto 0)   -- 8-bit output
    );
end Mux_4_to_1_8bit;

architecture Behavioral of Mux_4_to_1_8bit is
begin
    process(S, D, EN)
    begin
        if EN = '1' then
            case S is
                when "00" =>
                    Y <= D(7 downto 0);     -- Select first 8 bits
                when "01" =>
                    Y <= D(15 downto 8);    -- Select second 8 bits
                when "10" =>
                    Y <= D(23 downto 16);   -- Select third 8 bits
                when "11" =>
                    Y <= D(31 downto 24);   -- Select fourth 8 bits
                when others =>
                    Y <= (others => '0');
            end case;
        else
            Y <= (others => 'Z');
        end if;
    end process;
end Behavioral;
