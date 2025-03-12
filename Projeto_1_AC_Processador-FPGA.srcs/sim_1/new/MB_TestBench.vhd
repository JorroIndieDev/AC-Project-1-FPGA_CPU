library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MB_TestBench is
end MB_TestBench;

architecture testbench of MB_TestBench is

	component CPU_MB
		Port (
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			PIN : in STD_LOGIC_VECTOR(7 downto 0);
			POUT : out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;

	signal PIN_tb, POUT_tb : std_logic_vector(7 downto 0);
	signal reset_tb, clk_tb : std_logic;
	-- Clock period
	constant clk_period : time := 10 ns;

begin

	-- Instantiate the CPU
	UUT: CPU_MB
		port map (
			clk => clk_tb,
			reset => reset_tb,
			PIN => PIN_tb,
			POUT => POUT_tb
		);
	
	-- Clock process
	process
	begin
		clk_tb <= '1';
		wait for clk_period / 2;
		clk_tb <= '0';
		wait for clk_period / 2;
	end process;

	-- Test process
	process
	begin
	
		-- Load a value into the CPU via PIN
		PIN_tb <= "11110100";  -- Example: Load value 10
        reset_tb <= '1';
        wait for clk_period * 2;
        reset_tb <= '0';
        wait for clk_period * 2;

		-- Let the CPU run for a few cycles
		wait for clk_period * 20;

        
		-- End simulation
		wait;
	end process;

end testbench;
