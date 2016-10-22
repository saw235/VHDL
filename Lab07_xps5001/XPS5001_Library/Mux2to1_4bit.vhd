----------------------------------------------------------------------------
-- Entity:        Mux2to1_4bit
-- Written By:    Saw Xue Zheng
-- Date Created:  9/11/2016
-- Description:   2to1 Mux
--
-- Revision History (date, initials, description):
-- 	11 September 16, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux2to1_4bit is
    Port ( X0 	: in  STD_LOGIC_VECTOR (3 downto 0);
           X1 	: in  STD_LOGIC_VECTOR (3 downto 0);
           SEL : in  STD_LOGIC;
           Y 	: out  STD_LOGIC_VECTOR (3 downto 0));
end Mux2to1_4bit;

architecture Behavioral of Mux2to1_4bit is

begin

	with SEL select
		Y <= 	X0 when '0',
				X1 when '1',
				"0000" when others;
		  
end Behavioral;

