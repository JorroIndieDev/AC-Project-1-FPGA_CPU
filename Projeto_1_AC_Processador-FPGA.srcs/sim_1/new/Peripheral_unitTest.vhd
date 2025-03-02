library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Peripheral_Manager_tb is
end Peripheral_Manager_tb;

architecture testbench of Peripheral_Manager_tb is

    -- Component declaration
    component Peripheral_Manager
        Port ( 
            P_in, operando1: in std_logic_vector(7 downto 0);
            ESCR_P, clk: in std_logic;
            P_out, Dados_IN : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals to connect to the Peripheral_Manager
    signal P_in, operando1, P_out, Dados_IN: std_logic_vector(7 downto 0);
    signal ESCR_P, clk: std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Peripheral_Manager
    uut: Peripheral_Manager
        port map (
            P_in => P_in,
            operando1 => operando1,
            ESCR_P => ESCR_P,
            clk => clk,
            P_out => P_out,
            Dados_IN => Dados_IN
        );

    -- Clock process
    process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    process
    begin
        -- Initialize Inputs
        P_in <= (others => '0');
        operando1 <= (others => '0');
        ESCR_P <= '0';
        wait for 20 ns;

        -- Test 1: ESCR_P = 0, should read from P_in into Dados_IN
        P_in <= "10101010"; -- Example input
        ESCR_P <= '0';
        wait for clk_period;
        assert Dados_IN = "10101010" report "Test 1 failed: Dados_IN is incorrect" severity error;

        -- Test 2: ESCR_P = 1, should write operando1 to P_out
        operando1 <= "11001100";
        ESCR_P <= '1';
        wait for clk_period;
        assert P_out = "11001100" report "Test 2 failed: P_out is incorrect" severity error;

        -- Test 3: Change P_in but ESCR_P still '1', should NOT affect Dados_IN
        P_in <= "11110000";
        wait for clk_period;
        assert Dados_IN /= "11110000" report "Test 3 failed: Dados_IN incorrectly updated" severity error;

        -- Test 4: Change operando1 and toggle ESCR_P back to '1'
        operando1 <= "00001111";
        wait for clk_period;
        assert P_out = "00001111" report "Test 4 failed: P_out did not update correctly" severity error;

        -- End simulation
        report "Testbench completed successfully!";
        wait;
    end process;

end testbench;