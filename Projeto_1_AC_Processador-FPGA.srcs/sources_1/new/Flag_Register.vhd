library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Flag_Register is
	Port (
		CLK : in std_logic;
		ESCR_F : in std_logic;
		SEL_F : in std_logic_vector(2 downto 0);
		COMP_FLAG : in std_logic_vector(4 downto 0);
		S_FLAG : out std_logic
	);
end Flag_Register;

architecture Behavioral of Flag_Register is
	signal stored_flag : std_logic_vector(4 downto 0) := "00000"; 

begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			if ESCR_F = '1' then
				stored_flag <= COMP_FLAG;
			end if;
		end if;
	end process;

	with SEL_F select
		S_FLAG <= stored_flag(0) when "000",  -- A < B
				  stored_flag(1) when "001",  -- A ≤ B
				  stored_flag(2) when "010",  -- A = B
				  stored_flag(3) when "011",  -- A ≥ B
				  stored_flag(4) when "100",  -- A > B
				  '0' when others;  

end Behavioral;
