----------------------------------------------------------------------------
-- Entity:        OneShotR
-- Written By:    Saw Xue Zheng
-- Date Created:  9/21/2016
-- Description:   Reverse OneShot the input signal
--						

-- Revision History (date, initials, description):
-- 	21 September 2016, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------
library IEEE;
library XPS5001_Library;

use XPS5001_Library.XPS5001_Components.ALL;
use IEEE.STD_LOGIC_1164.ALL;


entity OneShotR is
    Port ( D 	: in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q 	: out  STD_LOGIC);
end OneShotR;

architecture Structural of OneShotR is

	--internal wires
	signal q_int : std_logic;

begin
	
	 
	Dflop : DFF port map(
		D 		=> D,
		CLK 	=> CLK,
		Q		=> q_int
	);

	Q <= (not D) and q_int;
	
end Structural;