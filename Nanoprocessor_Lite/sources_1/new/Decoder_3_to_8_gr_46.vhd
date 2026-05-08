----------------------------------------------------------------------------------
-- Module Name: Decoder_3_to_8_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Logic_Components_gr_46.Decoder_2_to_4_gr_46;

entity Decoder_3_to_8_gr_46 is
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end Decoder_3_to_8_gr_46;

architecture Behavioral of Decoder_3_to_8_gr_46 is
begin
    Decoder_0 : Decoder_2_to_4_gr_46 port map(I => I(1 downto 0), EN => (EN and not I(2)), Y => Y(3 downto 0));
    Decoder_1 : Decoder_2_to_4_gr_46 port map(I => I(1 downto 0), EN => (EN and I(2)), Y => Y(7 downto 4));
end Behavioral;
