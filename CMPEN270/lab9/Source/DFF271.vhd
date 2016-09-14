
------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 10/16/14
-- Lab # and name	: 1-bit edge triggered D-FF for state machines
-- Student 1		: KD Rogers 
-- Student 2		: Robin Panda

-- Description		: Equivalent to the Xilinx 'DF' primitive, except uses STD LOGIC instead of STD u-LOGIC to promote multi-level 
--						 	logic results for the purpose of proper understanding of ** Reset **!
--							Has active-high enable/load and active-high synchronous reset.
--						 	Utilizes cote style that should not be used elsewhere in lab.

-- Changes 
--		1.0	- Original
--		1.1	- Fixed template, added reset, clk enable
--		1.2	- Commented out clken


-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------

-- Library Declarations 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Entity 
entity dff272 is port
	(
		 clk 	: in std_logic ;
		clken	: in std_logic ;
		 rst 	: in std_logic ;
		 d 	: in std_logic ;
		 q 	: out std_logic
    );
end dff272;

-- Architecture 
architecture dff272_a of dff272 is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	-- NONE	
	
	-------------------------------------------------------
	-- Internal Signal Declarations	
	-------------------------------------------------------

	-- NONE
	
begin
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- NONE

	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------

-- DO NOT USE THIS CODE STYLE IN YOUR CODE! I DO NOT WANT TO SEE PROCESS!

 	process(clk)
		begin
			if rising_edge(clk) then
				if (rst = '1') then
					q <= '0';
				elsif (clken = '1') then
					q <= d;
				end if;
			end if;
	end process;
  
end dff272_a;


