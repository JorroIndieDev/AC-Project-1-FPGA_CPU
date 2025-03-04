library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is
    Port (
        A   : in  STD_LOGIC;  
        B   : in  STD_LOGIC;  
        Cin : in  STD_LOGIC; 
        Sub : in  STD_LOGIC;  -- 0 para soma, 1 para subtração
        Sum : out STD_LOGIC; 
        Cout: out STD_LOGIC   
    );
end Full_Adder;

architecture Behavioral of Full_Adder is
begin
    process (A, B, Cin, Sub)
        variable B_xor_Sub : STD_LOGIC; -- B para subtração
    begin
        B_xor_Sub := B XOR Sub;  -- Se Sub=1, faz B negado
        Sum  <= A XOR B_xor_Sub XOR Cin;
        Cout <= (A AND B_xor_Sub) OR (Cin AND (A XOR B_xor_Sub));
        
    end process;
end Behavioral;
