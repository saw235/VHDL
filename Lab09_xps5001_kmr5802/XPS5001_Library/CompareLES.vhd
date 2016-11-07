----------------------------------------------------------------------------
-- Entity:        CompareLES
-- Written By:    Saw Xue Zheng
-- Date Created:  9/17/2016
-- Description:   Compare 2 numbers, output 1 if A < B
--
-- Revision History (date, initials, description):
-- 	17 September 16, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CompareLES is
	 Generic ( n : integer := 8 );
    Port ( A	 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B 	 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           LES  : out  STD_LOGIC);
end CompareLES;

architecture Behavioral of CompareLES is

begin

	LES <= '1' when (unsigned(A) < unsigned(B)) else '0';


end Behavioral;


