----------------------------------------------------------------------------
-- Entity:        AdderSubtractor_4bit
-- Written By:    Saw Xue Zheng
-- Date Created:  8/27/2016
-- Description:   Component to add or subtract two 4bit numbers
--						Able to detect if overflow
--
-- Revision History (date, initials, description):
-- 	27 Aug 16, xps5001, file created.

-- Dependencies:
--		RippleCarryAdder_4bit
----------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity AdderSubtractor_4bit is
    Port ( A 			: in  STD_LOGIC_VECTOR (3 downto 0);
           B 			: in  STD_LOGIC_VECTOR (3 downto 0);
			  SUBTRACT 	: in  STD_LOGIC;
           SUM 		: out  STD_LOGIC_VECTOR (3 downto 0);
           OVERFLOW 	: out  STD_LOGIC);
end AdderSubtractor_4bit;

architecture Structural of AdderSubtractor_4bit is

	-- Component
COMPONENT RippleCarryAdder_4bit
    PORT(
         A 		: IN  std_logic_vector(3 downto 0);
         B 		: IN  std_logic_vector(3 downto 0);
         C_in 	: IN  std_logic;
         C_out : OUT  std_logic;
         SUM	: OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;

	-- Internal Signals
	
	signal BXOR : STD_LOGIC_VECTOR (3 downto 0);
	signal SUM_int : STD_LOGIC_VECTOR (3 downto 0);

begin

	-- Instance of RippleCarryAdder_4bit
	RCA : RippleCarryAdder_4bit PORT MAP (
          A 	=> A,
          B 	=> BXOR,
          C_in => SUBTRACT,
          SUM 	=> SUM_int
        );
		  
	-- InvertOrPass		(LOGIC)
	BXOR(0) <= B(0) XOR SUBTRACT;
	BXOR(1) <= B(1) XOR SUBTRACT;
	BXOR(2) <= B(2) XOR SUBTRACT;
	BXOR(3) <= B(3) XOR SUBTRACT;
	
	-- Detect_Overflow 	(LOGIC)
	OVERFLOW <= ((NOT A(3)) AND (SUM_int(3)) AND( B(3) XNOR SUBTRACT)) or ((A(3)) AND (NOT SUM_int(3)) AND( B(3) XOR SUBTRACT));
	
	-- OUTPUT
	SUM <= SUM_int;
	
	
end Structural;

