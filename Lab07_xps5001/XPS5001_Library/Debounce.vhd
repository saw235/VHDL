----------------------------------------------------------------------------
-- Entity:        Debounce
-- Written By:    Saw Xue Zheng
-- Date Created:  9/24/2016
-- Description:   Debounce the input signal
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

entity Debounce is
    Port ( D 		: in  STD_LOGIC;
           SAMPLE : in  STD_LOGIC;
           CLK 	: in  STD_LOGIC;
           Q 		: out  STD_LOGIC);
end Debounce;

architecture Behavioral of Debounce is

	--internal signals
	signal D_int0 : STD_LOGIC;
	signal D_int1 : STD_LOGIC;
	signal Q_int : STD_LOGIC;

begin


					
	--synchronizers using two dff				
	Dflop0 : DFF_CE port map(
			 D 	=> D,
          CE 	=> SAMPLE,
          CLK  => CLK,
          Q 	=> D_int0
	);
	
	Dflop1 : DFF_CE port map(
			 D 	=> D_int0,
          CE 	=> SAMPLE,
          CLK  => CLK,
          Q 	=> D_int1
	);	
	
	--debounce the synchronized signal
	
	Dflop2 : DFF_CE port map(
			 D 	=> D_int1,
          CE 	=> SAMPLE,
          CLK  => CLK,
          Q 	=> Q_int
	);	
	
	Q <= Q_int and D_int1;
	
	

end Behavioral;

