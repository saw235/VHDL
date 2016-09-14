------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 09/22/14
-- Lab # and name	: Lab2 Testbench - Security Circuit
-- Student 1		: Saw Xue Zheng
-- Student 2		: Ryan Kelley

-- Description		: Test the security circuit 
--						  Test for 0 when combination is incorrect, test for 1 when combination is correct

--						  

-- Changes 
-- 			- Version 1.1 (added 9 test case)

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY securitytest IS
END securitytest;
 
ARCHITECTURE behavior OF securitytest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT securitysystem is PORT(
         switch1 : IN  std_logic;
         switch2 : IN  std_logic;
         switch3 : IN  std_logic;
         switch4 : IN  std_logic;
         ss_normalop : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sw1 : std_logic ;
   signal sw2 : std_logic ;
   signal sw3 : std_logic ;
   signal sw4 : std_logic ;

 	--Outputs
   signal safe : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: securitysystem PORT MAP (
          switch1 => sw1,
          switch2 => sw2,
          switch3 => sw3,
          switch4 => sw4,
          ss_normalop => safe);

   -- Clock process definitions
 process  -- No Sensitivity list necessary for this TB - but some may need one. 
		begin 

      -- insert stimulus here 
		sw1 <= '0';
		sw2 <= '0';
		sw3 <= '0';
		sw4 <= '0'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 0 failed";
		
		sw1 <= '0';
		sw2 <= '0';
		sw3 <= '0';
		sw4 <= '1'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 1 failed";
		sw1 <= '0';
		sw2 <= '0';
		sw3 <= '1';
		sw4 <= '0'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 2 failed";
		sw1 <= '0';
		sw2 <= '0';
		sw3 <= '1';
		sw4 <= '1'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 3 failed";
		sw1 <= '0';
		sw2 <= '1';
		sw3 <= '0';
		sw4 <= '0'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 4 failed";
		sw1 <= '0';
		sw2 <= '1';
		sw3 <= '0';
		sw4 <= '1'; 
		
		
		wait for 20 ns;
			
		assert (safe = '1') report "Case 5 failed";
		sw1 <= '0';
		sw2 <= '1';
		sw3 <= '1';
		sw4 <= '0'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 6 failed";
		sw1 <= '0';
		sw2 <= '1';
		sw3 <= '1';
		sw4 <= '1'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 7 failed";
		sw1 <= '1';
		sw2 <= '0';
		sw3 <= '0';
		sw4 <= '0'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 8 failed";
		sw1 <= '1';
		sw2 <= '0';
		sw3 <= '0';
		sw4 <= '1'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 9 failed";
		sw1 <= '1';
		sw2 <= '0';
		sw3 <= '1';
		sw4 <= '0'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 10 failed";
		sw1 <= '1';
		sw2 <= '0';
		sw3 <= '1';
		sw4 <= '1'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 11 failed";
		
		sw1 <= '1';
		sw2 <= '1';
		sw3 <= '0';
		sw4 <= '0'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 12 failed";
     				
		sw1 <= '1';
		sw2 <= '1';
		sw3 <= '0';
		sw4 <= '1'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 13 failed";
		sw1 <= '1';
		sw2 <= '1';
		sw3 <= '1';
		sw4 <= '0'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 14 failed";
		sw1 <= '1';
		sw2 <= '1';
		sw3 <= '1';
		sw4 <= '1'; 
		
		
		wait for 20 ns;
			
		assert (safe = '0') report "Case 15 failed";
		
	
			
		
		wait;

	end process; 

end behavior;
