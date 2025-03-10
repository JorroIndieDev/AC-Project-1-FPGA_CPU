library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_TestBench is
end CPU_TestBench;

architecture testbench of CPU_TestBench is
	
	component CPU
		Port (
			PIN : in std_logic_vector(7 downto 0);
			reset, clk : in std_logic;
			POUT : out std_logic_vector(7 downto 0)
		);
	end component;

	signal PIN_tb  : std_logic_vector(7 downto 0) := (others => '0');
	signal POUT_tb : std_logic_vector(7 downto 0);
	signal clk_tb  : std_logic := '0';
	signal reset_tb : std_logic := '0';

	-- Clock period
	constant clk_period : time := 10 ns;

begin

	-- Instantiate the CPU
	UUT: CPU
		port map (
			PIN   => PIN_tb,
			reset => reset_tb,
			clk   => clk_tb,
			POUT  => POUT_tb
		);

	-- Clock process
	process
	begin
		clk_tb <= '0';
		wait for clk_period / 2;
		clk_tb <= '1';
		wait for clk_period / 2;
	end process;

	-- Test process
	process
	begin
	
		-- Load a value into the CPU via PIN
		PIN_tb <= "00001010";  -- Example: Load value 10
		wait for clk_period * 2; 

		-- Let the CPU run for a few cycles
		wait for clk_period * 20;

		-- Check if output matches expected value
		assert POUT_tb = "00001010" 
		report "Test failed: POUT does not match expected value."
		severity error;

		-- End simulation
		report "Test completed successfully!";
		wait;
	end process;

end testbench;
