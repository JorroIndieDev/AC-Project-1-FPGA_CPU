library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_8bits is
    Port (
        A : in  STD_LOGIC_VECTOR(7 downto 0);  
        B : in  STD_LOGIC_VECTOR(7 downto 0);  
        Sel : in  STD_LOGIC_VECTOR(3 downto 0);  
        Result : out STD_LOGIC_VECTOR(7 downto 0);  
        COMP_FLAG: out STD_LOGIC_VECTOR(4 downto 0)   
    );
end ALU_8bits;

architecture Behavioral of ALU_8bits is
    signal Carry : STD_LOGIC_VECTOR(8 downto 0); 
    signal Temp_Result : STD_LOGIC_VECTOR(7 downto 0); 
begin
    Carry(0) <= Sel(0); -- Se Sel(0) = 1, faz sub com carry = 1

    -- ALU bit operations
    ALU_Bit0: entity work.ALU port map (A(0), B(0), Carry(0), Sel, Temp_Result(0), Carry(1));
    ALU_Bit1: entity work.ALU port map (A(1), B(1), Carry(1), Sel, Temp_Result(1), Carry(2));
    ALU_Bit2: entity work.ALU port map (A(2), B(2), Carry(2), Sel, Temp_Result(2), Carry(3));
    ALU_Bit3: entity work.ALU port map (A(3), B(3), Carry(3), Sel, Temp_Result(3), Carry(4));
    ALU_Bit4: entity work.ALU port map (A(4), B(4), Carry(4), Sel, Temp_Result(4), Carry(5));
    ALU_Bit5: entity work.ALU port map (A(5), B(5), Carry(5), Sel, Temp_Result(5), Carry(6));
    ALU_Bit6: entity work.ALU port map (A(6), B(6), Carry(6), Sel, Temp_Result(6), Carry(7));
    ALU_Bit7: entity work.ALU port map (A(7), B(7), Carry(7), Sel, Temp_Result(7), Carry(8));

    process(A, B)
    begin
        
        COMP_FLAG(0) <= '0';  
        COMP_FLAG(1) <= '0';  
        COMP_FLAG(2) <= '0';  
        COMP_FLAG(3) <= '0';  
        COMP_FLAG(4) <= '0';  

        if (A = B) then
            COMP_FLAG(1) <= '1';
            COMP_FLAG(2) <= '1';  
            COMP_FLAG(3) <= '1';  
        elsif (A < B) then
            COMP_FLAG(0) <= '1';  
            COMP_FLAG(1) <= '1';  
        else
            COMP_FLAG(3) <= '1'; 
            COMP_FLAG(4) <= '1';  
        end if;
    end process;

    Result <= Temp_Result;  
    
end Behavioral;
