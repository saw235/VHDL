--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:47:57 11/25/2016
-- Design Name:   
-- Module Name:   C:/Users/User/Documents/CMPEN371/ImageFilterProject/Kernel_tb2.vhd
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
 
ENTITY Kernel_tb2 IS
END Kernel_tb2;
 
ARCHITECTURE behavior OF Kernel_tb2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Kernel
	 Generic ( constant imgWidth 	 		: positive := 9;
				  constant DATA_WIDTH 		: positive := 4;
				  constant PxPos_bitwidth 	: positive := 19);
    Port ( PxByte 	: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           ShiftPx 	: in  STD_LOGIC;
           PxCnt 		: in  STD_LOGIC_VECTOR (PxPos_bitwidth - 1 downto 0);
			  CLK			: in  STD_LOGIC;
			  CLR			: in  STD_LOGIC;
			  SEL			: in 	STD_LOGIC_VECTOR ( 1 downto 0);
			  CONV_OK	: out STD_LOGIC;
           Px_Out 	: out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0));
    END COMPONENT;
    

   --Inputs
   signal PxByte : std_logic_vector(3 downto 0) := (others => '0');
   signal ShiftPx : std_logic := '0';
   signal PxCnt : std_logic_vector(18 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal CLR : std_logic := '0';
	signal SEL : std_logic_vector( 1 downto 0) := "01";

 	--Outputs
   signal Px_Out : std_logic_vector(3 downto 0);
	signal Conv_ok : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Kernel PORT MAP (
          PxByte => PxByte,
          ShiftPx => ShiftPx,
          PxCnt => PxCnt,
          CLK => CLK,
          CLR => CLR,
			 SEL => SEL,
			 CONV_OK => CONV_OK,
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
		
		------------------------------------------------
		
		
		PxByte	<= x"C";
		PxCnt 	<= std_logic_vector(to_unsigned(27,19));

		wait for 10ns;
		
		PxByte	<= x"C";
		PxCnt 	<= std_logic_vector(to_unsigned(28,19));
		
		wait for 10ns;
		
		PxByte	<= x"E";
		PxCnt 	<= std_logic_vector(to_unsigned(29,19));
		
		wait for 10ns;
		
		PxByte	<= x"C";
		PxCnt 	<= std_logic_vector(to_unsigned(30,19));

		wait for 10ns;
		
		PxByte	<= x"C";
		PxCnt 	<= std_logic_vector(to_unsigned(31,19));
		
		wait for 10ns;
		
		PxByte	<= x"C";
		PxCnt 	<= std_logic_vector(to_unsigned(32,19));
		
		wait for 10ns;

		PxByte	<= x"C";
		PxCnt 	<= std_logic_vector(to_unsigned(33,19));

		wait for 10ns;
		
		PxByte	<= x"C";
		PxCnt 	<= std_logic_vector(to_unsigned(34,19));
		
		wait for 10ns;
		
		PxByte	<= x"C";
		PxCnt 	<= std_logic_vector(to_unsigned(35,19));
		
		wait for 10ns;		


		-- All tests are successful if we get this far
      wait;
   end process;

END;
