library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_PC is
Port (
    S_FLAG, ONE, ZERO : in std_logic;
    SEL_PC : in std_logic_vector(2 downto 0);
    Operando1 : in std_logic_vector(7 downto 0);
    ESCR_PC : out std_logic
 );
end MUX_PC;

architecture Behavioral of MUX_PC is

begin

    with SEL_PC SELECT
    ESCR_PC <= ZERO when "000",
                ONE when "001",
                S_FLAG when "010",
                NOT(Operando1(7) OR Operando1(6) OR 
                    Operando1(5) OR Operando1(4) OR 
                    Operando1(3) or Operando1(2) OR 
                    Operando1(1) OR Operando1(0)) when "011",
                Operando1(7) when "100",
                '0' when others;

end Behavioral;
