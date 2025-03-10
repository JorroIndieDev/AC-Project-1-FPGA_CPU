library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Memoria_instrucoes_TB is
end Memoria_instrucoes_TB;

architecture testbench of Memoria_instrucoes_TB is
    -- Component Declaration
    component Memoria_instrucoes
        Port (
            Endereco  : in  STD_LOGIC_VECTOR(7 downto 0);
            opcode    : out STD_LOGIC_VECTOR(4 downto 0);
            SEL_REG1  : out STD_LOGIC_VECTOR(2 downto 0);
            SEL_REG2  : out STD_LOGIC_VECTOR(2 downto 0);
            Constante : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals for connecting to the Memoria_instrucoes
    signal Endereco_tb  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal opcode_tb    : STD_LOGIC_VECTOR(4 downto 0);
    signal SEL_REG1_tb  : STD_LOGIC_VECTOR(2 downto 0);
    signal SEL_REG2_tb  : STD_LOGIC_VECTOR(2 downto 0);
    signal Constante_tb : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instantiate the Memoria_instrucoes
    UUT: Memoria_instrucoes
        port map (
            Endereco  => Endereco_tb,
            opcode    => opcode_tb,
            SEL_REG1  => SEL_REG1_tb,
            SEL_REG2  => SEL_REG2_tb,
            Constante => Constante_tb
        );

    -- Test process
    process
    begin
        -- Test valid address (e.g., address 5)
        Endereco_tb <= "00000101"; -- Address 5
        wait for 10 ns;
        assert opcode_tb = "00000" report "ERROR: opcode mismatch" severity error;
        assert SEL_REG1_tb = "000" report "ERROR: SEL_REG1 mismatch" severity error;
        assert SEL_REG2_tb = "000" report "ERROR: SEL_REG2 mismatch" severity error;
        assert Constante_tb = "00000000" report "ERROR: Constante mismatch" severity error;

        -- Test invalid address (e.g., address 300, which is out of bounds)
--        Endereco_tb <= "100101100"; -- Address 300 (invalid)
--        wait for 10 ns;
--        -- Expect all outputs to be "0" and a warning message in the simulation log
--        assert opcode_tb = "00000" report "ERROR: opcode mismatch for out-of-bounds address" severity error;
--        assert SEL_REG1_tb = "000" report "ERROR: SEL_REG1 mismatch for out-of-bounds address" severity error;
--        assert SEL_REG2_tb = "000" report "ERROR: SEL_REG2 mismatch for out-of-bounds address" severity error;
--        assert Constante_tb = "00000000" report "ERROR: Constante mismatch for out-of-bounds address" severity error;

        -- Test uninitialized or invalid address (e.g., "UUUUUUUU")
        Endereco_tb <= "UUUUUUUU"; -- Invalid address
        wait for 10 ns;
        -- Expect all outputs to be "0" and a warning message in the simulation log
        assert opcode_tb = "00000" report "ERROR: opcode mismatch for uninitialized address" severity error;
        assert SEL_REG1_tb = "000" report "ERROR: SEL_REG1 mismatch for uninitialized address" severity error;
        assert SEL_REG2_tb = "000" report "ERROR: SEL_REG2 mismatch for uninitialized address" severity error;
        assert Constante_tb = "00000000" report "ERROR: Constante mismatch for uninitialized address" severity error;

        -- Test normal valid address (e.g., address 10)
        Endereco_tb <= "00010000"; -- Address 10
        wait for 10 ns;
        assert opcode_tb = "00000" report "ERROR: opcode mismatch for valid address" severity error;
        assert SEL_REG1_tb = "000" report "ERROR: SEL_REG1 mismatch for valid address" severity error;
        assert SEL_REG2_tb = "000" report "ERROR: SEL_REG2 mismatch for valid address" severity error;
        assert Constante_tb = "00000000" report "ERROR: Constante mismatch for valid address" severity error;

        -- End simulation
        report "Test completed successfully!";
        std.env.stop;
    end process;

end testbench;
