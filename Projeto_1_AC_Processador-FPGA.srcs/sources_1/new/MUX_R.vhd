library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_R is
    Port (
        SEL_R : in std_logic_vector(1 downto 0);
        Dados_M, Dados_IN, Resultado, Constante : in std_logic_vector(7 downto 0);
        Dados_R : out std_logic_vector(7 downto 0)
    );
end MUX_R;

architecture Behavioral of MUX_R is
begin

    process(SEL_R, Dados_M, Dados_IN, Resultado, Constante)
    begin
        case SEL_R is
            when "00" => Dados_R <= Resultado;
            when "01" => Dados_R <= Dados_IN;
            when "10" => Dados_R <= Dados_M;
            when "11" => Dados_R <= Constante;
            when others => Dados_R <= (others => '0');
        end case;
    end process;

end Behavioral;
