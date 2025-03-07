library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Program_Counter_TB is
end Program_Counter_TB;

architecture testbench of Program_Counter_TB is
    -- Component Declaration
    component Program_Counter
        Port (
            CLK       : in  STD_LOGIC;
            RESET     : in  STD_LOGIC;
            ESCR_PC   : in  STD_LOGIC;
            CONSTANTE : in  STD_LOGIC_VECTOR(7 downto 0);
            ENDERECO  : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals for connecting to the Program Counter
    signal CLK_tb       : STD_LOGIC := '0';
    signal RESET_tb     : STD_LOGIC := '0';
    signal ESCR_PC_tb   : STD_LOGIC := '0';
    signal CONSTANTE_tb : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal ENDERECO_tb  : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock period
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Program Counter
    UUT: Program_Counter
        port map (
            CLK       => CLK_tb,
            RESET     => RESET_tb,
            ESCR_PC   => ESCR_PC_tb,
            CONSTANTE => CONSTANTE_tb,
            ENDERECO  => ENDERECO_tb
        );

    -- Clock process
    process
    begin
        while true loop
            CLK_tb <= '0';
            wait for CLK_PERIOD / 2;
            CLK_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Test process
    process
    begin
        -- Apply reset
        RESET_tb <= '1';
        wait for CLK_PERIOD;
        RESET_tb <= '0';

        -- Normal Increment Test
        wait for CLK_PERIOD * 5;  -- Allow PC to increment normally

        -- Jump Test: Set ESCR_PC and load a new address
        ESCR_PC_tb <= '1';
        CONSTANTE_tb <= "00010100"; -- Jump to address 20 (decimal)
        wait for CLK_PERIOD;
        ESCR_PC_tb <= '0';

        -- Continue incrementing normally
        wait for CLK_PERIOD * 5;

        -- Another Jump Test
        ESCR_PC_tb <= '1';
        CONSTANTE_tb <= "00101000"; -- Jump to address 40 (decimal)
        wait for CLK_PERIOD;
        ESCR_PC_tb <= '0';

        -- Continue incrementing normally
        wait for CLK_PERIOD * 5;

        -- End simulation
        report "Test completed successfully!";
        std.env.stop;
    end process;

end testbench;
