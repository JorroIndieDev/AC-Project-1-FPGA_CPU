----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.02.2025 11:45:40
-- Design Name: 
-- Module Name: Comparador8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Comparador de 8 bits com saída de 6 bits.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Biblioteca necessária para operações com números

entity Comparador8 is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           s : out STD_LOGIC_VECTOR (4 downto 0));
end Comparador8;

architecture Behavioral of Comparador8 is
begin
    process(a, b)
    begin
        if (unsigned(a) < unsigned(b)) then 
            s(0) <= '1';
            s(1) <= '1';
            s(2) <= '0';
            s(3) <= '0';
            s(4) <= '0';
        elsif (unsigned(a) = unsigned(b)) then
            s(0) <= '0';
            s(1) <= '1';
            s(2) <= '1';
            s(3) <= '1';
            s(4) <= '0';
        else
            s(0) <= '0';
            s(1) <= '0';
            s(2) <= '0';
            s(3) <= '1';
            s(4) <= '1';
        end if;
    end process;
end Behavioral;
