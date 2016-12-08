--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:29:04 11/25/2016
-- Design Name:   
-- Module Name:   C:/Users/User/Documents/CMPEN371/ImageFilterProject/Kernel_tb.vhd
-- Project Name:  ImageFilterProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Kernel
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
USE ieee.numeric_std.ALL;
 
ENTITY Kernel_tb IS
END Kernel_tb;
 
ARCHITECTURE behavior OF Kernel_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Kernel
    PORT(
         PxByte : IN  std_logic_vector(3 downto 0);
         ShiftPx : IN  std_logic;
         PxCnt : IN  std_logic_vector(18 downto 0);
         ImgWidth : IN  std_logic_vector(9 downto 0);
         CLK : IN  std_logic;
         CLR : IN  std_logic;
         Px_Out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PxByte : std_logic_vector(3 downto 0) := (others => '0');
   signal ShiftPx : std_logic := '0';
   signal PxCnt : std_logic_vector(18 downto 0) := (others => '0');
   signal ImgWidth : std_logic_vector(9 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal CLR : std_logic := '0';

 	--Outputs
   signal Px_Out : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Kernel PORT MAP (
          PxByte => PxByte,
          ShiftPx => ShiftPx,
          PxCnt => PxCnt,
          ImgWidth => ImgWidth,
          CLK => CLK,
          CLR => CLR,
          Px_Out => Px_Out
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

      PxByte	<= x"0";
		ShiftPx  <= '1';
		PxCnt 	<= std_logic_vector(to_unsigned(0,19));
		ImgWidth <= std_logic_vector(to_unsigned(9,10));
		CLR 		<= '0';

		wait for 10ns;
		
		PxByte	<= x"1";
		PxCnt 	<= std_logic_vector(to_unsigned(1,19));
		
		wait for 10ns;
		
		PxByte	<= x"2";
		PxCnt 	<= std_logic_vector(to_unsigned(2,19));
		
		wait for 10ns;
		
		PxByte	<= x"3";
		PxCnt 	<= std_logic_vector(to_unsigned(3,19));
		
		wait for 10ns;
		
		PxByte	<= x"4";
		PxCnt 	<= std_logic_vector(to_unsigned(4,19));
		
		wait for 10ns;
		
		PxByte	<= x"5";
		PxCnt 	<= std_logic_vector(to_unsigned(5,19));
		
		wait for 10ns;
		
		PxByte	<= x"6";
		PxCnt 	<= std_logic_vector(to_unsigned(6,19));
		
		wait for 10ns;
		
		PxByte	<= x"7";
		PxCnt 	<= std_logic_vector(to_unsigned(7,19));
		
		wait for 10ns;
		
		PxByte	<= x"8";
		PxCnt 	<= std_logic_vector(to_unsigned(8,19));
		
		wait for 10ns;
		
		---------------------------------------------------
		
		PxByte	<= x"0";
		PxCnt 	<= std_logic_vector(to_unsigned(9,19));

		wait for 10ns;
		
		PxByte	<= x"1";
		PxCnt 	<= std_logic_vector(to_unsigned(10,19));
		
		wait for 10ns;
		
		PxByte	<= x"2";
		PxCnt 	<= std_logic_vector(to_unsigned(11,19));
		
		wait for 10ns;
		
		PxByte	<= x"3";
		PxCnt 	<= std_logic_vector(to_unsigned(12,19));
		
		wait for 10ns;
		
		PxByte	<= x"4";
		PxCnt 	<= std_logic_vector(to_unsigned(13,19));
		
		wait for 10ns;
		
		PxByte	<= x"5";
		PxCnt 	<= std_logic_vector(to_unsigned(14,19));
		
		wait for 10ns;
		
		PxByte	<= x"6";
		PxCnt 	<= std_logic_vector(to_unsigned(15,19));
		
		wait for 10ns;
		
		PxByte	<= x"7";
		PxCnt 	<= std_logic_vector(to_unsigned(16,19));
		
		wait for 10ns;
		
		PxByte	<= x"8";
		PxCnt 	<= std_logic_vector(to_unsigned(17,19));
		
		wait for 10ns;
		
		------------------------------------------------
		
		
		PxByte	<= x"A";
		PxCnt 	<= std_logic_vector(to_unsigned(18,19));

		wait for 10ns;
		
		PxByte	<= x"B";
		PxCnt 	<= std_logic_vector(to_unsigned(19,19));
		
		wait for 10ns;
		
		PxByte	<= x"C";
		PxCnt 	<= std_logic_vector(to_unsigned(20,19));
		
		wait for 10ns;
		
		PxByte	<= x"D";
		PxCnt 	<= std_logic_vector(to_unsigned(21,19));

		wait for 10ns;
		
		PxByte	<= x"E";
		PxCnt 	<= std_logic_vector(to_unsigned(22,19));
		
		wait for 10ns;
		
		PxByte	<= x"F";
		PxCnt 	<= std_logic_vector(to_unsigned(23,19));
		
		wait for 10ns;

		PxByte	<= x"A";
		PxCnt 	<= std_logic_vector(to_unsigned(24,19));

		wait for 10ns;
		
		PxByte	<= x"B";
		PxCnt 	<= std_logic_vector(to_unsigned(25,19));
		
		wait for 10ns;
		
		PxByte	<= x"C";
		PxCnt 	<= std_logic_vector(to_unsigned(26,19));
		
		wait for 10ns;		
				 -- All tests are successful if we get this far
      report "***** All tests completed successfully. *****";

      wait;
   end process;

END;
