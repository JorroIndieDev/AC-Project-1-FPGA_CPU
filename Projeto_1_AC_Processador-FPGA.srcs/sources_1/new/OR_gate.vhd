library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OR_gate is
Port (a,b : in std_logic; y : out std_logic);
end OR_gate;

architecture DataFlow of OR_gate is
begin
    y <= a OR b;
end DataFlow;
