----------------------------------------------------------------------------------
-- Module Name: MUX_8_4_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Buses_gr_46.buses_8_4;

entity Mux_8_4_gr_46 is
    port (S : in std_logic_vector (2 downto 0);
          D : in buses_8_4;
          EN : in std_logic := '1';
          Y : out std_logic_vector(3 downto 0));
end Mux_8_4_gr_46;

architecture Behavioral of Mux_8_4_gr_46 is
    component Mux_8_to_1_gr_46 is
        port(S : in std_logic_vector (2 downto 0);
             D : in std_logic_vector (7 downto 0);
             EN : in std_logic := '1';
             Y : out std_logic);
    end component;
    signal D_Flat : std_logic_vector(31 downto 0);
begin
    Flatten : for i in 0 to 7 generate
        D_Flat(i*4+3 downto i*4) <= D(i);
    end generate Flatten;
    Mux_Gen : for j in 0 to 3 generate
        signal Mux_D : std_logic_vector(7 downto 0);
    begin
        Map_D : for i in 0 to 7 generate
            Mux_D(i) <= D_Flat(i*4 + j);
        end generate Map_D;
        Mux_inst : Mux_8_to_1_gr_46 port map(S => S, D => Mux_D, EN => EN, Y => Y(j));
    end generate Mux_Gen;
end Behavioral;
