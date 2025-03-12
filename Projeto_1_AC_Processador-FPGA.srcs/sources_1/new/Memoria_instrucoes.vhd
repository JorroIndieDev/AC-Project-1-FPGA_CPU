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
		--	   opcode	SEL2	SEL1	Constante
        0  => "00000" & "XXX" & "001" & "XXXXXXXX", -- LDP R1
        1  => "00100" & "XXX" & "001" & "00000000", -- ST[0], R1
        2  => "00010" & "XXX" & "101" & "00000000", -- LD R5, 0
        3  => "00010" & "XXX" & "100" & "00000001", -- LD R4, 1
        4  => "01101" & "101" & "001" & "XXXXXXXX", -- CMP R1, R5
        5  => "01111" & "XXX" & "XXX" & "00010101", -- JL 21
        6  => "00010" & "XXX" & "010" & "00101010", -- LD R2, 42
        7  => "00011" & "XXX" & "001" & "00000000", -- LD R1, [0]
        8  => "01101" & "010" & "001" & "XXXXXXXX", -- CMP R1, R2
        9  => "10010" & "XXX" & "XXX" & "00010010", -- JG 18
        10 => "00011" & "XXX" & "011" & "00000000", -- LD R3, [0]
        11 => "00011" & "XXX" & "001" & "00000000", -- LD R1, [0]
        12 => "00101" & "011" & "001" & "XXXXXXXX", -- ADD R1, R3
        13 => "00101" & "011" & "001" & "XXXXXXXX", -- ADD R1, R3
        14 => "10100" & "XXX" & "001" & "00010000", -- JZ R1, 16
        15 => "00101" & "100" & "001" & "XXXXXXXX", -- ADD R1, R4
        16 => "00001" & "XXX" & "001" & "XXXXXXXX", -- STP R1
        17 => "10011" & "XXX" & "XXX" & "00010001", -- JMP 17
        18 => "00011" & "XXX" & "001" & "00000000", -- LD R1, [0]
        19 => "00110" & "010" & "001" & "XXXXXXXX", -- SUB R1, R2
        20 => "10011" & "XXX" & "XXX" & "00010000", -- JMP 16
        21 => "00011" & "XXX" & "001" & "00000000", -- LD R1, [0]
        22 => "00010" & "XXX" & "011" & "11111111", -- LD R3, -1
        23 => "01011" & "011" & "001" & "XXXXXXXX", -- XOR R1, R3
		24 => "10011" & "XXX" & "XXX" & "00001111", -- JMP 15
        others => "0000000000000000000"
    );
begin
    process(Endereco)
        variable addr_int : integer;
    begin
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
    end process;
end Behavioral;
