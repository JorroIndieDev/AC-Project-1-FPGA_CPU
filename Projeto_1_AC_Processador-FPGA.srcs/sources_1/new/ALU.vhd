library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  


entity ALU is
    Port (
        A : in  STD_LOGIC;  
        B : in  STD_LOGIC;
        Cin: in  STD_LOGIC;
        Sel : in  STD_LOGIC_VECTOR(3 downto 0); 
        Result : out STD_LOGIC;
        Cout : out STD_LOGIC 
    );
end ALU;

architecture Behavioral of ALU is
    signal Sum, Cout_internal : STD_LOGIC; 
    signal Sub : STD_LOGIC;  
begin

    Adder: entity work.Full_Adder
        port map (
            A => A,
            B => B,
            Cin => Cin,
            Sub => Sub,  
            Sum => Sum,
            Cout => Cout_internal
        );

    process (A, B, Sum, Cout_internal, Sel)
    begin
        if (Sel = "0001" or Sel = "1000") then
            Sub <= '1';  
        else
            Sub <= '0';  
        end if;

        case Sel is
            when "0000" => Result <= Sum;         
            when "0001" => Result <= Sum;            
            when "0010" => Result <= A AND B;     
            when "0011" => Result <= NOT (A AND B); 
            when "0100" => Result <= A OR B;      
            when "0101" => Result <= NOT (A OR B); 
            when "0110" => Result <= A XOR B;     
            when "0111" => Result <= NOT (A XOR B); 
            when "1000" => Result <= Sum;
            when others => Result <= '0'; 
        end case;

        if (Sel = "0000" or Sel = "0001" or Sel = "1000") then
            Cout <= Cout_internal;
        else
            Cout <= '0';
        end if;
    end process;

end Behavioral;
