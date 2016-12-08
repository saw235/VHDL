----------------------------------------------------------------------------
-- Entity:        OneShot
-- Written By:    Saw Xue Zheng
-- Date Created:  9/21/2016
-- Description:   OneShot the input signal
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


entity OneShot is
    Port ( D 	: in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q 	: out  STD_LOGIC);
end OneShot;

architecture Structural of OneShot is

	--internal wires
	signal q_int : std_logic;

begin
	
	 
	Dflop : DFF port map(
		D 		=> D,
		CLK 	=> CLK,
		Q		=> q_int
	);

	Q <= D and not q_int;
	
end Structural;

