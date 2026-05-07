library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Header file for ALU (8-bit operations)
package ALU_H is

    constant N_Arithemetic_Ops : integer := 4;  -- Add, Sub, Mul, Div
    constant N_Logical_Ops : integer := 0;
    constant N_Total_Ops : integer := N_Arithemetic_Ops + N_Logical_Ops;
    
    -- 2-bit operation selector for 4 operations
    subtype Operation_Sel is std_logic_vector(1 downto 0);    
    constant AU_ADD_SIGNAL : Operation_Sel := "00";
    constant AU_SUB_SIGNAL : Operation_Sel := "01";
    constant AU_MUL_SIGNAL : Operation_Sel := "10";
    constant AU_DIV_SIGNAL : Operation_Sel := "11";
    
    constant AU_ADD : integer := 0;
    constant AU_SUB : integer := 1;
    constant AU_MUL : integer := 2;
    constant AU_DIV : integer := 3;
    
end package ALU_H;