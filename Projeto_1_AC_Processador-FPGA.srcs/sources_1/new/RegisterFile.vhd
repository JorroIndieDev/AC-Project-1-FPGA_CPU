library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterFile is
Port( 
    clk, WE : in std_logic;
    SEL_REG1, SEL_REG2 : in std_logic_vector(2 downto 0);
    data : in std_logic_vector(7 downto 0);
    Operando1, Operando2 : out std_logic_vector(7 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    component Register_8bit
    port(clk, WE : std_logic; data : in std_logic_vector(7 downto 0); dataOut : out std_logic_vector(7 downto 0));
    end component;

    signal R0, R1, R2, R3, R4, R5 : std_logic_vector(7 downto 0);
    signal WE_R0, WE_R1, WE_R2, WE_R3, WE_R4, WE_R5 : std_logic;
begin

    REG0 : Register_8bit port map(clk => clk, WE => We_R0, data => data, dataOut => R0);
    REG1 : Register_8bit port map(clk => clk, WE => We_R1, data => data, dataOut => R1);
    REG2 : Register_8bit port map(clk => clk, WE => We_R2, data => data, dataOut => R2);
    REG3 : Register_8bit port map(clk => clk, WE => We_R3, data => data, dataOut => R3);
    REG4 : Register_8bit port map(clk => clk, WE => We_R4, data => data, dataOut => R4);
    REG5 : Register_8bit port map(clk => clk, WE => We_R5, data => data, dataOut => R5);

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
                case SEL_REG1 is
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

    with SEL_REG1 select
        Operando1 <= R0 when "000",
                    R1 when "001",
                    R2 when "010",
                    R3 when "011",
                    R4 when "100",
                    R5 when "101",
                    (others => '0') when others;

    with SEL_REG2 select
        Operando2 <= R0 when "000",
                    R1 when "001",
                    R2 when "010",
                    R3 when "011",
                    R4 when "100",
                    R5 when "101",
                    (others => '0') when others;
end Behavioral;
