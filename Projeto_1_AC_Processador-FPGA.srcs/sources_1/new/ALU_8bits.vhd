library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_8bits is
    Port ( a    : in  STD_LOGIC_VECTOR (7 downto 0);
           b    : in  STD_LOGIC_VECTOR (7 downto 0);
           op   : in  STD_LOGIC_VECTOR (3 downto 0);
           cin  : in  STD_LOGIC;  
           res  : out STD_LOGIC_VECTOR (7 downto 0);
           cout : out STD_LOGIC);
end ALU_8bits;

architecture Structural of ALU_8bits is

    component ALU 
        Port ( a    : in  STD_LOGIC;
               b    : in  STD_LOGIC;
               op   : in  STD_LOGIC_VECTOR (3 downto 0);
               cin  : in  STD_LOGIC;
               res  : out STD_LOGIC;
               cout : out STD_LOGIC);
    end component;

    signal carry: STD_LOGIC_VECTOR (8 downto 0); 

begin

    carry(0) <= cin; 


    ALU0: ALU port map(a => a(0), b => b(0), op => op, cin => carry(0), res => res(0), cout => carry(1));
    ALU1: ALU port map(a => a(1), b => b(1), op => op, cin => carry(1), res => res(1), cout => carry(2));
    ALU2: ALU port map(a => a(2), b => b(2), op => op, cin => carry(2), res => res(2), cout => carry(3));
    ALU3: ALU port map(a => a(3), b => b(3), op => op, cin => carry(3), res => res(3), cout => carry(4));
    ALU4: ALU port map(a => a(4), b => b(4), op => op, cin => carry(4), res => res(4), cout => carry(5));
    ALU5: ALU port map(a => a(5), b => b(5), op => op, cin => carry(5), res => res(5), cout => carry(6));
    ALU6: ALU port map(a => a(6), b => b(6), op => op, cin => carry(6), res => res(6), cout => carry(7));
    ALU7: ALU port map(a => a(7), b => b(7), op => op, cin => carry(7), res => res(7), cout => carry(8));

    cout <= carry(8);

end Structural;
