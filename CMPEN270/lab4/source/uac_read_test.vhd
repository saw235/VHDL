------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 09/30/14
-- Lab # and name	: Lab4 Testbench - UAC_READ
-- Student 1		: Saw Xue Zheng
-- Student 2		: Ryan Kelley

-- Description		: Test the uac_read circuit
--						  

-- Changes 
-- 			- Version 1.1

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY uac_read_test IS
END uac_read_test;
 
ARCHITECTURE behavior OF uac_read_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT uac_read
    PORT(
         U : IN  std_logic;
         A : IN  std_logic;
         C : IN  std_logic;
         S : IN  std_logic;
         dangerous : OUT  std_logic;
         needs_vac : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal U : std_logic := '0';
   signal A : std_logic := '0';
   signal C : std_logic := '0';
   signal S : std_logic := '0';

 	--Outputs
   signal dangerous : std_logic;
   signal needs_vac : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: uac_read PORT MAP (
          U => U,
          A => A,
          C => C,
          S => S,
          dangerous => dangerous,
          needs_vac => needs_vac
        );

   -- Clock process definitions

   -- Stimulus process
 process
   begin		
		
		U <= '0';
		A <= '0';
		C <= '0';
		S <= '0';
      wait for 100 ns;	
		
		assert ((dangerous = '1') and (needs_vac = '1')) report "Case Anaconda1 failed";
		
		U <= '0';
		A <= '0';
		C <= '0';
		S <= '1';
      wait for 100 ns;	
		
		assert ((dangerous = '0') and (needs_vac = '1')) report "Case Anaconda2 failed";
		
		U <= '0';
		A <= '0';
		C <= '1';
		S <= '1';
      wait for 100 ns;	
		
		assert ((dangerous = '0') and (needs_vac = '0')) report "Case Bear1 failed";
		
		U <= '0';
		A <= '0';
		C <= '1';
		S <= '0';
      wait for 100 ns;	
		
		assert ((dangerous = '1') and (needs_vac = '0')) report "Case Bear2 failed";
		
		U <= '0';
		A <= '1';
		C <= '1';
		S <= '0';
      wait for 100 ns;	
		
		assert ((dangerous = '0') and (needs_vac = '0')) report "Case Duck1 failed";
		
		U <= '1';
		A <= '1';
		C <= '0';
		S <= '0';
      wait for 100 ns;	
		
		assert ((dangerous = '0') and (needs_vac = '0')) report "Case Elephant1 failed";

		U <= '1';
		A <= '0';
		C <= '0';
		S <= '0';
      wait for 100 ns;	
		
		assert ((dangerous = '1') and (needs_vac = '1')) report "Case Fox1 failed";
		
		U <= '1';
		A <= '0';
		C <= '0';
		S <= '1';
      wait for 100 ns;	
		
		assert ((dangerous = '0') and (needs_vac = '1')) report "Case Fox2 failed";
		
		U <= '1';
		A <= '0';
		C <= '1';
		S <= '1';
      wait for 100 ns;	
		
		assert ((dangerous = '0') and (needs_vac = '0')) report "Case Chewbacca1 failed";
		
		U <= '1';
		A <= '0';
		C <= '1';
		S <= '0';
      wait for 100 ns;	
		
		assert ((dangerous = '1') and (needs_vac = '0')) report "Case Chewbacca2 failed";
      wait;
   end process;

END;
