----------------------------------------------------------------------------
-- Entity:        PulseGenerator
-- Written By:    Saw Xue Zheng
-- Date Created:  9/21/2016
-- Description:   Pulses every maxCount+1 count
--						1st cycle has 1 less count
-- Revision History (date, initials, description):
-- 	21 September 2016, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------

library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;

entity PulseGenerator is
	 Generic ( n 		  : integer := 4;
				  maxCount : integer := 9);
    Port ( EN 		: in  STD_LOGIC;
           CLK 	: in  STD_LOGIC;
           CLR 	: in  STD_LOGIC;
           PULSE 	: out  STD_LOGIC);
end PulseGenerator;

architecture Structural of PulseGenerator is

	--internal signal
	signal a_int 		: STD_LOGIC_VECTOR ( n-1 downto 0);
	signal clr_int		: STD_LOGIC;
	signal pulse_int 	: STD_LOGIC;
begin
	--reset when EQU or clear is asserted
	clr_int <= CLR or pulse_int;
	
	
	count	 : Counter generic map( n => n) port map (
					EN  => EN,
					CLK => CLK,
					CLR => clr_int,
					Q	 => a_int
	);

	cmpreq : CompareEQU generic map ( n => n) port map (
			  A	=> a_int,
           B	=> STD_LOGIC_VECTOR(to_unsigned(maxCount, n)),
           EQU	=> pulse_int
	);

	PULSE <= pulse_int;

end Structural;

