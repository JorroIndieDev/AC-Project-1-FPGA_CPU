library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Program_Counter is
    Port (
        CLK : in  STD_LOGIC;  
        RESET : in  STD_LOGIC;  
        ESCR_PC : in  STD_LOGIC;  
        CONSTANTE: in  STD_LOGIC_VECTOR(7 downto 0);  
        ENDERECO: out STD_LOGIC_VECTOR(7 downto 0)  
    );
end Program_Counter;

architecture Behavioral of Program_Counter is
    signal PC : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); 
begin
    process (CLK)
    begin
        if rising_edge(CLK) then  
            if RESET = '1' then  
                PC <= (others => '0');  
            elsif ESCR_PC = '1' then  
                PC <= CONSTANTE;
            else  
                PC <= PC + 1;
            end if;
        end if;
    end process;

    ENDERECO <= PC;  

end Behavioral;
