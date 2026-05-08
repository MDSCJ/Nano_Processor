----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2026 05:30:00 PM
-- Design Name: 
-- Module Name: Cpu_Components_gr_46 - Package
-- Project Name: Nanoprocessor_Lite
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: CPU component declarations
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Buses_gr_46.all;
use work.ALU_H_gr_46.all;

package Cpu_Components_gr_46 is

    component IDecoder_gr_46 is
        port(
            I: in instruction_bus;
            RCJump: in data_bus;
            Zero_Flag: in std_logic;
            Carry_Flag: in std_logic;
            Negative_Flag: in std_logic;
            REn: out register_address;
            RSA: out register_address;
            RSB: out register_address;
            OpS: out Operation_Sel;
            IM: out data_bus;
            J: out std_logic := '0';
            JA: out instruction_address;
            L: out std_logic;
            RAM_Addr: out ram_address;
            RAM_WE: out std_logic;
            RAM_OE: out std_logic
        );
    end component;

    component PC_gr_46 is
        Port ( A : in instruction_address;
               Res : in STD_LOGIC;
               Clk : in STD_LOGIC;
               M : out instruction_address);
    end component;

    component PC_Inc_gr_46 is
        port(
            A_in: in instruction_address;
            A_out: out instruction_address
        );
    end component;

    component Register_Bank_gr_46 is
        Port ( Reg_En : in register_address;
               Res : in STD_LOGIC;
               Clk : in STD_LOGIC;
               Data : in data_bus;
               Data_Buses : out data_buses);
    end component;

    component Reg_gr_46
    generic(
        N : integer
    );
    Port ( D : in std_logic_vector(N-1 downto 0);
           Res: in STD_LOGIC;
           En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out std_logic_vector(N-1 downto 0));
    end component;

    component Load_Selector_gr_46 is
        port(
            LS : in std_logic;
            IM : in data_bus;
            R: in data_bus;
            O: out data_bus
        );
    end component;

    component Address_Selector_gr_46 is
        port(
            PC : in instruction_address;
            JA : in instruction_address;
            J : in std_logic;
            A : out instruction_address
        );
    end component;

    component Program_ROM_gr_46 is
        port(ROM_address : in instruction_address;
             I: out instruction_bus);
    end component;

    component Opr_Selector_gr_46 is
        port (Control : in register_address;
                Data : in data_buses;
                Selected : out data_bus);
    end component;

    component AU_gr_46 is
        port(
            I1 : in data_bus;
            I2 : in data_bus;
            O : out data_bus;
            Overflow : out std_logic;
            Zero : out std_logic := '0';
            Carry : out std_logic;
            Negative : out std_logic;
            Operation : in Operation_Sel
        );
    end component;

end package Cpu_Components_gr_46;
