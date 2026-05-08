


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MainProgram is
    Port (  Clk : in STD_LOGIC;
            Reset : in STD_LOGIC;
            SW        : in STD_LOGIC_VECTOR(2 downto 0);
            Step_Mode_Switch : in STD_LOGIC;
            Step_Button : in STD_LOGIC; 
            Mode_Switch : in STD_LOGIC;
            Twos_Complement_Switch : in STD_LOGIC;
            Seg_7_Out : out STD_LOGIC_VECTOR (7 downto 0);
            Reg_7_Out : out STD_LOGIC_VECTOR (11 downto 0);
            Overflow : out STD_LOGIC;
            Zero : out STD_LOGIC;
            Anode : out STD_LOGIC_VECTOR (3 downto 0));
end MainProgram;

architecture Behavioral of MainProgram is

    component Slow_Clk 
        port (
            Clk_in  : in  STD_LOGIC;
            Clk_out : out STD_LOGIC
        );
    end component;
    
    component Nanoprocessor
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
    end component;
    
    component LUT_16_7
        Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
               data : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    signal Display_out : STD_LOGIC_VECTOR (11 downto 0);
    signal Display_out0 : STD_LOGIC_VECTOR (11 downto 0);
    signal Display_out1 : STD_LOGIC_VECTOR (11 downto 0);
    signal Display_out2 : STD_LOGIC_VECTOR (11 downto 0);
    signal Display_out3 : STD_LOGIC_VECTOR (11 downto 0);
    signal Display_out4 : STD_LOGIC_VECTOR (11 downto 0);
    signal Display_out5 : STD_LOGIC_VECTOR (11 downto 0);
    signal Display_out6 : STD_LOGIC_VECTOR (11 downto 0);
    
    signal SlowClk : std_logic;
    
    signal count : integer := 1;
    signal LED_Counter : std_logic_vector(1 downto 0) := "00";
    
    signal pc_out : std_logic_vector(2 downto 0);
    signal seg_pc_in : STD_LOGIC_VECTOR (3 downto 0);
    signal selected_reg_out : STD_LOGIC_VECTOR(11 downto 0); 
    
    signal address_in : std_logic_vector(3 downto 0);
    signal data_out : std_logic_vector(6 downto 0);
    
    signal EffectiveClk : STD_LOGIC := '0';
    signal Step_Button_prev : STD_LOGIC := '0';
    
    signal bcd_digits : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    
    Slow_Clk_0 : Slow_Clk
        port map (
            Clk_in  => Clk,    
            Clk_out => SlowClk
        );
    
    Nanoprocessor_0 : Nanoprocessor
        port map (
             Clk => EffectiveClk,
             Reset => Reset,
             Overflow => Overflow,
             Zero => Zero,
             Reg_7_Out => Display_out,
             Reg_0_Out => Display_out0,
             Reg_1_Out => Display_out1,
             Reg_2_Out => Display_out2,
             Reg_3_Out => Display_out3,
             Reg_4_Out => Display_out4,
             Reg_5_Out => Display_out5,
             Reg_6_Out => Display_out6,
             PC_out => pc_out);
     
     LUT_16_7_0 : LUT_16_7
        port map (
            address => address_in,
            data => data_out
            );
            
    seg_pc_in <= '0' & pc_out;
                 
    -- Clock selection and step button edge detection process
    process(Clk)
    begin
        if rising_edge(Clk) then
            Step_Button_prev <= Step_Button;

            if Step_Mode_Switch = '0' then
                EffectiveClk <= SlowClk;
            else
                if (Step_Button = '1' and Step_Button_prev = '0') then
                    EffectiveClk <= '1';
                else
                    EffectiveClk <= '0';
                end if;
            end if;
        end if;
    end process;
    
     PROCESS(Clk)
          BEGIN
              IF rising_edge(Clk) THEN
                  count <= count + 1;
                  IF count = 100000 THEN
                      LED_Counter <= std_logic_vector(unsigned(LED_Counter) + 1);
                      count <= 1;
                  END IF;
              END IF;
     END PROCESS;   
      
     process(SW, Display_out0, Display_out1, Display_out2, Display_out3, Display_out4, Display_out5, Display_out6, Display_out)
       begin
           case SW is
               when "000" => selected_reg_out <= Display_out0;
               when "001" => selected_reg_out <= Display_out1;
               when "010" => selected_reg_out <= Display_out2;
               when "011" => selected_reg_out <= Display_out3;
               when "100" => selected_reg_out <= Display_out4;
               when "101" => selected_reg_out <= Display_out5;
               when "110" => selected_reg_out <= Display_out6;
               when "111" => selected_reg_out <= Display_out;
               when others => selected_reg_out <= "000000000000";
           end case;
       end process;
     
     Reg_7_Out <= selected_reg_out;
     
     process(selected_reg_out, Twos_Complement_Switch)
         variable binary_val : integer;
         variable signed_val : integer;
         variable temp_bcd : std_logic_vector(15 downto 0);
     begin
         if Twos_Complement_Switch = '1' then
             signed_val := to_integer(signed(selected_reg_out));
             if signed_val < 0 then
                 binary_val := abs(signed_val); 
             else
                 binary_val := signed_val;
             end if;
         else

             binary_val := to_integer(unsigned(selected_reg_out));
         end if;
     

         temp_bcd := (others => '0');
         temp_bcd(3 downto 0)   := std_logic_vector(to_unsigned(binary_val mod 10, 4));
         temp_bcd(7 downto 4)   := std_logic_vector(to_unsigned((binary_val / 10) mod 10, 4));
         temp_bcd(11 downto 8)  := std_logic_vector(to_unsigned((binary_val / 100) mod 10, 4));
         temp_bcd(15 downto 12) := std_logic_vector(to_unsigned(binary_val / 1000, 4));
     
         bcd_digits <= temp_bcd;
     end process;


     
     process(LED_Counter, selected_reg_out, seg_pc_in, Mode_Switch)
     begin
         if Mode_Switch = '1' then
             case LED_Counter is
                 when "00" =>
                     Anode <= "1110"; 
                     address_in <= bcd_digits(3 downto 0);
                     Seg_7_Out <= '1' & data_out;
     
                 when "01" =>
                     Anode <= "1101";
                     address_in <= bcd_digits(7 downto 4);
                     Seg_7_Out <= '1' & data_out;
     
                 when "10" =>
                     Anode <= "1011";
                     address_in <= bcd_digits(11 downto 8);
                     Seg_7_Out <= '1' & data_out;
     
                 when "11" =>
                     Anode <= "0111"; 
                     address_in <= bcd_digits(15 downto 12);
                     Seg_7_Out <= '1' & data_out;
 
                 when others =>
                     Anode <= "1111";
                     Seg_7_Out <= "11111111";
             end case;
         else
             case LED_Counter is
                 when "00" =>
                     Anode <= "1110";
                     address_in <= selected_reg_out(3 downto 0);
                     Seg_7_Out <= '1' & data_out;
 
                 when "01" =>
                     Anode <= "1101";
                     address_in <= selected_reg_out(7 downto 4);
                     Seg_7_Out <= '1' & data_out;
 
                 when "10" =>
                     Anode <= "1011";
                     address_in <= selected_reg_out(11 downto 8);
                     Seg_7_Out <= '1' & data_out;
 
                 when "11" =>
                     Anode <= "0111";
                     address_in <= seg_pc_in;
                     Seg_7_Out <= '1' & data_out;
 
                 when others =>
                     Anode <= "1111";
                     Seg_7_Out <= "11111111";
             end case;
         end if;
     end process;
 
 end Behavioral;