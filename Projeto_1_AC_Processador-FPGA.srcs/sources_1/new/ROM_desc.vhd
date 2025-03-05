
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ROM_desc is
    Port (
        opcode : in STD_LOGIC_VECTOR(4 downto 0);
        SEL_ALU : out STD_LOGIC_VECTOR(3 downto 0);
        ESCR_P : out STD_LOGIC;
        SEL_R : out STD_LOGIC_VECTOR(1 downto 0);
        ESCR_R : out STD_LOGIC;
        WR : out STD_LOGIC;
        SEL_PC : out STD_LOGIC_VECTOR(2 downto 0);
        ESCR_F : out STD_LOGIC;
        SEL_F : out STD_LOGIC_VECTOR(2 downto 0)
    );
end ROM_desc;

architecture Behavioral of ROM_desc is
begin
    process(opcode)
    begin
        case opcode is
            when "00000" => SEL_ALU <= "XXXX"; ESCR_P <= '0'; SEL_R <= "01"; ESCR_R <= '0'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";  
            when "00001" => SEL_ALU <= "XXXX"; ESCR_P <= '0'; SEL_R <= "XX"; ESCR_R <= '0'; WR <= '1'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";
            when "00010" => SEL_ALU <= "XXXX"; ESCR_P <= '0'; SEL_R <= "10"; ESCR_R <= '1'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX"; 
            when "00011" => SEL_ALU <= "XXXX"; ESCR_P <= '0'; SEL_R <= "10"; ESCR_R <= '1'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";
            when "00100" => SEL_ALU <= "XXXX"; ESCR_P <= '0'; SEL_R <= "00"; ESCR_R <= '0'; WR <= '1'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";  
            when "00101" => SEL_ALU <= "0000"; ESCR_P <= '0'; SEL_R <= "00"; ESCR_R <= '1'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";
            when "00110" => SEL_ALU <= "0001"; ESCR_P <= '0'; SEL_R <= "00"; ESCR_R <= '1'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";
            when "00111" => SEL_ALU <= "0010"; ESCR_P <= '0'; SEL_R <= "00"; ESCR_R <= '1'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX"; 
            when "01000" => SEL_ALU <= "0011"; ESCR_P <= '0'; SEL_R <= "00"; ESCR_R <= '1'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";  
            when "01001" => SEL_ALU <= "0100"; ESCR_P <= '0'; SEL_R <= "00"; ESCR_R <= '1'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";
            when "01010" => SEL_ALU <= "0101"; ESCR_P <= '0'; SEL_R <= "00"; ESCR_R <= '1'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";
            when "01011" => SEL_ALU <= "0110"; ESCR_P <= '0'; SEL_R <= "00"; ESCR_R <= '1'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";
            when "01100" => SEL_ALU <= "0111"; ESCR_P <= '0'; SEL_R <= "00"; ESCR_R <= '1'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";
            when others => SEL_ALU <= "XXXX"; ESCR_P <= '0'; SEL_R <= "XX"; ESCR_R <= '0'; WR <= '0'; SEL_PC <= "000"; ESCR_F <= '0'; SEL_F <= "XXX";
        end case;
    end process;
end Behavioral;
