library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Memoria_instrucoes is
    Port (
        Endereco : in STD_LOGIC_VECTOR(7 downto 0);
        opcode   : out STD_LOGIC_VECTOR(4 downto 0);
        SEL_REG1 : out STD_LOGIC_VECTOR(2 downto 0);
        SEL_REG2 : out STD_LOGIC_VECTOR(2 downto 0);
        Constante: out STD_LOGIC_VECTOR(7 downto 0)
    );
end Memoria_instrucoes;

architecture Behavioral of Memoria_instrucoes is
    type mem_array is array (0 to 255) of STD_LOGIC_VECTOR(18 downto 0);
    signal memoria : mem_array := (
        0 => "00000XXX001XXXXXXXX",
       1 => "00100XXX00100000000",
        2 => "00011XXX10100000000",
        3 => "00011XXX10000000001",
        4 => "01101101001XXXXXXXX",
        5 => "01111XXXXXX00010101",
        6 => "00010XXX01000101010",
        7 => "00011XXX00100000000",
        8 => "01101010001XXXXXXXX",
        9 => "10010XXXXXX00010010",
        10 => "00011XXX01100000000",
        11 => "00011XXX00100000000",
        12 => "00101011001XXXXXXXX",
        13 => "00101011001XXXXXXXX",
        14 => "10100XXX00100100000",
        15 => "00101100001XXXXXXXX",
        16 => "00001XXX001XXXXXXXX",
        17 => "10011XXXXXX00010001",
        18 => "00011XXX00100000000",
        19 => "00110010001XXXXXXXX",
        20 => "10011XXXXXX00100000",
        21 => "00011XXX00100000000",
        22 => "00010XXX01111111111",
        23 => "01011011001XXXXXXXX",
        others => "0000000000000000000"
    );
begin
    process(Endereco)
        variable addr_int : integer;
    begin
        if (Endereco'length /= 8) or (Endereco = "UUUUUUUU") then
            opcode    <= "00000";
            SEL_REG2  <= "000";
            SEL_REG1  <= "000";
            Constante <= "00000000";
        else
            addr_int := to_integer(unsigned(Endereco));

            if addr_int < 0 or addr_int > 255 then
                opcode    <= "00000";
                SEL_REG1  <= "000";
                SEL_REG2  <= "000";
                Constante <= "00000000";
            else
                opcode    <= memoria(addr_int)(18 downto 14);
                SEL_REG2  <= memoria(addr_int)(13 downto 11);
                SEL_REG1  <= memoria(addr_int)(10 downto 8);
                Constante <= memoria(addr_int)(7 downto 0);
            end if;
        end if;
    end process;
end Behavioral;
