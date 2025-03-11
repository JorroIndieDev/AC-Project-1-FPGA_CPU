library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MotherBoard is
 Port (
    clk, WR : in std_logic;
    opcode_out : out std_logic_vector(4 downto 0);
    SEL_REG1, SEL_REG2 : out std_logic_vector(2 downto 0); --
    Dados_M, constante: out std_logic_vector(7 downto 0);
    Operando1, Endereco : in std_logic_vector(7 downto 0)
    );
end MotherBoard;

architecture structural of MotherBoard is

    component Memoria_instrucoes
        Port (
            Endereco : in STD_LOGIC_VECTOR(7 downto 0);
            opcode   : out STD_LOGIC_VECTOR(4 downto 0); --
            SEL_REG1 : out STD_LOGIC_VECTOR(2 downto 0); --
            SEL_REG2 : out STD_LOGIC_VECTOR(2 downto 0); --
            Constante: out STD_LOGIC_VECTOR(7 downto 0) --
        );
    end component;

    component Memoria_dados
        Port (
            CLK : in STD_LOGIC;--
            WR : in STD_LOGIC; --
            constante : in STD_LOGIC_VECTOR(7 downto 0); --
            Operando1 : in STD_LOGIC_VECTOR(7 downto 0); --
            Dados_M  : out STD_LOGIC_VECTOR(7 downto 0) --
        );
    end component;
    signal opcode : std_logic_vector(4 downto 0);
    signal constante_s : std_logic_vector(7 downto 0);
begin
    
    Mem_Inst : Memoria_instrucoes
    port map (
        Endereco => Endereco,
        opcode => opcode,
        SEL_REG1 => SEL_REG1,
        SEL_REG2 => SEL_REG2,
        Constante => constante_s
    );
    Mem_Dados : Memoria_dados
    port map (
        CLK => clk,
        WR => WR,
        constante => constante_s,
        Operando1 => operando1,
        Dados_M => Dados_M
    );
    constante <= constante_s;
    opcode_out <= opcode;
end structural;
