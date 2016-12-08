--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:15:15 11/26/2016
-- Design Name:   
-- Module Name:   C:/Users/User/Documents/CMPEN371/ImageFilterProject/conv_unit_pipelined_tb.vhd
-- Project Name:  ImageFilterProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: conv_unit_pipelined
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
 
ENTITY conv_unit_pipelined_tb IS
END conv_unit_pipelined_tb;
 
ARCHITECTURE behavior OF conv_unit_pipelined_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT conv_unit_pipelined
    PORT(
         Q0 : IN  std_logic_vector(3 downto 0);
         Q1 : IN  std_logic_vector(3 downto 0);
         Q2 : IN  std_logic_vector(3 downto 0);
         Q3 : IN  std_logic_vector(3 downto 0);
         Q4 : IN  std_logic_vector(3 downto 0);
         Q5 : IN  std_logic_vector(3 downto 0);
         Q6 : IN  std_logic_vector(3 downto 0);
         Q7 : IN  std_logic_vector(3 downto 0);
         Q8 : IN  std_logic_vector(3 downto 0);
         CLK : IN  std_logic;
         SEL : IN  std_logic_vector(1 downto 0);
			CONV_START : in STD_LOGIC;
			CONV_OK : out STD_LOGIC;	
         Q : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Q0 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q1 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q2 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q3 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q4 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q5 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q6 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q7 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q8 : std_logic_vector(3 downto 0) := (others => '0');
	signal CONV_START : STD_LOGIC := '0';
   signal CLK : std_logic := '0';
   signal SEL : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal CONV_OK : std_logic;
   signal Q : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: conv_unit_pipelined PORT MAP (
          Q0 => Q0,
          Q1 => Q1,
          Q2 => Q2,
          Q3 => Q3,
          Q4 => Q4,
          Q5 => Q5,
          Q6 => Q6,
          Q7 => Q7,
          Q8 => Q8,
          CLK => CLK,
          SEL => SEL,
			 CONV_START => CONV_START,
          CONV_OK => CONV_OK,
          Q => Q
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
	

      wait for CLK_period*10;

		SEL <= "00";
		Q0 <= x"2";
		Q1 <= x"3";
		Q2 <= x"4";
		Q3 <= x"C";
		Q4 <= x"D";
		Q5 <= x"E";
		Q6 <= x"E";
		Q7 <= x"C";
		Q8 <= x"C";
		
		CONV_START <= '1';
		
		wait for 10 ns;
		
		CONV_START <= '0';
		
		wait until (CONV_OK = '1');
		wait for 2ns;
				assert (Q = x"E")
            report "***** Test failed. *****"
            severity Failure;
		
		Q0 <= x"1";
		Q1 <= x"2";
		Q2 <= x"3";
		Q3 <= x"1";
		Q4 <= x"2";
		Q5 <= x"3";
		Q6 <= x"1";
		Q7 <= x"2";
		Q8 <= x"3";
		
		CONV_START <= '1';
		
		wait for 10 ns;
		
		CONV_START <= '0';
		
		wait until CONV_OK = '1';
				wait for 2ns;
				assert (Q = x"0")
            report "***** Test failed. *****"
            severity Failure;
		
      wait;
   end process;

END;
