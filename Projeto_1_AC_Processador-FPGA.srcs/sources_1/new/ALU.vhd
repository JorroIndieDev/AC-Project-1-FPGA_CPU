
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           op : in std_logic_vector(3 downto 0);
           cin : in STD_LOGIC;
           res : out STD_LOGIC;
           cout : out STD_LOGIC);
end ALU;

architecture Structural of ALU is

component Full_Adder Port(a,b,cin : in std_logic;
                          sum, cout : out std_logic);
end component;

signal SumRes, AndRes, NandRes, OrRes, NorRes, XorRes, XnorRes, SubB : STD_LOGIC;
    signal CoutSum : STD_LOGIC; 


begin

    subB <= b xor op(0);
    
    FA: Full_Adder port map (A, SubB, Cin, SumRes, CoutSum);
    
    AndRes <= a and b;
    NandRes <= a nand b;
    OrRes <= a or b;
    NorRes <= a nor b;
    XorRes <= a xor b;
    XnorRes <= a xnor b;

    process (Op, SumRes, AndRes, NandRes, OrRes, NorRes, XorRes, XnorRes)
    begin
        case Op is
            when "0000" => res <= SumRes; --soma
            when "0001" => res <= SumRes; --subtracao
            when "0010" => res <= AndRes;  
            when "0011" => res <= NandRes;   
            when "0100" => res <= OrRes;  
            when "0101" => res <= NorRes;  
            when "0110" => res <= XorRes;  
            when "0111" => res <= XnorRes; 
            when others => res <= '0';     
        end case;
    end process;
    
    Cout <= CoutSum when (Op = "0000" or Op = "0001") else '0';

end Structural;
