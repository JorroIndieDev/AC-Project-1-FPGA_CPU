library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_File is
    Port( 
        clk, WE : in std_logic;
        SEL_REG1, SEL_REG2 : in std_logic_vector(2 downto 0);
        data : in std_logic_vector(7 downto 0);
        Operando1, Operando2 : out std_logic_vector(7 downto 0)
        );
end Register_File;

architecture Behavioral of Register_File is
    type reg_file is array (0 to 5) of std_logic_vector(7 downto 0);
    signal reg : reg_file := (others => (others => '0'));
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if WE = '1' then
                case SEL_REG1 is
                    when "000" => reg(0) <= data;
                    when "001" => reg(1) <= data;
                    when "010" => reg(2) <= data;
                    when "011" => reg(3) <= data;
                    when "100" => reg(4) <= data;
                    when "101" => reg(5) <= data;
                    when others => null;
                end case;
            end if ;
        end if ;
    end process;

    process(SEL_REG1, SEL_REG2, reg)
    begin
        case SEL_REG1 is
            when "000" => Operando1 <= reg(0);
            when "001" => Operando1 <= reg(1);
            when "010" => Operando1 <= reg(2);
            when "011" => Operando1 <= reg(3);
            when "100" => Operando1 <= reg(4);
            when "101" => Operando1 <= reg(5);
            when others => Operando1 <= (others => '0');
        end case;
        case SEL_REG2 is
            when "000" => Operando2 <= reg(0);
            when "001" => Operando2 <= reg(1);
            when "010" => Operando2 <= reg(2);
            when "011" => Operando2 <= reg(3);
            when "100" => Operando2 <= reg(4);
            when "101" => Operando2 <= reg(5);
            when others => Operando2 <= (others => '0');
        end case;
    end process;
end Behavioral;
