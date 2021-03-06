----------------------------------------------------------------------------
-- Entity:        Lab02_xps5001_tb
-- Written By:    Saw Xue Zheng
-- Date Created:  9/4/2016
-- Description:   Testbench for Lab02_xps5001. 
-- 					Test for boundary values for A and B, and all 
--						combinations of BTNC BTNU and BTND.
--						Test vector is generated using python.
--
-- Revision History (date, initials, description):
-- 	4 September 16, xps5001, file created.

-- Dependencies:
--		Lab02_xps5001
----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Lab02_xps5001_tb IS
END Lab02_xps5001_tb;
 
ARCHITECTURE behavior OF Lab02_xps5001_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Lab02_xps5001
    PORT(
         SWITCH  : IN  std_logic_vector(7 downto 0);
         BTNU 	  : IN  std_logic;
         BTNC 	  : IN  std_logic;
         BTND 	  : IN  std_logic;
         ANODE   : OUT  std_logic_vector(7 downto 0);
         SEGMENT : OUT  std_logic_vector(0 to 6);
         LED 	  : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SWITCH 	: std_logic_vector(7 downto 0) := (others => '0');
   signal BTNU 	: std_logic := '0';
   signal BTNC 	: std_logic := '0';
   signal BTND 	: std_logic := '0';

 	--Outputs
   signal ANODE	: std_logic_vector(7 downto 0);
   signal SEGMENT	: std_logic_vector(0 to 6);
   signal LED 		: std_logic_vector(7 downto 0);
   
	 -- Test vector includes input stimuli and expected outputs
   -- BTNU      			: bits 21
	-- BTNC					: bits 20
	-- BTND					: bits 19
	-- A (SWITCH(7..4))	: bits 18..15
	-- B (SWITCH(3..0))	: bits 14..11
   -- SEGMENT 				: bits 10..4
	-- LED					: bits 3..0
	-- test vector is BTNU & BTNC & BTND & SWITCH & SEGMENT & LED
   type test_vector_type is array (0 to 127) of STD_LOGIC_VECTOR (21 downto 0);
   constant test_vector : test_vector_type := (
	--*****Add*****
	--			  A			  B
	--BTN   SWITCH(7..4) SWITCH(3..0)  SEGMENT		LED
	"000"	&	"0000"	&	"0000"	&	"0000001"	&	"0000",
	"000"	&	"0000"	&	"0001"	&	"1001111"	&	"0001",
	"000"	&	"0000"	&	"1110"	&	"0110000"	&	"1110",
	"000"	&	"0000"	&	"1111"	&	"0111000"	&	"1111",
	"000"	&	"0001"	&	"0000"	&	"1001111"	&	"0001",
	"000"	&	"0001"	&	"0001"	&	"0010010"	&	"0010",
	"000"	&	"0001"	&	"1110"	&	"0111000"	&	"1111",
	"000"	&	"0001"	&	"1111"	&	"0000001"	&	"0000",
	"000"	&	"1110"	&	"0000"	&	"0110000"	&	"1110",
	"000"	&	"1110"	&	"0001"	&	"0111000"	&	"1111",
	"000"	&	"1110"	&	"1110"	&	"0110001"	&	"1100",
	"000"	&	"1110"	&	"1111"	&	"1000010"	&	"1101",
	"000"	&	"1111"	&	"0000"	&	"0111000"	&	"1111",
	"000"	&	"1111"	&	"0001"	&	"0000001"	&	"0000",
	"000"	&	"1111"	&	"1110"	&	"1000010"	&	"1101",
	"000"	&	"1111"	&	"1111"	&	"0110000"	&	"1110",
	"110"	&	"0000"	&	"0000"	&	"0000001"	&	"0000",
	"110"	&	"0000"	&	"0001"	&	"1001111"	&	"0001",
	"110"	&	"0000"	&	"1110"	&	"0110000"	&	"1110",
	"110"	&	"0000"	&	"1111"	&	"0111000"	&	"1111",
	"110"	&	"0001"	&	"0000"	&	"1001111"	&	"0001",
	"110"	&	"0001"	&	"0001"	&	"0010010"	&	"0010",
	"110"	&	"0001"	&	"1110"	&	"0111000"	&	"1111",
	"110"	&	"0001"	&	"1111"	&	"0000001"	&	"0000",
	"110"	&	"1110"	&	"0000"	&	"0110000"	&	"1110",
	"110"	&	"1110"	&	"0001"	&	"0111000"	&	"1111",
	"110"	&	"1110"	&	"1110"	&	"0110001"	&	"1100",
	"110"	&	"1110"	&	"1111"	&	"1000010"	&	"1101",
	"110"	&	"1111"	&	"0000"	&	"0111000"	&	"1111",
	"110"	&	"1111"	&	"0001"	&	"0000001"	&	"0000",
	"110"	&	"1111"	&	"1110"	&	"1000010"	&	"1101",
	"110"	&	"1111"	&	"1111"	&	"0110000"	&	"1110",
		--*****Subtract*****
	--			  A			  B
	--BTN   SWITCH(7..4) SWITCH(3..0)  SEGMENT
	"001"	&	"0000"	&	"0000"	&	"0000001"	&	"0000",
	"001"	&	"0000"	&	"0001"	&	"0111000"	&	"1111",
	"001"	&	"0000"	&	"1110"	&	"0010010"	&	"0010",
	"001"	&	"0000"	&	"1111"	&	"1001111"	&	"0001",
	"001"	&	"0001"	&	"0000"	&	"1001111"	&	"0001",
	"001"	&	"0001"	&	"0001"	&	"0000001"	&	"0000",
	"001"	&	"0001"	&	"1110"	&	"0000110"	&	"0011",
	"001"	&	"0001"	&	"1111"	&	"0010010"	&	"0010",
	"001"	&	"1110"	&	"0000"	&	"0110000"	&	"1110",
	"001"	&	"1110"	&	"0001"	&	"1000010"	&	"1101",
	"001"	&	"1110"	&	"1110"	&	"0000001"	&	"0000",
	"001"	&	"1110"	&	"1111"	&	"0111000"	&	"1111",
	"001"	&	"1111"	&	"0000"	&	"0111000"	&	"1111",
	"001"	&	"1111"	&	"0001"	&	"0110000"	&	"1110",
	"001"	&	"1111"	&	"1110"	&	"1001111"	&	"0001",
	"001"	&	"1111"	&	"1111"	&	"0000001"	&	"0000",
	"011"	&	"0000"	&	"0000"	&	"0000001"	&	"0000",
	"011"	&	"0000"	&	"0001"	&	"0111000"	&	"1111",
	"011"	&	"0000"	&	"1110"	&	"0010010"	&	"0010",
	"011"	&	"0000"	&	"1111"	&	"1001111"	&	"0001",
	"011"	&	"0001"	&	"0000"	&	"1001111"	&	"0001",
	"011"	&	"0001"	&	"0001"	&	"0000001"	&	"0000",
	"011"	&	"0001"	&	"1110"	&	"0000110"	&	"0011",
	"011"	&	"0001"	&	"1111"	&	"0010010"	&	"0010",
	"011"	&	"1110"	&	"0000"	&	"0110000"	&	"1110",
	"011"	&	"1110"	&	"0001"	&	"1000010"	&	"1101",
	"011"	&	"1110"	&	"1110"	&	"0000001"	&	"0000",
	"011"	&	"1110"	&	"1111"	&	"0111000"	&	"1111",
	"011"	&	"1111"	&	"0000"	&	"0111000"	&	"1111",
	"011"	&	"1111"	&	"0001"	&	"0110000"	&	"1110",
	"011"	&	"1111"	&	"1110"	&	"1001111"	&	"0001",
	"011"	&	"1111"	&	"1111"	&	"0000001"	&	"0000",
	"101"	&	"0000"	&	"0000"	&	"0000001"	&	"0000",
	"101"	&	"0000"	&	"0001"	&	"0111000"	&	"1111",
	"101"	&	"0000"	&	"1110"	&	"0010010"	&	"0010",
	"101"	&	"0000"	&	"1111"	&	"1001111"	&	"0001",
	"101"	&	"0001"	&	"0000"	&	"1001111"	&	"0001",
	"101"	&	"0001"	&	"0001"	&	"0000001"	&	"0000",
	"101"	&	"0001"	&	"1110"	&	"0000110"	&	"0011",
	"101"	&	"0001"	&	"1111"	&	"0010010"	&	"0010",
	"101"	&	"1110"	&	"0000"	&	"0110000"	&	"1110",
	"101"	&	"1110"	&	"0001"	&	"1000010"	&	"1101",
	"101"	&	"1110"	&	"1110"	&	"0000001"	&	"0000",
	"101"	&	"1110"	&	"1111"	&	"0111000"	&	"1111",
	"101"	&	"1111"	&	"0000"	&	"0111000"	&	"1111",
	"101"	&	"1111"	&	"0001"	&	"0110000"	&	"1110",
	"101"	&	"1111"	&	"1110"	&	"1001111"	&	"0001",
	"101"	&	"1111"	&	"1111"	&	"0000001"	&	"0000",
	"111"	&	"0000"	&	"0000"	&	"0000001"	&	"0000",
	"111"	&	"0000"	&	"0001"	&	"0111000"	&	"1111",
	"111"	&	"0000"	&	"1110"	&	"0010010"	&	"0010",
	"111"	&	"0000"	&	"1111"	&	"1001111"	&	"0001",
	"111"	&	"0001"	&	"0000"	&	"1001111"	&	"0001",
	"111"	&	"0001"	&	"0001"	&	"0000001"	&	"0000",
	"111"	&	"0001"	&	"1110"	&	"0000110"	&	"0011",
	"111"	&	"0001"	&	"1111"	&	"0010010"	&	"0010",
	"111"	&	"1110"	&	"0000"	&	"0110000"	&	"1110",
	"111"	&	"1110"	&	"0001"	&	"1000010"	&	"1101",
	"111"	&	"1110"	&	"1110"	&	"0000001"	&	"0000",
	"111"	&	"1110"	&	"1111"	&	"0111000"	&	"1111",
	"111"	&	"1111"	&	"0000"	&	"0111000"	&	"1111",
	"111"	&	"1111"	&	"0001"	&	"0110000"	&	"1110",
	"111"	&	"1111"	&	"1110"	&	"1001111"	&	"0001",
	"111"	&	"1111"	&	"1111"	&	"0000001"	&	"0000",
	--*****Show A*****
	--			  A			  B
	--BTN   SWITCH(7..4) SWITCH(3..0)  SEGMENT
	"100"	&	"0000"	&	"0000"	&	"0000001"	&	"0000",
	"100"	&	"0000"	&	"0001"	&	"0000001"	&	"0001",
	"100"	&	"0000"	&	"1110"	&	"0000001"	&	"1110",
	"100"	&	"0000"	&	"1111"	&	"0000001"	&	"1111",
	"100"	&	"0001"	&	"0000"	&	"1001111"	&	"0001",
	"100"	&	"0001"	&	"0001"	&	"1001111"	&	"0010",
	"100"	&	"0001"	&	"1110"	&	"1001111"	&	"1111",
	"100"	&	"0001"	&	"1111"	&	"1001111"	&	"0000",
	"100"	&	"1110"	&	"0000"	&	"0110000"	&	"1110",
	"100"	&	"1110"	&	"0001"	&	"0110000"	&	"1111",
	"100"	&	"1110"	&	"1110"	&	"0110000"	&	"1100",
	"100"	&	"1110"	&	"1111"	&	"0110000"	&	"1101",
	"100"	&	"1111"	&	"0000"	&	"0111000"	&	"1111",
	"100"	&	"1111"	&	"0001"	&	"0111000"	&	"0000",
	"100"	&	"1111"	&	"1110"	&	"0111000"	&	"1101",
	"100"	&	"1111"	&	"1111"	&	"0111000"	&	"1110",
	--*****Show B*****
	--			  A			  B
	--BTN   SWITCH(7..4) SWITCH(3..0)  SEGMENT
	"010"	&	"0000"	&	"0000"	&	"0000001"	&	"0000",
	"010"	&	"0000"	&	"0001"	&	"1001111"	&	"0001",
	"010"	&	"0000"	&	"1110"	&	"0110000"	&	"1110",
	"010"	&	"0000"	&	"1111"	&	"0111000"	&	"1111",
	"010"	&	"0001"	&	"0000"	&	"0000001"	&	"0001",
	"010"	&	"0001"	&	"0001"	&	"1001111"	&	"0010",
	"010"	&	"0001"	&	"1110"	&	"0110000"	&	"1111",
	"010"	&	"0001"	&	"1111"	&	"0111000"	&	"0000",
	"010"	&	"1110"	&	"0000"	&	"0000001"	&	"1110",
	"010"	&	"1110"	&	"0001"	&	"1001111"	&	"1111",
	"010"	&	"1110"	&	"1110"	&	"0110000"	&	"1100",
	"010"	&	"1110"	&	"1111"	&	"0111000"	&	"1101",
	"010"	&	"1111"	&	"0000"	&	"0000001"	&	"1111",
	"010"	&	"1111"	&	"0001"	&	"1001111"	&	"0000",
	"010"	&	"1111"	&	"1110"	&	"0110000"	&	"1101",
	"010"	&	"1111"	&	"1111"	&	"0111000"	&	"1110"
	--128 test cases.

   );
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Lab02_xps5001 PORT MAP (
          SWITCH => SWITCH,
          BTNU => BTNU,
          BTNC => BTNC,
          BTND => BTND,
          ANODE => ANODE,
          SEGMENT => SEGMENT,
          LED => LED
        );

   -- Stimulus process
   stim_proc: process
   begin

      -- hold reset state for 100 ns.
      wait for 100 ns;
		
		-- run through all test vectors
      for i in test_vector'Range loop
      
         -- Assign test inputs
         BTNU <= test_vector(i)(21);
         BTNC <= test_vector(i)(20);
			BTND <= test_vector(i)(19);
			SWITCH(7 downto 4) <= test_vector(i)(18 downto 15);
			SWITCH(3 downto 0) <= test_vector(i)(14 downto 11);
         -- Compare outputs to expected values
         wait for 2ns;
         assert (SEGMENT = test_vector(i)(10 downto 4) and LED(3 downto 0) = test_vector(i)(3 downto 0))
            report "***** Test failed. *****"
            severity Failure;
      end loop;
      
      -- All tests are successful if we get this far
      report "***** All tests completed successfully. *****";
      wait;
   end process;

END;
