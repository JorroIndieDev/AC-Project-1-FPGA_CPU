library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_MB is
    Port (
        CLK, RESET : in STD_LOGIC;
        PIN : in STD_LOGIC_VECTOR(7 downto 0);
        POUT : out STD_LOGIC_VECTOR(7 downto 0)
    );
end CPU_MB;

architecture Structural of CPU_MB is
	
	component MotherBoard
	Port (
		clk, WR : in std_logic;
		opcode_out : out std_logic_vector(4 downto 0);
		SEL_REG1, SEL_REG2 : out std_logic_vector(2 downto 0); --
		Dados_M, constante: out std_logic_vector(7 downto 0);
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

	signal Dados_M, Constante, Operando1, Endereco : std_logic_vector(7 downto 0);
	signal WR: std_logic;
	signal SEL_REG1, SEL_REG2 : std_logic_vector(2 downto 0);
	signal opcode : std_logic_vector(4 downto 0);

	-- Clock period
	constant clk_period : time := 10 ns;

begin

	-- Instantiate the CPU
	UUT: MotherBoard
		port map (
			clk => clk,
			WR => WR,
			opcode_out => opcode,
			SEL_REG1 => SEL_REG1,
			SEL_REG2 => SEL_REG2,
			Dados_M => Dados_M,
			constante => Constante,
			Operando1 => Operando1,
			Endereco => Endereco
		);
	UUT_CPU : CPU
		port map (
			PIN => PIN,
			reset => reset,
			clk => clk,
			POUT => Pout,
			Dados_M => Dados_M,
			Constante => Constante,
			SEL_REG1 => SEL_REG1,
			SEL_REG2 => SEL_REG2,
			Opcode => opcode,
			Operando1_out => Operando1,
			Endereco => Endereco,
			WR => WR
		);	
end Structural;