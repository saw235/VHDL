----------------------------------------------------------------------------
-- Entity:        RippleCarryAdder
-- Written By:    Saw Xue Zheng
-- Date Created:  9/17/2016
-- Description:   Component to add two n-bit numbers together.
--
-- Revision History (date, initials, description):
-- 	17 September 2016, xps5001, file created.

-- Dependencies:
--		FullAdder
----------------------------------------------------------------------------
library IEEE;
library XPS5001_Library;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.ALL;

entity RippleCarryAdder is
	 generic ( n	: integer := 8);
    Port ( A 		: in  STD_LOGIC_VECTOR (n-1 downto 0);
           B 		: in  STD_LOGIC_VECTOR (n-1 downto 0);
           C_in 	: in  STD_LOGIC;
           C_out 	: out  STD_LOGIC;
           SUM 	: out  STD_LOGIC_VECTOR (n-1 downto 0));
end RippleCarryAdder;

architecture Structural of RippleCarryAdder is

	-- Internal signals
		-- Carry Signals
	signal Carry : STD_LOGIC_VECTOR (n downto 0);
	
	
begin


   Carry(0) <= C_in;
	
	-- Instantiate FullAdders
	genFA: for i in 0 to n - 1 generate
			FAX : FullAdder port map (
					A 		=> A(i),
					B 		=> B(i),
					C_in	=> Carry(i),
					C_out => Carry(i+1),
					Sum	=> SUM(i)
			);
	end generate;
		
	C_out <= Carry(n);

end Structural;

