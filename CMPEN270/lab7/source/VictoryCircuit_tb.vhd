--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:19:41 10/27/2014
-- Design Name:   
-- Module Name:   C:/temp/TugofWar/VictoryCircuit_tb.vhd
-- Project Name:  TugofWar
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: VictoryCircuit
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
 
ENTITY VictoryCircuit_tb IS
END VictoryCircuit_tb;
 
ARCHITECTURE behavior OF VictoryCircuit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT VictoryCircuit
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         LeftBt : IN  std_logic;
         RightBt : IN  std_logic;
         LeftMLED : IN  std_logic;
         RightMLED : IN  std_logic;
         out0 : OUT  std_logic;
         out1 : OUT  std_logic;
         out2 : OUT  std_logic;
         out3 : OUT  std_logic;
         anode : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal LeftBt : std_logic := '0';
   signal RightBt : std_logic := '0';
   signal LeftMLED : std_logic := '0';
   signal RightMLED : std_logic := '0';

 	--Outputs
   signal out0 : std_logic;
   signal out1 : std_logic;
   signal out2 : std_logic;
   signal out3 : std_logic;
   signal anode : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: VictoryCircuit PORT MAP (
          clk => clk,
          rst => rst,
          LeftBt => LeftBt,
          RightBt => RightBt,
          LeftMLED => LeftMLED,
          RightMLED => RightMLED,
          out0 => out0,
          out1 => out1,
          out2 => out2,
          out3 => out3,
          anode => anode
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
	
process
	begin
	
	
	end;
END;
