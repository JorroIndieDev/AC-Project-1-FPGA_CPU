library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

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
    signal Temp_Result : SIGNED(7 downto 0); 
    signal A_signed, B_signed: SIGNED(7 downto 0);
begin
    A_signed <= SIGNED(A);
    B_signed <= SIGNED(B);

    Carry(0) <= Sel(0); -- Se Sel(0) = 1, faz sub com carry = 1

    -- ALU bit operations
    ALU_Bit0: entity work.ALU port map (A_signed(0), B_signed(0), Carry(0), Sel, Temp_Result(0), Carry(1));
    ALU_Bit1: entity work.ALU port map (A_signed(1), B_signed(1), Carry(1), Sel, Temp_Result(1), Carry(2));
    ALU_Bit2: entity work.ALU port map (A_signed(2), B_signed(2), Carry(2), Sel, Temp_Result(2), Carry(3));
    ALU_Bit3: entity work.ALU port map (A_signed(3), B_signed(3), Carry(3), Sel, Temp_Result(3), Carry(4));
    ALU_Bit4: entity work.ALU port map (A_signed(4), B_signed(4), Carry(4), Sel, Temp_Result(4), Carry(5));
    ALU_Bit5: entity work.ALU port map (A_signed(5), B_signed(5), Carry(5), Sel, Temp_Result(5), Carry(6));
    ALU_Bit6: entity work.ALU port map (A_signed(6), B_signed(6), Carry(6), Sel, Temp_Result(6), Carry(7));
    ALU_Bit7: entity work.ALU port map (A_signed(7), B_signed(7), Carry(7), Sel, Temp_Result(7), Carry(8));

    process(A_signed, B_signed)
    begin
        COMP_FLAG <= "00000";

        if (A_signed = B_signed) then
            COMP_FLAG(1) <= '1'; -- Igual
            COMP_FLAG(2) <= '1'; -- Menor ou igual
            COMP_FLAG(3) <= '1'; -- Maior ou igual
        elsif (A_signed < B_signed) then
            COMP_FLAG(0) <= '1'; -- A < B
            COMP_FLAG(1) <= '1'; -- A <= B
        else
            COMP_FLAG(3) <= '1'; -- A >= B
            COMP_FLAG(4) <= '1'; -- A > B
        end if;
    end process;

    Result <= STD_LOGIC_VECTOR(Temp_Result);  
    
end Behavioral;