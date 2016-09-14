--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:40:39 10/07/2014
-- Design Name:   
-- Module Name:   P:/Private/Documents/CMPEN270/lab4/ZooLab/UAC_2_BIN_tb.vhd
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
 
ENTITY UAC_2_BIN_tb IS
END UAC_2_BIN_tb;
 
ARCHITECTURE behavior OF UAC_2_BIN_tb IS 
 
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

  
 process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      

      wait;
   end process;

END;
