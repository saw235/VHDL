----------------------------------------------------------------------------
-- Entity:        CompareEQU
-- Written By:    Saw Xue Zheng
-- Date Created:  9/17/2016
-- Description:   Compare 2 number output 1 if equal
--
-- Revision History (date, initials, description):
-- 	17 September 16, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CompareEQU is
	 Generic ( n : integer := 8);
    Port ( A	 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B	 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           EQU	 : out  STD_LOGIC);
end CompareEQU;

architecture Behavioral of CompareEQU is

begin

	EQU <= '1' when (A = B) else '0';

end Behavioral;

