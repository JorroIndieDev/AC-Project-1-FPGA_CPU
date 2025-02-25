----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2025 13:48:34
-- Design Name: 
-- Module Name: MUX8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX8 is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           c : in STD_LOGIC_VECTOR (7 downto 0);
           d : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           res : out STD_LOGIC_VECTOR (7 downto 0));
end MUX8;

architecture Behavioral of MUX8 is

begin
    process(a,b,c,d,sel)
        begin
        case sel is
            when "00" => res <= a;
            when "01" => res <= b;
            when "10" => res <= c;
            when "11" => res <= d;
            when others => res <= (others => '0');
        end case;
    end process;
    

end Behavioral;
