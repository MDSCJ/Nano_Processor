----------------------------------------------------------------------------------
-- Module Name: Reg_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Logic_Components_gr_46.D_FF_gr_46;

entity Reg_gr_46 is
    generic( N : integer );
    Port ( D : in std_logic_vector(N-1 downto 0);
           Res: in STD_LOGIC;
           En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out std_logic_vector(N-1 downto 0));
end Reg_gr_46;

architecture Behavioral of Reg_gr_46 is
begin
    D_Flip_Flops: for i in 0 to N-1 generate
        D_FF_Inst: D_FF_gr_46 port map(D => D(i), Res => Res, Clk => Clk, En => En, Q => Q(i));
    end generate D_Flip_Flops;
end Behavioral;
