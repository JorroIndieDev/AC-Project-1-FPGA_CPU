library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- keeping the names given by the image and the project description
-- to keep it easier to cross reference
entity MUX_R is
 Port (
    SEL_R : in std_logic_vector(1 downto 0);
    Dados_M, Dados_IN, Resultado, Constante : in std_logic_vector(7 downto 0);
    Dados_R : out std_logic_vector(7 downto 0)
 );
end MUX_R;

architecture Behavioral of MUX_R is
    signal data : std_logic_vector(7 downto 0) := (others => '0');
begin

    process
    begin
        case SEL_R is
            when "00" => data <= Resultado;
            when "01" => data <= Dados_IN;
            when "10" => data <= Dados_M;
            when "11" => data <= Constante;
            when others => data <= (others => '0');
        end case;
    end process;
    
    Dados_R <= data;

end Behavioral;
