----------------------------------------------------------------------------
-- Entity:        Timer
-- Written By:    Saw Xue Zheng
-- Date Created:  10/4/2016
-- Description:   Timer that counts up to counter_nbits
-- Revision History (date, initials, description):
-- 	4 October 16, xps5001, file created.

-- Dependencies: None
----------------------------------------------------------------------------


library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use XPS5001_Library.XPS5001_Components.ALL;

entity Timer is
	 Generic ( pulse_gen_n 			 : integer := 24;
				  pulse_gen_max_count : integer := 9999999; 
				  counter_nbits 		 : integer := 8);
    Port ( CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           Q 	: out  STD_LOGIC_VECTOR (counter_nbits-1 downto 0));
end Timer;

architecture Structural of Timer is

	signal pulse_int : std_logic; 

begin

	pulse_gen : PulseGenerator generic map( n => pulse_gen_n, maxCount => pulse_gen_max_count)
	port map(
				EN 	=> '1',
				CLK	=> CLK,
				CLR	=> CLR,
				PULSE => pulse_int--internal pulse
			);
		
	cnt	 : Counter generic map (n => counter_nbits) port map (
					EN  => pulse_int,
					CLK => CLK,
					CLR => CLR,
					Q	 => Q
	);	


end Structural;

