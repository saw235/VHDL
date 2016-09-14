--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:18:50 09/29/2014
-- Design Name:   
-- Module Name:   C:/temp/ZooLab/seven_seg_test.vhd
-- Project Name:  ZooLab
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: seven_seg_display
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
 
ENTITY seven_seg_test IS
END seven_seg_test;
 
ARCHITECTURE behavior OF seven_seg_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT seven_seg_display
    PORT(
         b0 : IN  std_logic;
         b1 : IN  std_logic;
         b2 : IN  std_logic;
         b3 : IN  std_logic;
         A : OUT  std_logic;
         B : OUT  std_logic;
         C : OUT  std_logic;
         D : OUT  std_logic;
         E : OUT  std_logic;
         F : OUT  std_logic;
         G : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal b0 : std_logic := '0';
   signal b1 : std_logic := '0';
   signal b2 : std_logic := '0';
   signal b3 : std_logic := '0';

 	--Outputs
   signal A : std_logic;
   signal B : std_logic;
   signal C : std_logic;
   signal D : std_logic;
   signal E : std_logic;
   signal F : std_logic;
   signal G : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: seven_seg_display PORT MAP (
          b0 => b0,
          b1 => b1,
          b2 => b2,
          b3 => b3,
          A => A,
          B => B,
          C => C,
          D => D,
          E => E,
          F => F,
          G => G
        );

process
   begin		
	
		b3 <= '0';
		b2 <= '0';
		b1 <= '0';
		b0 <= '0';
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		
		assert ((A = '0') and (B = '0') and (C = '0') and (D = '0') and (E = '0') and (F = '0') and (G = '1'))
		report "Case 0 failed"; 
		
		b3 <= '0';
		b2 <= '0';
		b1 <= '0';
		b0 <= '1';
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		assert ((A = '0') and (B = '1') and (C = '1') and (D = '0') and (E = '0') and (F = '0') and (G = '0'))
		report "Case 1 failed";
		
		b3 <= '0';
		b2 <= '0';
		b1 <= '1';
		b0 <= '0';
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		assert ((A = '1') and (B = '1') and (C = '0') and (D = '1') and (E = '1') and (F = '0') and (G = '1'))
		report "Case 2 failed";
		
		
		b3 <= '0';
		b2 <= '0';
		b1 <= '1';
		b0 <= '1';
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		assert ((A = '1') and (B = '1') and (C = '1') and (D = '1') and (E = '0') and (F = '0') and (G = '1'))
		report "Case 3 failed";
		
		b3 <= '0';
		b2 <= '1';
		b1 <= '0';
		b0 <= '0';
		wait for 20 ns;	
      -- hold reset state for 20 ns.
		assert ((A = '0') and (B = '1') and (C = '1') and (D = '0') and (E = '0') and (F = '1') and (G = '1'))
		report "Case 4 failed";
		
      
		b3 <= '0';
		b2 <= '1';
		b1 <= '0';
		b0 <= '1';
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		assert ((A = '1') and (B = '0') and (C = '1') and (D = '1') and (E = '0') and (F = '1') and (G = '1'))
		report "Case 5 failed";
		
		b3 <= '0';
		b2 <= '1';
		b1 <= '1';
		b0 <= '0';
      -- hold reset state for 20 ns.
      wait for 20 ns;
		assert ((A = '1') and (B = '0') and (C = '1') and (D = '1') and (E = '1') and (F = '1') and (G = '1'))
		report "Case 6 failed";
		
		b3 <= '0';
		b2 <= '1';
		b1 <= '1';
		b0 <= '1';
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		assert ((A = '1') and (B = '1') and (C = '1') and (D = '0') and (E = '0') and (F = '0') and (G = '0'))
		report "Case 7 failed";
		
		b3 <= '1';
		b2 <= '0';
		b1 <= '0';
		b0 <= '0';
      -- hold reset state for 20 ns.
      wait for 20 ns;
		assert ((A = '1') and (B = '1') and (C = '1') and (D = '1') and (E = '1') and (F = '1') and (G = '1'))
		report "Case 8 failed";	
		
		b3 <= '1';
		b2 <= '0';
		b1 <= '0';
		b0 <= '1';
      -- hold reset state for 20 ns.
      wait for 20 ns;
		assert ((A = '1') and (B = '1') and (C = '1') and (D = '0') and (E = '0') and (F = '1') and (G = '1'))
		report "Case 9 failed";
		
		b3 <= '1';
		b2 <= '0';
		b1 <= '1';
		b0 <= '0';
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		assert ((A = '1') and (B = '1') and (C = '1') and (D = '0') and (E = '1') and (F = '1') and (G = '1'))
		report "Case A failed";
		
		b3 <= '1';
		b2 <= '0';
		b1 <= '1';
		b0 <= '1';
      -- hold reset state for 20 ns.
      wait for 20 ns;
		assert ((A = '0') and (B = '0') and (C = '1') and (D = '1') and (E = '1') and (F = '1') and (G = '1'))
		report "Case B failed";
		
		b3 <= '1';
		b2 <= '1';
		b1 <= '0';
		b0 <= '0';
      -- hold reset state for 20 ns.
      wait for 20 ns;
		assert ((A = '1') and (B = '0') and (C = '0') and (D = '1') and (E = '1') and (F = '1') and (G = '0'))
		report "Case C failed";
		
		b3 <= '1';
		b2 <= '1';
		b1 <= '0';
		b0 <= '1';
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		assert ((A = '0') and (B = '1') and (C = '1') and (D = '1') and (E = '1') and (F = '0') and (G = '1'))
		report "Case D failed";
		
		b3 <= '1';
		b2 <= '1';
		b1 <= '1';
		b0 <= '0';
      -- hold reset state for 20 ns.
      wait for 20 ns;
		assert ((A = '1') and (B = '0') and (C = '0') and (D = '1') and (E = '1') and (F = '1') and (G = '1'))
		report "Case E failed";
		
		b3 <= '1';
		b2 <= '1';
		b1 <= '1';
		b0 <= '1';
      -- hold reset state for 20 ns.
      wait for 20 ns;
		assert ((A = '1') and (B = '0') and (C = '0') and (D = '0') and (E = '1') and (F = '1') and (G = '1'))
		report "Case F failed";
		

      wait;
   end process;

END;
