------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 09/04/14
-- Lab # and name	: Lab2 - Intro to ISE; Ignition Safety circuit
-- Student 1		: Saw Xue Zheng
-- Student 2		: Ryan Kelley

-- Description		: Accepts inputs from 3 car sensors (parking brake, seat belt, and door latch).
--						  Based on the status of the sensors (see Lab1 for description), the circuit produces
--						  a 1-bit output (S) that indicates if the car will be allowed to run (1) or not (0).

-- Changes 
-- 			- Version 1.3 (Added wire signals and pin constraints files)

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ignition_safety is port
	( 
		b 		: in std_logic		; -- Seat Belt sensor input 			--> 1 = belts buckled 
		d 		: in std_logic		; -- door latch sensor input 			--> 1 = door is closed 
		p 		: in std_logic 	; -- parking brake sensor input 		--> 1 = parking brake is on					
		s  	: out std_logic	  -- ignition safety circuit output --> 1 = car may (S)tart, 0 = car may not start		
	);
end ignition_safety;

architecture ignition_safety_a of ignition_safety is

	signal bdnotp, pnotbnotd, bdnotporpnotbnotd : std_logic;

begin
	
	bdnotp <= b AND d AND (NOT p);
	pnotbnotd <= (NOT b) AND (NOT d) AND p;
	bdnotporpnotbnotd <= bdnotp or pnotbnotd;
	s <= bdnotporpnotbnotd; 
 			 
end ignition_safety_a;