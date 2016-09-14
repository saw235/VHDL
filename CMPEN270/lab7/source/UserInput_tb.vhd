--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:17:50 10/27/2014
-- Design Name:   
-- Module Name:   C:/temp/TugofWar/UserInput_tb.vhd
-- Project Name:  TugofWar
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
 
ENTITY UserInput_tb IS
END UserInput_tb;
 
ARCHITECTURE behavior OF UserInput_tb IS 
 
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
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
