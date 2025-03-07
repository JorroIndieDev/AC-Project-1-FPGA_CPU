library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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
	signal memoria : mem_array := (others => "0000000000000000000");
begin
	process(Endereco)
	variable addr_int : integer;
begin
	if (Endereco'length /= 8) or (Endereco = "UUUUUUUU") then
		opcode    <= "00000";
		SEL_REG1  <= "000";
		SEL_REG2  <= "000";
		Constante <= "00000000";
		report "ERROR: Endereco is uninitialized or invalid!" severity warning;
	else
		addr_int := to_integer(unsigned(Endereco));

		-- Ensure address is within valid range (0-255)
		if addr_int < 0 or addr_int > 255 then
			opcode    <= "00000";
			SEL_REG1  <= "000";
			SEL_REG2  <= "000";
			Constante <= "00000000";
			report "ERROR: Endereco out of bounds!" severity warning;
		else
			opcode    <= memoria(addr_int)(18 downto 14);
			SEL_REG1  <= memoria(addr_int)(13 downto 11);
			SEL_REG2  <= memoria(addr_int)(10 downto 8);
			Constante <= memoria(addr_int)(7 downto 0);
		end if;
	end if;
end process;

end Behavioral;