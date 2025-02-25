library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XOR_gate is
Port (a,b : in std_logic; y : out std_logic);
end XOR_gate;

architecture DataFlow of XOR_gate is
begin
    y <= a XOR b;
end DataFlow;
