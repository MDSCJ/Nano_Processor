----------------------------------------------------------------------------------
-- Module Name: Mux_8_to_1_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Logic_Components_gr_46.Decoder_3_to_8_gr_46;

entity Mux_8_to_1_gr_46 is
    port(S : in std_logic_vector (2 downto 0);
         D : in std_logic_vector (7 downto 0);
         EN : in std_logic := '1';
         Y : out std_logic);
end Mux_8_to_1_gr_46;

architecture Behavioral of Mux_8_to_1_gr_46 is
    signal Decoder_Output : std_logic_vector (7 downto 0);
begin
    Decoder_inst : Decoder_3_to_8_gr_46
        port map(I => S, EN => EN, Y => Decoder_Output);
    Y <= (Decoder_Output(0) and D(0)) or (Decoder_Output(1) and D(1)) or
         (Decoder_Output(2) and D(2)) or (Decoder_Output(3) and D(3)) or
         (Decoder_Output(4) and D(4)) or (Decoder_Output(5) and D(5)) or
         (Decoder_Output(6) and D(6)) or (Decoder_Output(7) and D(7));
end Behavioral;
