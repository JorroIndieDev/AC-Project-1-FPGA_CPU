
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Peripheral_Manager is
 Port ( 
        P_in, operando1: in std_logic_vector(7 downto 0); 
        ESCR_P, clk: in std_logic;
        P_out, Dados_IN : out std_logic_vector(7 downto 0)
    );
end Peripheral_Manager;

architecture Behavioral of Peripheral_Manager is

    signal valueIn : std_logic_vector(7 downto 0) := (others => '0');
begin

    process(clk, ESCR_P, operando1)
    begin
        if rising_edge(clk) then
            if ESCR_P = '1' then
                P_out <= operando1;
            end if;
        end if;
    end process;
    
    Dados_in <= P_in when ESCR_P = '0';

end Behavioral;
