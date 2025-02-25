library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_8bit is
port (
        clk, WE: in std_logic; -- clock / Wrte enable
        data : in std_logic_vector (7 downto 0) ; -- data in "D"
        dataOut : out std_logic_vector (7 downto 0) -- data out / Read "Q"
    );
end;

architecture Behavioural of Register_8bit is

    signal reg : std_logic_vector(7 downto 0) := (others => '0');

begin

    process (clk)
    begin
        if rising_edge(clk)and WE = '1' then
            reg <= data;
        end if;
    end process;

end Behavioural;