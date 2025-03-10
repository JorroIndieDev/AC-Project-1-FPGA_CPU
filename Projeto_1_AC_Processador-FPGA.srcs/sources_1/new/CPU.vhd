library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
Port (
	PIN : in std_logic_vector(7 downto 0);
	reset, clk : in std_logic;
	POUT : out std_logic_vector(7 downto 0)
 );
end CPU;

architecture Structural of CPU is


	------------------------------------------------------- PC
	component Program_Counter
		Port (
			CLK : in  STD_LOGIC;  
			RESET : in  STD_LOGIC;  
			ESCR_PC : in  STD_LOGIC;  
			CONSTANTE: in  STD_LOGIC_VECTOR(7 downto 0);  
			ENDERECO: out STD_LOGIC_VECTOR(7 downto 0)  
		);
	end component;

	------------------------------------------------------- MUX_PC
	component MUX_PC
		Port (
			S_FLAG, ONE, ZERO : in std_logic;
			SEL_PC : in std_logic_vector(2 downto 0);
			Operando1 : in std_logic_vector(7 downto 0);
			ESCR_PC : out std_logic
		);
	end component;

	------------------------------------------------------- Flag_Register
	component Flag_Register
		Port (
			CLK : in std_logic;
			ESCR_F : in std_logic;
			SEL_F : in std_logic_vector(2 downto 0);
			COMP_FLAG : in std_logic_vector(4 downto 0);
			S_FLAG : out std_logic
		);
	end component;

	------------------------------------------------------- ALU_8bits
	component ALU_8bits
		Port (
			A : in  STD_LOGIC_VECTOR(7 downto 0);  
			B : in  STD_LOGIC_VECTOR(7 downto 0);  
			Sel : in  STD_LOGIC_VECTOR(3 downto 0);  
			Result : out STD_LOGIC_VECTOR(7 downto 0);  
			COMP_FLAG: out STD_LOGIC_VECTOR(4 downto 0)   
		);
	end component;

	------------------------------------------------------- Register_File
	component Register_File
		Port( 
			clk, WE : in std_logic;
			SEL_REG1, SEL_REG2 : in std_logic_vector(2 downto 0);
			data : in std_logic_vector(7 downto 0);
			Operando1, Operando2 : out std_logic_vector(7 downto 0)
			);
	end component;

	------------------------------------------------------- MUX_R
	component MUX_R
		Port (
			SEL_R : in std_logic_vector(1 downto 0);
			Dados_M, Dados_IN, Resultado, Constante : in std_logic_vector(7 downto 0);
			Dados_R : out std_logic_vector(7 downto 0)
		);
	end component;

	------------------------------------------------------- Peripheral_Manager
	component Peripheral_Manager
		Port (  
			P_in, operando1: in std_logic_vector(7 downto 0); 
			ESCR_P, clk: in std_logic;
			P_out, Dados_IN : out std_logic_vector(7 downto 0)
		);
	end component;

	------------------------------------------------------- Memoria_dados
	component Memoria_dados
		Port (
			CLK : in STD_LOGIC;
			WR : in STD_LOGIC;
			constante : in STD_LOGIC_VECTOR(7 downto 0);
			Operando1 : in STD_LOGIC_VECTOR(7 downto 0);
			Dados_M  : out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;

	------------------------------------------------------- Memoria_instrucoes
	component Memoria_instrucoes
		Port (
			Endereco : in STD_LOGIC_VECTOR(7 downto 0);
			opcode: out STD_LOGIC_VECTOR(4 downto 0);
			SEL_REG1 : out STD_LOGIC_VECTOR(2 downto 0);
			SEL_REG2 : out STD_LOGIC_VECTOR(2 downto 0);
			Constante: out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;

	------------------------------------------------------- ROM_decoder
	component ROM_decoder
		Port (
			Opcode : in std_logic_vector(4 downto 0);
			SEL_ALU : out std_logic_vector(3 downto 0);
			SEL_PC, SEL_F : out std_logic_vector(2 downto 0);
			SEL_R : out std_logic_vector(1 downto 0);
			ESCR_R, ESCR_P, ESCR_F, WR: out std_logic
		);
	end component;


	-- Signals
	signal ENDERECO, CONSTANTE, OPERANDO1, OPERANDO2, RESULTADO_ALU, Dados_R, Dados_M, Dados_IN : std_logic_vector(7 downto 0) := (others => '0');
	signal COMP_FLAG : std_logic_vector(4 downto 0) := (others => '0');
	signal S_FLAG, ESCR_PC, ESCR_F, ESCR_R, ESCR_P, WR : std_logic := '0';
	signal SEL_PC, SEL_F : std_logic_vector(2 downto 0) := (others => '0');
	signal SEL_ALU : std_logic_vector(3 downto 0) := (others => '0');
	signal SEL_R : std_logic_vector(1 downto 0) := (others => '0');
	signal SEL_REG1, SEL_REG2 : std_logic_vector(2 downto 0) := (others => '0');
	signal Opcode : std_logic_vector(4 downto 0) := (others => '0');

	
	begin
	

		---------- 2.6 Program Counter
		PC : Program_Counter
		port map (
			CLK       => clk,
			RESET     => reset,
			ESCR_PC   => ESCR_PC,
			CONSTANTE => CONSTANTE,
			ENDERECO  => ENDERECO
		);

		---------- 2.8 Instruction Memory
		InstMemory : Memoria_instrucoes
			port map (
				Endereco   => ENDERECO,
				opcode     => Opcode,
				SEL_REG1   => SEL_REG1,
				SEL_REG2   => SEL_REG2,
				Constante  => CONSTANTE
			);

		---------- 2.10 ROM Decoder
		Decoder : ROM_decoder
			port map (
				Opcode  => Opcode,
				SEL_ALU => SEL_ALU,
				SEL_PC  => SEL_PC,
				SEL_F   => SEL_F,
				SEL_R   => SEL_R,
				ESCR_R  => ESCR_R,
				ESCR_P  => ESCR_P,
				ESCR_F  => ESCR_F,
				WR      => WR
			);

		---------- 2.7 MUX_PC
		MuxPC : MUX_PC
		port map (
			S_FLAG    => S_FLAG,
			ONE       => '1',
			ZERO      => '0',
			SEL_PC    => SEL_PC,
			Operando1 => OPERANDO1,
			ESCR_PC   => ESCR_PC
		);

		---------- 2.2 MUX_R
		MuxALU : MUX_R
		port map (
			SEL_R     => SEL_R,
			Dados_M   => Dados_M,
			Dados_IN  => Dados_IN,  -- External input
			Resultado => RESULTADO_ALU,
			Constante => CONSTANTE,
			Dados_R   => Dados_R
		);


		---------- 2.3 Register File
		RegFile : Register_File
		port map (
			clk      => clk,
			WE       => ESCR_R,
			SEL_REG1 => SEL_REG1,
			SEL_REG2 => SEL_REG2,
			data     => Dados_r,
			Operando1 => OPERANDO1,
			Operando2 => OPERANDO2
		);


		---------- 2.4 ALU
		ALU : ALU_8bits
		port map (
			A         => OPERANDO1,
			B         => OPERANDO2,
			Sel       => SEL_ALU,
			Result    => RESULTADO_ALU,
			COMP_FLAG => COMP_FLAG
		);

		---------- 2.1 Peripheral Manager
		PeripheralManager : Peripheral_Manager
		port map (
			P_in      => PIN,
			operando1 => OPERANDO1,
			ESCR_P    => ESCR_P,
			clk       => clk,
			P_out     => POUT,
			Dados_IN  => Dados_IN
		);

		---------- 2.9 Memory Data
		DataMemory : Memoria_dados
		port map (
			CLK        => clk,
			WR         => WR,
			constante  => CONSTANTE,
			Operando1  => OPERANDO1,
			Dados_M    => Dados_M
		);

		---------- 2.5 Flag Register
		Flags : Flag_Register
		port map (
			CLK       => clk,
			ESCR_F    => ESCR_F,
			SEL_F     => SEL_F,
			COMP_FLAG => COMP_FLAG,
			S_FLAG    => S_FLAG
		);




end Structural;
	
