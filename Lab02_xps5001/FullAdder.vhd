----------------------------------------------------------------------------
-- Entity:        FullAdder
-- Written By:    Saw Xue Zheng
-- Date Created:  8/27/2017
-- Description:   Component to add 2 bits together.
--
-- Revision History (date, initials, description):
-- 	27 Aug 16, xps5001, file created.

-- Dependencies:
--		none
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FullAdder is
    Port ( A 		: in  STD_LOGIC;
           B 		: in  STD_LOGIC;
           C_in 	: in  STD_LOGIC;
           C_out 	: out  STD_LOGIC;
           Sum 	: out  STD_LOGIC);
end FullAdder;

architecture dataflow of FullAdder is

--no internal wires 

begin


	--Logic for Full Adder outputs
	Sum	<=  A xor B xor C_in;
	C_out <= (A and B) or (C_in and (A xor B));

end dataflow;

