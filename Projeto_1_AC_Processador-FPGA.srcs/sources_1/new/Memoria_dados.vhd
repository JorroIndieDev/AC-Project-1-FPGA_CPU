library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memoria_dados is
    Port (
        CLK : in STD_LOGIC;
        WR : in STD_LOGIC;
        constante : in STD_LOGIC_VECTOR(7 downto 0);
        Operando1 : in STD_LOGIC_VECTOR(7 downto 0);
        Dados_M  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Memoria_dados;

architecture Behavioral of Memoria_dados is
    type mem_array is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
    signal memoria : mem_array := (others => (others => '0'));
begin
    process(CLK, operando1, constante)
    begin
        if rising_edge(CLK) then
            if WR = '1' then
                memoria(conv_integer(constante)) <= Operando1;
            end if;
        end if;
    end process;
    Dados_M <= memoria(conv_integer(constante));

end Behavioral;
