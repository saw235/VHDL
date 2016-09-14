------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 09/22/14
-- Lab # and name	: Lab2 Testbench - Combinational
-- Student 1		: Saw Xue Zheng
-- Student 2		: Ryan Kelley

-- Description		: Test the combined circuit
--						  

-- Changes 
-- 			- Version 1.1 (added 9 test case)

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY circuit_test IS
END circuit_test;
 
ARCHITECTURE behavior OF circuit_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT combination_circuit
    PORT(
         sw1 : IN  std_logic;
         sw2 : IN  std_logic;
         sw3 : IN  std_logic;
         sw4 : IN  std_logic;
         p : IN  std_logic;
         b : IN  std_logic;
         d : IN  std_logic;
         F : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sw1_tb : std_logic ;
   signal sw2_tb : std_logic ;
   signal sw3_tb : std_logic ;
   signal sw4_tb : std_logic ;
   signal p_tb : std_logic ;
   signal b_tb : std_logic ;
   signal d_tb : std_logic ;

 	--Outputs
   signal F_tb : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   circuittest: combination_circuit PORT MAP (
          sw1 => sw1_tb,
          sw2 => sw2_tb,
          sw3 => sw3_tb,
          sw4 => sw4_tb,
          p => p_tb,
          b => b_tb,
          d => d_tb,
          F => F_tb
        );

 process
   begin		
			-- case A ignition_safety is 0
			b_tb	<= '0'; 
			d_tb	<= '0';
			p_tb 	<= '0';
			
					-- case A0  (neither key are correct combination) try 0 1 1 1 
			
			sw1_tb <= '0';
			sw2_tb <= '1';
			sw3_tb <= '1';
			sw4_tb <= '1';
			
			wait for 20 ns;
			
			assert (F_tb = '0') report "Case A0 failed";

					-- case A1 (Correct Security Key)
			sw1_tb <= '0';
			sw2_tb <= '1';
			sw3_tb <= '0';
			sw4_tb <= '1';
			
			wait for 20 ns;
			
					-- case A2 (Correct ServiceMode Key)
			assert (F_tb = '0') report "Case A1 failed";
			
			sw1_tb <= '0';
			sw2_tb <= '1';
			sw3_tb <= '1';
			sw4_tb <= '0';
			
			wait for 20 ns;
			
			assert (F_tb = '1') report "Case A2 failed";
			
			-- case B ignition_safety is 1 b, d, p is 001
			
			b_tb	<= '0'; 
			d_tb	<= '0';
			p_tb 	<= '1';
			
			-- case B0  (neither key are correct combination) try 0 1 1 1 
			
			
			sw1_tb <= '0';
			sw2_tb <= '1';
			sw3_tb <= '1';
			sw4_tb <= '1';
			
			wait for 20 ns;
			
			assert (F_tb = '0') report "Case B0 failed";

					-- case B1 (Correct Security Key)
			sw1_tb <= '0';
			sw2_tb <= '1';
			sw3_tb <= '0';
			sw4_tb <= '1';
			
			wait for 20 ns;
			
					-- case B2 (Correct ServiceMode Key)
			assert (F_tb = '1') report "Case B1 failed";
			
			sw1_tb <= '0';
			sw2_tb <= '1';
			sw3_tb <= '1';
			sw4_tb <= '0';
			
			wait for 20 ns;
			
			assert (F_tb = '1') report "Case B2 failed";
			
			-- case C ignition_safety is 1 b, d, p is 110
			
			b_tb	<= '1'; 
			d_tb	<= '1';
			p_tb 	<= '0';
			
			-- case C0  (neither key are correct combination) try 0 1 1 1 
			
			
			sw1_tb <= '0';
			sw2_tb <= '1';
			sw3_tb <= '1';
			sw4_tb <= '1';
			
			wait for 20 ns;
			
			assert (F_tb = '0') report "Case C0 failed";

					-- case C1 (Correct Security Key)
			sw1_tb <= '0';
			sw2_tb <= '1';
			sw3_tb <= '0';
			sw4_tb <= '1';
			
			wait for 20 ns;
			
					-- case C2 (Correct ServiceMode Key)
			assert (F_tb = '1') report "Case C1 failed";
			
			sw1_tb <= '0';
			sw2_tb <= '1';
			sw3_tb <= '1';
			sw4_tb <= '0';
			
			wait for 20 ns;
			
			assert (F_tb = '1') report "Case C2 failed";
			

      wait;
   end process;

end behavior;
