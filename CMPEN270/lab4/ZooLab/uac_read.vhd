------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 09/30/14
-- Lab # and name	: Lab4 - UAC reader and Warning
-- Student 1		: Saw Xue Zheng
-- Student 2		: Ryan Kelley

-- Description		: Reads UAC code and checks whether if animal needs to be vaccinated (1) or not (0)
--						: 
--						: dangerous = 1, when animal is dangerous, 0 when animal is not
-- Changes 
-- 			- Version 1.0 

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;


entity uac_read is
    Port ( U : in  STD_LOGIC; 
           A : in  STD_LOGIC;
           C : in  STD_LOGIC;
           S : in  STD_LOGIC; -- Signal for sedated animals (1) for sedated, (0) otherwise.
           dangerous : out  STD_LOGIC;  -- (0) Animal is safe, (1) animal is dangerous.
           needs_vac : out  STD_LOGIC); -- (0) Animal does not need vaccine, (1) Animal needs vaccine
end uac_read;



architecture read_and_warn of uac_read is

signal predator : std_logic; -- internal signal to see if animal is predator
begin

needs_vac <= (not A) and (not c);
predator <= not A;  
dangerous <= (not A) and (not S);

end read_and_warn;

