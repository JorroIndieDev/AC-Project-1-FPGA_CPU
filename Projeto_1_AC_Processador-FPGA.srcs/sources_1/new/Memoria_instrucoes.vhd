library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memoria_instrucoes is
    Port (
        Endereco : in STD_LOGIC_VECTOR(7 downto 0);
        opcode: out STD_LOGIC_VECTOR(4 downto 0);
        SEL_REG1 : out STD_LOGIC_VECTOR(2 downto 0);
        SEL_REG2 : out STD_LOGIC_VECTOR(2 downto 0);
        Constante: out STD_LOGIC_VECTOR(7 downto 0)
    );
end Memoria_instrucoes;

architecture Behavioral of Memoria_instrucoes is
    type mem_array is array (0 to 255) of STD_LOGIC_VECTOR(18 downto 0);
    signal memoria : mem_array := (others => (others => '0'));
begin
    process(Endereco)
    begin
        opcode    <= memoria(conv_integer(Endereco))(18 downto 14);
        SEL_REG1  <= memoria(conv_integer(Endereco))(13 downto 11);
        SEL_REG2  <= memoria(conv_integer(Endereco))(10 downto 8);
        Constante <= memoria(conv_integer(Endereco))(7 downto 0);
    end process;
end Behavioral;