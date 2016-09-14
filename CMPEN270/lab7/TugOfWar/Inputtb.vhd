--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:52:02 10/30/2014
-- Design Name:   
-- Module Name:   P:/Private/Documents/CMPEN270/lab7/TugOfWar/Inputtb.vhd
-- Project Name:  TugOfWar
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UserInput
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
 
ENTITY Inputtb IS
END Inputtb;
 
ARCHITECTURE behavior OF Inputtb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UserInput
    PORT(
         input : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         input_pulse : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal input_pulse : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UserInput PORT MAP (
          input => input,
          clk => clk,
          rst => rst,
          input_pulse => input_pulse
        );

   -- Clock process definitions
  
  process
   -- Stimulus process
   begin		
    
		Clk <= '1';
		-- hold reset state for 100 ns.
      wait for 100 ns;	

		input <= '1';
		
		wait for 50 ns;
		
		input <= '0';
		wait for 10 ns;
		
		Clk <= '0';
		wait for 100 ns;
		
		input <= '1';
		wait for 50 ns;
		
		Clk <= '1';
		
		wait for 100 ns;
		

      wait;
   end process;

END;
