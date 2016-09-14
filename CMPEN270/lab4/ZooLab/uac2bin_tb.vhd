--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:49:49 10/07/2014
-- Design Name:   
-- Module Name:   P:/Private/Documents/CMPEN270/lab4/ZooLab/uac2bin_tb.vhd
-- Project Name:  ZooLab
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UAC_2_display
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
 
ENTITY uac2bin_tb IS
END uac2bin_tb;
 
ARCHITECTURE behavior OF uac2bin_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UAC_2_display
    PORT(
         U : IN  std_logic;
         A : IN  std_logic;
         C : IN  std_logic;
         b0 : OUT  std_logic;
         b1 : OUT  std_logic;
         b2 : OUT  std_logic;
         b3 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal U : std_logic := '0';
   signal A : std_logic := '0';
   signal C : std_logic := '0';

 	--Outputs
   signal b0 : std_logic;
   signal b1 : std_logic;
   signal b2 : std_logic;
   signal b3 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UAC_2_display PORT MAP (
          U => U,
          A => A,
          C => C,
          b0 => b0,
          b1 => b1,
          b2 => b2,
          b3 => b3
        );

  

   -- Stimulus process
 process
   begin		
      -- hold reset state for 100 ns.
		U <= '0';
		A <= '0';
		C <= '0';

      wait for 100 ns;	
	assert (b0 = '0' and b1 = '1' and b2 = '0' and b3 = '1') report "case 0 failed";
		
		U <= '0';
		A <= '0';
		C <= '1';
		
      wait for 100 ns;	
		
		
			assert (b0 = '1' and b1 = '1' and b2 = '0' and b3 = '1') report "case 1 failed";
	
		U <= '0';
		A <= '1';
		C <= '0';
		
      wait for 100 ns;	
		
			assert (b0 = '0' and b1 = '1' and b2 = '1' and b3 = '1') report "case 2 failed";
		
		U <= '0';
		A <= '1';
		C <= '1';
		
      wait for 100 ns;	
			assert (b0 = '1' and b1 = '0' and b2 = '1' and b3 = '1') report "case 3 failed";
		
		U <= '1';
		A <= '0';
		C <= '0';
		
      wait for 100 ns;	
		
		assert (b0 = '1' and b1 = '1' and b2 = '1' and b3 = '1') report "case 4 failed";
		U <= '1';
		A <= '0';
		C <= '1';
		
      wait for 100 ns;	
		
			assert (b0 = '0' and b1 = '0' and b2 = '1' and b3 = '1') report "case 5 failed";
		U <= '1';
		A <= '1';
		C <= '0';
		
      wait for 100 ns;	
		
			assert (b0 = '0' and b1 = '1' and b2 = '1' and b3 = '1') report "case 6 failed";
		U <= '1';
		A <= '1';
		C <= '1';
		
      wait for 100 ns;	
		
			assert (b0 = '0' and b1 = '0' and b2 = '1' and b3 = '1') report "case 7 failed";
		
		
		
      wait;
   end process;

END;
