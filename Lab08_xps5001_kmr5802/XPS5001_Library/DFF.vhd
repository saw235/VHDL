----------------------------------------------------------------------------
-- Entity:        DFF
-- Written By:    Saw Xue Zheng
-- Date Created:  9/21/2016
-- Description:   D Flip Flop
--
-- Revision History (date, initials, description):
-- 	21 September 2016, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DFF is
    Port ( D 	: in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q 	: out  STD_LOGIC := '0');
end DFF;

architecture Behavioral of DFF is

begin
	process (CLK) is
	begin
		if (CLK'event and CLK = '1') then
			Q <= D;
		end if;
		
	end process;

end Behavioral;

