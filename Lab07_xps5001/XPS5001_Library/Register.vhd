----------------------------------------------------------------------------
-- Entity:        Reg
-- Written By:    Saw Xue Zheng
-- Date Created:  9/21/2016
-- Description:   n-bit register
--
-- Revision History (date, initials, description):
-- 	21 September 2016, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reg is
	 Generic ( n : integer := 8);
    Port ( D 		: in  STD_LOGIC_VECTOR (n-1 downto 0);
           LOAD 	: in  STD_LOGIC;
           CLK 	: in  STD_LOGIC;
           CLR 	: in  STD_LOGIC;
           Q 		: out  STD_LOGIC_VECTOR (n-1 downto 0) := (others => '0'));
end Reg;

architecture Behavioral of Reg is

begin

	process (CLK) is
	begin
		if (CLK'EVENT and CLK = '1') then
			if (CLR = '1') then
					Q <= (others =>'0');
			elsif (LOAD = '1') then
					Q <= D;
			end if;
		end if;
	end process;

end Behavioral;

