------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 09/11/14
-- Lab # and name	: Lab2 Testbench - Ignition Safety circuit
-- Student 1		: Saw Xue Zheng
-- Student 2		: Ryan Kelley

-- Description		: Provides all 2^3=8 test cases in 20 ns (50 MHz) intervals
--						: Run time is 160 ns
--						  

-- Changes 
-- 			- Version 1.1 (added 6 more test case and mapped s to s_tb)

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------

-- .*********** WARNING for CMPEN 270 Students ****************
-- 	.A large portion of VHDL syntax found in a testbench cannot be used to target a FPGA! 
-- 	.Do not use anything you find inside the "process" portion of the testbench in non-testbench VHDL unless told otherwise.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ignition_safety_tb is

-- .NOTICE: Testbenches DO NOT have inputs and outputs!

end ignition_safety_tb;

 architecture ignition_safety_tb_a of ignition_safety_tb is


	-------------------------------
	-- Component Declarations
	-------------------------------
	component ignition_safety is port
		( 
			b 		: in std_logic		; -- Seat Belt sensor input
			d 		: in std_logic		; -- door latch sensor input
			p 		: in std_logic 	; -- parking brake sensor input
			s  	: out std_logic	  -- ignition safety circuit output
		);
	end component;
	
	-------------------------------
	-- Internal Signal Declarations
	-------------------------------
	signal b_tb 	: std_logic; -- testbench signal to stimulate fa input 'b'
	signal d_tb 	: std_logic; -- testbench signal to stimulate fa input 'd'
	signal p_tb 	: std_logic; -- testbench signal to stimulate fa input 'p'
	signal s_tb		: std_logic; -- testbench signal to simulate output
	
	
begin
	
	-----------------------------------
	-- Component Instantiations
	-----------------------------------
	safety1: ignition_safety port map --safety1 is the instance name
		(
			b => b_tb		, 
			d => d_tb		,
			p => p_tb		,
			s => s_tb		 -- connecting outputs to the testbench is optional, depending on the type of TB.

		);
	
	----------------------------------------
	-- Begin Testbench Stimulus 
	----------------------------------------
	
	
	process  -- No Sensitivity list necessary for this TB - but some may need one. 
		begin 
		
			-- Initialize input signals to 0 @ time = 0ns (Test Case #1)
			b_tb 	<= '0'; 
			d_tb	<= '0';
			p_tb 	<= '0';
			
			wait for 20 ns;
			
			assert (s_tb = '0') report "Case 0 failed";
			
			-- Test Case #1 @ time = 20ns   
			
			b_tb 	<= '0';
			d_tb 	<= '0';
			p_tb 	<= '1';
			
			wait for 20 ns;
			assert (s_tb = '1') report "Case 1 failed";
			-- Test Case #2 @ time = 40ns
			
			b_tb 	<= '0';
			d_tb	<= '1';
			p_tb 	<= '0';
			
			wait for 20 ns;
			assert (s_tb = '0') report "Case 2 failed";
			
			-- Test Case #3 @ time = 60ns
			
			b_tb 	<= '0';
			d_tb	<= '1';
			p_tb 	<= '1';
			
			wait for 20 ns;
			assert (s_tb = '0') report "Case 3 failed";
			-- Test Case #4 @ time = 80ns

			b_tb 	<= '1';
			d_tb	<= '0';
			p_tb 	<= '0';
			
			wait for 20 ns;
			assert (s_tb = '0') report "Case 4 failed";
			
			-- Test Case #5 @ time = 100ns

			b_tb 	<= '1';
			d_tb 	<= '0';
			p_tb 	<= '1';
			wait for 20 ns;
			assert (s_tb = '0') report "Case 5 failed";
			
			-- Test Case #6 @ time = 120ns

			b_tb 	<= '1';
			d_tb	<= '1';
			p_tb 	<= '0';
			
			wait for 20 ns;
			assert (s_tb = '1') report "Case 6 failed";
			-- Test Case #7 @ time = 140ns
			b_tb 	<= '1';
			d_tb	<= '1';
			p_tb 	<= '1';
			
			wait for 20 ns;
			assert (s_tb = '0') report "Case 7 failed";
			
			----------------------------------------------------------------------------------------------------------------------
			-- End of Simulation House Keeping!
			-- (1) Must wait one more test case interval to provide simulator with time to process the last test case  
			-- (2) Also need one final wait statement to force the simulator to remain inside this testbench process (endlessly)
			-- until the user (designer, tester, etc.) ends the simulation (using the Isim simulation run time property)
			-----------------------------------------------------------------------------------------------------------------------
		
						
			wait;

		end process; 

end ignition_safety_tb_a;

