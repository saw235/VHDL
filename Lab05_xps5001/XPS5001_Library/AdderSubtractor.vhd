----------------------------------------------------------------------------
-- Entity:        AdderSubtractor
-- Written By:    Saw Xue Zheng
-- Date Created:  9/17/2017
-- Description:   Component to add or subtract two numbers
--						Able to detect if overflow
--
-- Revision History (date, initials, description):
-- 	17 Sept 16, xps5001, changed to generics.

-- Dependencies:
--		RippleCarryAdder
----------------------------------------------------------------------------
library IEEE;
library XPS5001_Library;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use XPS5001_Library.XPS5001_Components.ALL;


entity AdderSubtractor is
	 Generic ( n 		: integer := 8);
    Port ( A 			: in  STD_LOGIC_VECTOR (n-1 downto 0);
           B 			: in  STD_LOGIC_VECTOR (n-1 downto 0);
			  SUBTRACT  : in  STD_LOGIC;
           SUM			: out  STD_LOGIC_VECTOR (n-1 downto 0);
           OVERFLOW  : out  STD_LOGIC);
end AdderSubtractor;

architecture Structural of AdderSubtractor is

	-- Internal Signals
	
	signal BXOR 	: STD_LOGIC_VECTOR (n-1 downto 0);
	signal SUM_int : STD_LOGIC_VECTOR (n-1 downto 0);

begin

	-- Instance of RippleCarryAdder_4bit
	RCA : RippleCarryAdder GENERIC MAP ( n => n) PORT MAP (
          A	 	=> A,
          B 	=> BXOR,
          C_in => SUBTRACT,
          SUM	=> SUM_int
        );
		  
	-- InvertOrPass		(LOGIC)
	
	InvertOrPass: for i in 0 to n-1 generate
	begin		
			BXOR(i) <= B(i) XOR SUBTRACT;
	end generate;
	
	
	-- Detect_Overflow 	(LOGIC)
	OVERFLOW <= ((NOT A(n-1)) AND (SUM_int(n-1)) AND( B(n-1) XNOR SUBTRACT)) or ((A(n-1)) AND (NOT SUM_int(n-1)) AND( B(n-1) XOR SUBTRACT));
	
	-- OUTPUT
	SUM <= SUM_int;
	
	
end Structural;

