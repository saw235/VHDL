----------------------------------------------------------------------------
-- Entity:        DFF_CE
-- Written By:    Saw Xue Zheng
-- Date Created:  9/21/2016
-- Description:   D Flip Flop with CE (Chip Enable)
--
-- Revision History (date, initials, description):
-- 	21 September 2016, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF_CE is
    Port ( D 	: in  STD_LOGIC;
           CE 	: in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q 	: out  STD_LOGIC := '0');
end DFF_CE;

architecture Behavioral of DFF_CE is
begin
	process (CLK) is
	begin
		if (CE = '0') then NULL;
		elsif CLK'Event and CLK = '1' then
			Q <= D;
		end if;
		
	end process;
end Behavioral;

