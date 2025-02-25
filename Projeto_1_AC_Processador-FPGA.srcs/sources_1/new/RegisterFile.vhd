library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterFile is
Port( 
    clk, WE : in std_logic;
    bitSel : in std_logic_vector(2 downto 0);
    data : in std_logic_vector(7 downto 0);
    dataOut : out std_logic_vector(7 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    component Register_8bit
    port(clk, WE : std_logic; data : in std_logic_vector(7 downto 0); dataOut : out std_logic_vector(7 downto 0));
    end component;

    signal R0, R1, R2, R3, R4, R5 : std_logic_vector(7 downto 0);
    signal WE_R0, WE_R1, WE_R2, WE_R3, WE_R4, WE_R5 : std_logic;
begin

    REG0 : Register_8bit port map(clk, We_R0, data, R0);
    REG1 : Register_8bit port map(clk, We_R1, data, R1);
    REG2 : Register_8bit port map(clk, We_R2, data, R2);
    REG3 : Register_8bit port map(clk, We_R3, data, R3);
    REG4 : Register_8bit port map(clk, We_R4, data, R4);
    REG5 : Register_8bit port map(clk, We_R5, data, R5);

    process(clk)
    begin
        if rising_edge(clk) then
            WE_R0 <= '0';
            WE_R1 <= '0';
            WE_R2 <= '0';
            WE_R3 <= '0';
            WE_R4 <= '0';
            WE_R5 <= '0';
            if WE = '1' then
                case bitSel is
                    when "000" => WE_R0 <= '1';
                    when "001" => WE_R1 <= '1';
                    when "010" => WE_R2 <= '1';
                    when "011" => WE_R3 <= '1';
                    when "100" => WE_R4 <= '1';
                    when "101" => WE_R5 <= '1';
                    when others => null;
                end case;
            end if ;
        end if ;
    end process;

    with bitSel select
        dataOut <=  R0 when "000",
                    R0 when "001",
                    R0 when "010",
                    R0 when "011",
                    R0 when "100",
                    R0 when "101",
                    (others => '0') when others;
end Behavioral;
