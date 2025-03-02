
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Peripheral_Manager is
 Port ( 
        P_in, operando1: in std_logic_vector(7 downto 0); 
        ESCR_P, clk: in std_logic;
        P_out, Dados_IN : out std_logic_vector(7 downto 0));
end Peripheral_Manager;

architecture Behavioral of Peripheral_Manager is

    signal valueIn : std_logic_vector(7 downto 0);

begin

    process(clk)
    begin
        valueIN <= (others => '0');
        if rising_edge(clk) then
            if ESCR_P = '1' then
                valueIN <= operando1;
            end if;
        end if;
    end process;

    Dados_IN <= P_in when ESCR_P = '0' else (others => '0');
    P_out <= valueIN;

end Behavioral;
