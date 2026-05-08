----------------------------------------------------------------------------------
-- Module Name: Register_Bank_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Buses_gr_46.all;
use work.Logic_Components_gr_46.Decoder_2_to_4_gr_46;
use work.Cpu_Components_gr_46.Reg_gr_46;

entity Register_Bank_gr_46 is
    Port ( Reg_En : in register_address;
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Data : in data_bus;
           Data_Buses : out data_buses);
end Register_Bank_gr_46;

architecture Behavioral of Register_Bank_gr_46 is
    signal Decoder_Output : STD_LOGIC_VECTOR(3 downto 0);
begin
    Decoder : Decoder_2_to_4_gr_46 port map(I => Reg_En, EN => '1', Y => Decoder_Output);
    Reg_0 : Reg_gr_46 generic map(N => 8) port map(D => "00000000", Res => Res, Clk => Clk, En => Decoder_Output(0), Q => Data_Buses(0));
    Reg_1 : Reg_gr_46 generic map(N => 8) port map(D => Data, Res => Res, Clk => Clk, En => Decoder_Output(1), Q => Data_Buses(1));
    Reg_2 : Reg_gr_46 generic map(N => 8) port map(D => Data, Res => Res, Clk => Clk, En => Decoder_Output(2), Q => Data_Buses(2));
    Reg_3 : Reg_gr_46 generic map(N => 8) port map(D => Data, Res => Res, Clk => Clk, En => Decoder_Output(3), Q => Data_Buses(3));
end Behavioral;
