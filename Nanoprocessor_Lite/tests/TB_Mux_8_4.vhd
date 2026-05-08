library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.buses_8_4;
use work.logic_components.Mux_8_4;

entity TB_Mux_8_4 is
    -- port();
end TB_Mux_8_4;

architecture Behavioral of TB_Mux_8_4 is

signal S : std_logic_vector(2 downto 0);
signal D : buses_8_4;

signal Y : std_logic_vector(3 downto 0);
signal EN : std_logic := '1';
constant period : time := 10 ns;

begin
    uut: Mux_8_4 port map (
        S => S, 
        D => D,
        EN => EN,
        Y => Y);

    clock: process
    begin
        S <= "111";
        wait for period;
        
        S<= "110";
        wait for period;
        
        S <= "101";
        wait for period;

        S <= "100";
        wait for period;

        S <= "011";
        wait for period;

        S <= "010";
        wait for period;
        
        S <= "001";
        wait for period;
                
        S <= "000";
        wait for period;
    end process;

    stim: process
    begin
        -- following values are from index numbers 240278 and 240238
        -- 00240
        D(7) <= "0000"; D(6) <= "0000";
        D(5) <= "0010"; D(4) <= "0100";
        D(3) <= "0000";
        
        -- 278
        D(2) <= "0010";
        D(1) <= "0111"; D(0) <= "1000";
        wait for period*8;
        
        -- 238
        D(2) <= "0010";
        D(1) <= "0011"; D(0) <= "1000";
        wait for period*8;

        -- 255
        D(2) <= "0010";
        D(1) <= "0101"; D(0) <= "0101";
        wait for period*8;
    end process;

end Behavioral;