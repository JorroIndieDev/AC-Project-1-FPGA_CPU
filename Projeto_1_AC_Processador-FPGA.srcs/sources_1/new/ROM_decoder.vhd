library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROM_decoder is
	Port (
		Opcode : in std_logic_vector(4 downto 0);
		SEL_ALU : out std_logic_vector(3 downto 0);
		SEL_PC, SEL_F : out std_logic_vector(2 downto 0);
		SEL_R : out std_logic_vector(1 downto 0);
		ESCR_R, ESCR_P, ESCR_F, WR: out std_logic
	);
end ROM_decoder;

architecture Behavioral of ROM_decoder is
begin
	process(Opcode)
	begin
		SEL_ALU <= "XXXX";
		SEL_PC  <= "000";
		SEL_F   <= "XXX";
		SEL_R   <= "XX";
		ESCR_R  <= '0';
		ESCR_P  <= '0';
		ESCR_F  <= '0';
		WR      <= '0';

		case Opcode is
			----------------------  Peripherals
			-- LDP Ri
			when "00000" => SEL_ALU <= "XXXX"; ESCR_P <= '0'; SEL_R <= "01"; ESCR_R <= '1';
			-- STP Ri
			when "00001" => SEL_ALU <= "XXXX"; ESCR_P <= '1'; SEL_R <= "XX"; ESCR_R <= '0';

			----------------------  Read / Write
			-- LD Ri, C
			when "00010" => SEL_ALU <= "XXXX"; SEL_R <= "11"; ESCR_R <= '1';
			-- LD Ri, [C]
			when "00011" => SEL_ALU <= "XXXX"; SEL_R <= "10"; ESCR_R <= '1';
			-- ST [C], Ri
			when "00100" => SEL_ALU <= "XXXX"; SEL_R <= "XX"; ESCR_R <= '0'; WR <= '1';

			----------------------  Arithmetic and Logic
			-- ADD Ri, Rj
			when "00101" => SEL_ALU <= "0000"; SEL_R <= "00"; ESCR_R <= '1';
			-- SUB Ri, Rj
			when "00110" => SEL_ALU <= "0001"; SEL_R <= "00"; ESCR_R <= '1';
			-- AND Ri, Rj
			when "00111" => SEL_ALU <= "0010"; SEL_R <= "00"; ESCR_R <= '1';
			-- NAND Ri, Rj
			when "01000" => SEL_ALU <= "0011"; SEL_R <= "00"; ESCR_R <= '1';
			-- OR Ri, Rj
			when "01001" => SEL_ALU <= "0100"; SEL_R <= "00"; ESCR_R <= '1';
			-- NOR Ri, Rj
			when "01010" => SEL_ALU <= "0101"; SEL_R <= "00"; ESCR_R <= '1';
			-- XOR Ri, Rj
			when "01011" => SEL_ALU <= "0110"; SEL_R <= "00"; ESCR_R <= '1';
			-- XNOR Ri, Rj
			when "01100" => SEL_ALU <= "0111"; SEL_R <= "00"; ESCR_R <= '1';
			-- CMP Ri, Rj
			when "01101" => SEL_ALU <= "1000"; SEL_R <= "XX"; ESCR_F <= '1';

			----------------------  Jump
			-- JE C
			when "01110" => SEL_PC <= "010"; SEL_F <= "010";
			-- JL C
			when "01111" => SEL_PC <= "010"; SEL_F <= "000";
			-- JLE C
			when "10000" => SEL_PC <= "010"; SEL_F <= "001";
			-- JGE C
			when "10001" => SEL_PC <= "010"; SEL_F <= "011";
			-- JG C
			when "10010" => SEL_PC <= "010"; SEL_F <= "100";
			-- JMP C
			when "10011" => SEL_PC <= "001";
			-- JZ Ri, C
			when "10100" => SEL_PC <= "011";
			-- JN Ri, C
			when "10101" => SEL_PC <= "100";

			when others => null;

		end case;
	end process;

end Behavioral;
