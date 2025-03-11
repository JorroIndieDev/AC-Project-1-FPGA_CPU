library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MB_TestBench is
end MB_TestBench;

architecture testbench of MB_TestBench is
	
	component MotherBoard
	Port (
		clk, WR : in std_logic;
		opcode_out : out std_logic_vector(4 downto 0);
		SEL_REG1, SEL_REG2 : out std_logic_vector(2 downto 0); --
		Dados_M : out std_logic_vector(7 downto 0);
		Operando1, Endereco: in std_logic_vector(7 downto 0)
	);
	end component;

	component CPU
	Port (
        -- CPU
        PIN : in std_logic_vector(7 downto 0); --
        reset, clk : in std_logic; --
        POUT : out std_logic_vector(7 downto 0); --
        -- inputs from MB
        Dados_M, Constante : in std_logic_vector(7 downto 0); --
        SEL_REG1, SEL_REG2 : in std_logic_vector(2 downto 0); --
        Opcode : in std_logic_vector(4 downto 0); --
        -- outputs from MB
        Operando1_out, Endereco : out std_logic_vector(7 downto 0); --
        WR : out std_logic --
    );
	end component;

	signal PIN_tb, POUT_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal Dados_M, Constante, Operando1, Endereco : std_logic_vector(7 downto 0);
	signal clk_tb, reset_tb  : std_logic := '0';
	signal WR: std_logic;
	signal SEL_REG1, SEL_REG2 : std_logic_vector(2 downto 0);
	signal opcode : std_logic_vector(4 downto 0);

	-- Clock period
	constant clk_period : time := 10 ns;

begin

	-- Instantiate the CPU
	UUT: MotherBoard
		port map (
			clk => clk_tb,
			WR => WR,
			opcode_out => opcode,
			SEL_REG1 => SEL_REG1,
			SEL_REG2 => SEL_REG2,
			Dados_M => Dados_M,
			Operando1 => Operando1,
			Endereco => Endereco
		);
	UUT_CPU : CPU
		port map (
			PIN => PIN_tb,
			reset => reset_tb,
			clk => clk_tb,
			POUT => Pout_tb,
			Dados_M => Dados_M,
			Constante => Constante,
			SEL_REG1 => SEL_REG1,
			SEL_REG2 => SEL_REG2,
			Opcode => opcode,
			Operando1_out => Operando1,
			Endereco => Endereco,
			WR => WR
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
		PIN_tb <= "00001010";  -- Example: Load value 10
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
