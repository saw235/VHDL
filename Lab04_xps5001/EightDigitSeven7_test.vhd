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

entity EightDigitSeven7_test is
    Port ( SWITCH : in  STD_LOGIC_VECTOR (8 downto 0);
			  CLK 	: in  STD_LOGIC;
           SEGMENT: out  STD_LOGIC_VECTOR (0 to 6);
           ANODE 	: out  STD_LOGIC_VECTOR (7 downto 0)
           );
end EightDigitSeven7_test;

architecture Behavioral of EightDigitSeven7_test is
	
	--internal signals
	signal pulse_int : STD_LOGIC;
	signal count_int : STD_LOGIC_VECTOR(31 downto 0);
	signal count_pulse : STD_LOGIC;

begin

	count	 : Counter generic map( n => 32) port map (
					EN  => count_pulse,
					CLK => CLK,
					CLR => SWITCH(0),
					Q	 => count_int
	);
	
	pulgen0: PulseGenerator generic map ( n => 18, maxCount => 199999 )
		port map ( 	 EN 	=> '1',
						CLK 	=>	CLK,
						CLR 	=>	'0',
						PULSE => pulse_int
	);
	
	pulgen1: PulseGenerator generic map ( n => 25, maxCount => 24999999 )
		port map ( 	 EN 	=> '1',
						CLK 	=>	CLK,
						CLR 	=>	'0',
						PULSE => count_pulse
	);
	

	eds : WordTo8dig7Seg port map(
			  WORD 		=> count_int,
           STROBE 	=> pulse_int,
           CLK 		=> CLK,
           DIGIT_EN 	=> SWITCH(8 downto 1),
           ANODE 		=> ANODE,
           SEGMENT 	=> SEGMENT
	);

end Behavioral;

