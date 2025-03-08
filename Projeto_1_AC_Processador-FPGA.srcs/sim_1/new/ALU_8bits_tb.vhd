library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;
use std.textio.all;

entity ALU_8bits_tb is
end ALU_8bits_tb;

architecture Behavioral of ALU_8bits_tb is

    -- Component declaration of the ALU_8bits module
    component ALU_8bits
        Port (
            A : in  STD_LOGIC_VECTOR(7 downto 0);  
            B : in  STD_LOGIC_VECTOR(7 downto 0);  
            Sel : in  STD_LOGIC_VECTOR(3 downto 0);  
            Result : out STD_LOGIC_VECTOR(7 downto 0);  
            COMP_FLAG: out STD_LOGIC_VECTOR(4 downto 0)   
        );
    end component;

    -- Signals for the ALU inputs and outputs
    signal A : STD_LOGIC_VECTOR(7 downto 0);
    signal B : STD_LOGIC_VECTOR(7 downto 0);
    signal Sel : STD_LOGIC_VECTOR(3 downto 0);
    signal Result : STD_LOGIC_VECTOR(7 downto 0);
    signal COMP_FLAG : STD_LOGIC_VECTOR(4 downto 0);

begin

    -- Instantiating the ALU_8bits module
    uut: ALU_8bits
        Port map (
            A => A,
            B => B,
            Sel => Sel,
            Result => Result,
            COMP_FLAG => COMP_FLAG
        );

    -- Stimulus process to apply different test cases
    stim_proc: process
    begin
        -- Test 1: A = 8'h55, B = 8'hAA, Sel = "0000" (Add)
        A <= "00000001"; -- 8'h55
        B <= "00011011"; -- 8'hAA
        Sel <= "0000";  -- Add operation
        wait for 10 ns;
        if Result = "00011100" then
            report "Test 1: Add passed";
        else
            report "Test 1: Add failed";
        end if;

        -- Test 2: A = 8'h55, B = 8'hAA, Sel = "0001" (Subtract)
        A <= "00000010"; -- 8'h55
        B <= "00000001"; -- 8'hAA
        Sel <= "0001";  -- Subtract operation
        wait for 10 ns;
        if Result = "000000001" then
            report "Test 2: Subtract passed";
        else
            report "Test 2: Subtract failed";
        end if;

        -- Test 3: A = 8'h00, B = 8'h00, Sel = "0010" (AND)
        A <= "00000000"; -- 8'h00
        B <= "00000000"; -- 8'h00
        Sel <= "0010";  -- AND operation
        wait for 10 ns;
        if Result = "00000000" then
            report "Test 3: AND passed";
        else
            report "Test 3: AND failed";
        end if;

        -- Test 4: A = 8'hFF, B = 8'h00, Sel = "0011" (OR)
        A <= "11111111"; -- 8'hFF
        B <= "00000000"; -- 8'h00
        Sel <= "0011";  -- OR operation
        wait for 10 ns;
        if Result = "11111111" then
            report "Test 4: OR passed";
        else
            report "Test 4: OR failed";
        end if;

        -- Test 5: A = 8'h00, B = 8'h00, Sel = "0100" (XOR)
        A <= "00000000"; -- 8'h00
        B <= "00000000"; -- 8'h00
        Sel <= "0100";  -- XOR operation
        wait for 10 ns;
        if Result = "00000000" then
            report "Test 5: XOR passed";
        else
            report "Test 5: XOR failed";
        end if;

        -- Test 6: A = 8'hAA, B = 8'h55, Sel = "0101" (NAND)
        A <= "10101010"; -- 8'hAA
        B <= "01010101"; -- 8'h55
        Sel <= "0101";  -- NAND operation
        wait for 10 ns;
        if Result = "00000000" then
            report "Test 6: NAND passed";
        else
            report "Test 6: NAND failed";
        end if;

        -- Test 7: A = 8'hFF, B = 8'hFF, Sel = "0110" (NOR)
        A <= "11111111"; -- 8'hFF
        B <= "11111111"; -- 8'hFF
        Sel <= "0110";  -- NOR operation
        wait for 10 ns;
        if Result = "00000000" then
            report "Test 7: NOR passed";
        else
            report "Test 7: NOR failed";
        end if;

        -- Test 8: A = 8'h00, B = 8'h00, Sel = "0111" (Comparison)
        A <= "00000100"; -- 8'h00
        B <= "00000100"; -- 8'h00
        Sel <= "1000";  -- Comparison operation
        wait for 10 ns;
        if COMP_FLAG = "01110" then
            report "Test 8: Comparison passed";
        else
            report "Test 8: Comparison failed";
        end if;

        -- Test 9: A = 8'h01, B = 8'h01, Sel = "1000" (Comparison)
        A <= "00000010"; -- 8'h01
        B <= "00000001"; -- 8'h01
        Sel <= "1000";  -- Comparison operation
        wait for 10 ns;
        if COMP_FLAG = "11000" then
            report "Test 9: Comparison passed";
        else
            report "Test 9: Comparison failed";
        end if;

        -- Test 10: A = 8'h01, B = 8'hFF, Sel = "1001" (Comparison)
        A <= "00000001"; -- 8'h01
        B <= "00000011"; -- 8'hFF
        Sel <= "1000";  -- Comparison operation
        wait for 10 ns;
        if COMP_FLAG = "00011" then
            report "Test 10: Comparison passed";
        else
            report "Test 10: Comparison failed";
        end if;

        -- End the simulation
        wait;
    end process;

end Behavioral;
