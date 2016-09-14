--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:48:22 10/13/2014
-- Design Name:   
-- Module Name:   P:/Private/Documents/CMPEN270/lab5/dff_test/Latch_test.vhd
-- Project Name:  dff_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: active_low_sr_latch
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Latch_test IS
END Latch_test;
 
ARCHITECTURE behavior OF Latch_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT active_low_sr_latch
    PORT(
         S_bar : IN  std_logic;
         R_bar : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal S_bar : std_logic := '0';
   signal R_bar : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: active_low_sr_latch PORT MAP (
          S_bar => S_bar,
          R_bar => R_bar,
          Q => Q
        );

   -- Clock process definitions
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
