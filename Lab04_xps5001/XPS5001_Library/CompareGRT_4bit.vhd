----------------------------------------------------------------------------
-- Entity:        CompareGRT_4bit
-- Written By:    Saw Xue Zheng
-- Date Created:  9/10/2016
-- Description:   Compare 2 4-bit number, output 1 if A > B
--
-- Revision History (date, initials, description):
-- 	9 September 16, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CompareGRT_4bit is
    Port ( A   : in  STD_LOGIC_VECTOR (3 downto 0);
           B   : in  STD_LOGIC_VECTOR (3 downto 0);
           GRT : out  STD_LOGIC);
end CompareGRT_4bit;

architecture Behavioral of CompareGRT_4bit is

begin

	GRT <= '1' when (unsigned(A) > unsigned(B)) else '0';


end Behavioral;

