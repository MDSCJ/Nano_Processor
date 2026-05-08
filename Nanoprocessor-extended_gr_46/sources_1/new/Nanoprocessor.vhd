library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Nanoprocessor is
    Port (
        Clk        : in  STD_LOGIC;
        Reset      : in  STD_LOGIC;
        Overflow   : out STD_LOGIC;
        Zero       : out STD_LOGIC;
        Reg_7_Out  : out STD_LOGIC_VECTOR (11 downto 0);
        Reg_0_Out  : out STD_LOGIC_VECTOR (11 downto 0);
        Reg_1_Out  : out STD_LOGIC_VECTOR (11 downto 0);
        Reg_2_Out  : out STD_LOGIC_VECTOR (11 downto 0);
        Reg_3_Out  : out STD_LOGIC_VECTOR (11 downto 0);
        Reg_4_Out  : out STD_LOGIC_VECTOR (11 downto 0);
        Reg_5_Out  : out STD_LOGIC_VECTOR (11 downto 0);
        Reg_6_Out  : out STD_LOGIC_VECTOR (11 downto 0);
        PC_out     : out STD_LOGIC_VECTOR (2 downto 0)
    );
end Nanoprocessor;

architecture Behavioral of Nanoprocessor is

    -- Components updated for 12-bit
    component Register_Bank
        Port (
            Clk    : in  STD_LOGIC;
            RegEN  : in  STD_LOGIC_VECTOR (2 downto 0);
            Data   : in  STD_LOGIC_VECTOR (11 downto 0);
            Reset  : in  STD_LOGIC;
            Reg0   : out STD_LOGIC_VECTOR (11 downto 0);
            Reg1   : out STD_LOGIC_VECTOR (11 downto 0);
            Reg2   : out STD_LOGIC_VECTOR (11 downto 0);
            Reg3   : out STD_LOGIC_VECTOR (11 downto 0);
            Reg4   : out STD_LOGIC_VECTOR (11 downto 0);
            Reg5   : out STD_LOGIC_VECTOR (11 downto 0);
            Reg6   : out STD_LOGIC_VECTOR (11 downto 0);
            Reg7   : out STD_LOGIC_VECTOR (11 downto 0)
        );
    end component;

    component Program_Counter
        Port (
            D   : in  STD_LOGIC_VECTOR(2 downto 0);
            Res : in  STD_LOGIC;
            Clk : in  STD_LOGIC;
            Sel : in  STD_LOGIC;
            Q   : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    component Program_ROM
        Port (
            address      : in  STD_LOGIC_VECTOR(2 downto 0);
            instructions : out STD_LOGIC_VECTOR(20 downto 0)  -- Keep as-is unless instruction width increases
        );
    end component;

    component Instruction_Decoder
        Port (
            Instruction     : in  STD_LOGIC_VECTOR(20 downto 0);
            Reg_Check_Jump  : in  STD_LOGIC_VECTOR(11 downto 0);
            Add_Sub_Sel     : out STD_LOGIC;
            RegA            : out STD_LOGIC_VECTOR(2 downto 0);
            RegB            : out STD_LOGIC_VECTOR(2 downto 0);
            Immediate_Value : out STD_LOGIC_VECTOR(11 downto 0);
            Load_Sel        : out STD_LOGIC_VECTOR(2 downto 0);
            Reg_EN          : out STD_LOGIC_VECTOR(2 downto 0);
            Jump_Flag       : out STD_LOGIC;
            Jump_Address    : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    component Add_Sub_Unit
        Port (
            A           : in  STD_LOGIC_VECTOR(11 downto 0);
            B           : in  STD_LOGIC_VECTOR(11 downto 0);
            Add_Sub_Sel : in  STD_LOGIC;
            S           : out STD_LOGIC_VECTOR(11 downto 0);
            Carry       : out STD_LOGIC;
            Zero        : out STD_LOGIC
        );
    end component;

    component Even_Odd
        Port (
            Data_In : in  STD_LOGIC_VECTOR(11 downto 0);
            Is_Even : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;

    component Comp
        Port (
            H_or_L   : in  STD_LOGIC;
            A       : in  STD_LOGIC_VECTOR(11 downto 0);
            B       : in  STD_LOGIC_VECTOR(11 downto 0);
            Max_Out : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;

    component Multiplier_6bit
        Port (
            A       : in  STD_LOGIC_VECTOR(11 downto 0);
            B       : in  STD_LOGIC_VECTOR(11 downto 0);
            Product : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;

    component Divider_12bit
        Port (
            D_or_R             : in  STD_LOGIC;
            Dividend           : in  STD_LOGIC_VECTOR(11 downto 0);
            Divisor            : in  STD_LOGIC_VECTOR(11 downto 0);
            Quotient_Remainder : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;

    -- Internal Signals
    signal sub, jflag : STD_LOGIC;
    signal load_sel   : STD_LOGIC_VECTOR(2 downto 0);
    signal reg_en     : STD_LOGIC_VECTOR(2 downto 0);
    signal PCaddress, jump_add : STD_LOGIC_VECTOR(2 downto 0);
    signal mux_1, mux_2 : STD_LOGIC_VECTOR(2 downto 0);
    signal Instruction : STD_LOGIC_VECTOR(20 downto 0);
    signal IVal, result, reg_data, EOVal, MaxVal, product, quotient_remainder : STD_LOGIC_VECTOR(11 downto 0);
    signal r0, r1, r2, r3, r4, r5, r6, r7 : STD_LOGIC_VECTOR(11 downto 0);
    signal data1, data2 : STD_LOGIC_VECTOR(11 downto 0);

begin

        -- Program Counter
    Program_Counter_0 : Program_Counter
        port map (
            D    => jump_add,
            Res  => Reset,
            Clk  => Clk,
            Sel  => jflag,
            Q    => PCaddress
        );
    
    Program_Rom_0 : Program_ROM
        port map (
            address      => PCaddress,
            instructions => Instruction
        );
    
    Instruction_Decoder_0 : Instruction_Decoder
        port map (
            Instruction     => Instruction,
            Reg_Check_Jump  => data1,
            Add_Sub_Sel     => sub,
            RegA            => mux_1,
            RegB            => mux_2,
            Immediate_Value => IVal,
            Load_Sel        => load_sel,
            Reg_EN          => reg_en,
            Jump_Flag       => jflag,
            Jump_Address    => jump_add
        );
    
    Register_Bank_0 : Register_Bank
        port map (
            Clk    => Clk,
            RegEN  => reg_en,
            Data   => reg_data,
            Reset  => Reset,
            Reg0   => r0, Reg1 => r1, Reg2 => r2, Reg3 => r3,
            Reg4   => r4, Reg5 => r5, Reg6 => r6, Reg7 => r7
        );
    
    -- MUX logic
    data1 <= r0 when mux_1 = "000" else r1 when mux_1 = "001" else
             r2 when mux_1 = "010" else r3 when mux_1 = "011" else
             r4 when mux_1 = "100" else r5 when mux_1 = "101" else
             r6 when mux_1 = "110" else r7;
    
    data2 <= r0 when mux_2 = "000" else r1 when mux_2 = "001" else
             r2 when mux_2 = "010" else r3 when mux_2 = "011" else
             r4 when mux_2 = "100" else r5 when mux_2 = "101" else
             r6 when mux_2 = "110" else r7;
    
    -- ALU Operations
    Add_Sub_Unit_0 : Add_Sub_Unit
        port map (
            A           => data1,
            B           => data2,
            Add_Sub_Sel => sub,
            S           => result,
            Carry       => Overflow,
            Zero        => Zero
        );
    
    Even_Odd_0 : Even_Odd 
        port map (Data_In => data1, Is_Even => EOVal);
        
    Comp_0 : Comp 
        port map (H_or_L => Instruction(0), A => data1, B => data2, Max_Out => MaxVal);
        
    Multiplier_6bit_0 : Multiplier_6bit 
        port map (A => data1, B => data2, Product => product);
        
    Divider_12bit_0 : Divider_12bit 
        port map (
            D_or_R => Instruction(0),
            Dividend => data1,
            Divisor  => data2,
            Quotient_Remainder => quotient_remainder
        );
    
    -- Result Selector
    reg_data <= IVal     when load_sel = "001" else
                MaxVal   when load_sel = "010" else
                EOVal    when load_sel = "011" else
                product  when load_sel = "100" else
                quotient_remainder when load_sel = "101" else
                result;
    
    -- Outputs
    Reg_0_Out <= r0; Reg_1_Out <= r1; Reg_2_Out <= r2; Reg_3_Out <= r3;
    Reg_4_Out <= r4; Reg_5_Out <= r5; Reg_6_Out <= r6; Reg_7_Out <= r7;
    PC_out    <= PCaddress;
    
end Behavioral;