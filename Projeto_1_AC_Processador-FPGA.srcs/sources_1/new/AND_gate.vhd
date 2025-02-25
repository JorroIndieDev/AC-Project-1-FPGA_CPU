library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_gate is
Port (
    a,b : in std_logic;
     y : out std_logic);
end AND_gate;

architecture DataFlow of AND_gate is
begin
    y <= a AND b;
end DataFlow;
