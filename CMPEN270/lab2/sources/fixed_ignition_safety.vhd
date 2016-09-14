------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 09/04/14
-- Lab # and name	: Lab1 - Intro to ISE; Ignition Safety circuit
-- Student 1		: Saw Xue Zheng
-- Student 2		: Just me

-- Description		: Accepts inputs from 3 car sensors (parking brake, seat belt, and door latch).
--						  Based on the status of the sensors (see Lab1 for description), the circuit produces
--						  a 1-bit output (S) that indicates if the car will be allowed to run (1) or not (0).

-- Changes 
-- 			- Version 1.1 (Fixed syntax errors) 

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 
-- 	. These are the only libraries necessary for most CMPEN 270 labs
-- 	. DO NOT include additional libraries unless the lab instructs you to do so
--		. This syntax should be left flush

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 
-- 	. Describes the inputs and outputs of your design
--    . 'std_logic' stands for "Standard Logic" data type 
--		. The Entity name MUST be the same as the file name. It should be short, but descriptive.
-- 	. Notice the formatting: PLEASE format all Entity descriptions for CMPEN 270... 

--	.								EXACTLY AS SHOWN HERE!

--		. This includes white space, commas, parentheses, and semicolons. Alternative formatting will NOT be accepted.
--		. This syntax should begin left flush. Each indent is a one (1) TAB.






entity ignition_safety is port
	( 
		b 		: in std_logic		; -- Seat Belt sensor input 			--> 1 = belts buckled 
		d 		: in std_logic		; -- door latch sensor input 			--> 1 = door is closed 
		p 		: in std_logic 	; -- parking brake sensor input 		--> 1 = parking brake is on					
		s  	: out std_logic	  -- ignition safety circuit output --> 1 = car may (S)tart, 0 = car may not start		
	);
end ignition_safety;
----------------------------------------------------------------------

-- Architecture 
-- 	. Contains the HDL logic that indicates which gates are necessary and how to 
--	.	  connect them in order to implement the digital circuit
--		. Architecture name should be the same as the file name, but with "_a" appended
--		. The 2nd name in the architecture statement is the entity name
-- 	. This syntax should be left flush

architecture ignition_safety_a of ignition_safety is




----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	--		. Go after the architecture, but before the begin
	--		. This syntax should be indented one (1) TAB
	-------------------------------------------------------

	-- NONE for Lab2. 
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-- 	. Go after the architecture, but before the begin
	--		. This syntax should be indented one (1) TAB
	-------------------------------------------------------
	
	-- NONE for Lab2 (yet). 








begin
	
	-------------------------------------------------------
	-- Component Instantiations
	--		. Go after the begin statement
	--		. This syntax should be indented one (1) TAB
	-------------------------------------------------------

	-- NONE
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	--		. Goes after the begin statement
	--		. This syntax should be indented one (1) TAB
	-------------------------------------------------------------
	
	-- SOP Boolean equation that represents the functionality of ignition safety circuit described in Lab1
	s <= (NOT b AND NOT d AND p) OR (b AND d AND NOT p); 
 			 
end ignition_safety_a; -- .same name as the architecture