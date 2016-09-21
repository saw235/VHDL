----------------------------------------------------------------------------
-- Entity:        RippleCarryAdder_4bit_tb
-- Written By:    Saw Xue Zheng
-- Date Created:  8/27/2017
-- Description:   Testbench for RippleCarryAdder_4bit
--
-- Revision History (date, initials, description):
-- 	27 Aug 16, xps5001, file created.

-- Dependencies:
--		RippleCarryAdder_4bit
----------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY RippleCarryAdder_4bit_tb IS
END RippleCarryAdder_4bit_tb;
 
ARCHITECTURE behavioral OF RippleCarryAdder_4bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RippleCarryAdder_4bit
    PORT(
         A 		: IN  std_logic_vector(3 downto 0);
         B 		: IN  std_logic_vector(3 downto 0);
         C_in 	: IN  std_logic;
         C_out : OUT  std_logic;
         SUM 	: OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A 	: std_logic_vector(3 downto 0) := (others => '0');
   signal B 	: std_logic_vector(3 downto 0) := (others => '0');
   signal C_in : std_logic := '0';

 	--Outputs
   signal C_out 	: std_logic;
   signal SUM 		: std_logic_vector(3 downto 0);
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RippleCarryAdder_4bit PORT MAP (
          A 		=> A,
          B 		=> B,
          C_in 	=> C_in,
          C_out 	=> C_out,
          SUM 		=> SUM
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	


      --Test cases with no carry
		
			--Add 0000 to 0000 with no carry, 
		A <= "0000";   B <= "0000";   C_in <= '0';
		wait for 100 ns;
		assert (C_out = '0' and SUM = "0000") 
			report "FAILURE: Expected C_out = '0' and SUM = 0000 " 
			severity failure;
		
			--Add 1111 to 0000 with 0 carry
		A <= "1111";   B <= "0000";   C_in <= '0';
		wait for 100 ns;
		assert (C_out = '0' and SUM = "1111") 
			report "FAILURE: Expected C_out = '0' and SUM = 1111 " 
			severity failure;
			
			--Add 1010 to 0011 with 0 carry
		A <= "1010";   B <= "0011";   C_in <= '0';
		wait for 100 ns;
		assert (C_out = '0' and SUM = "1101") 
			report "FAILURE: Expected C_out = '0' and SUM = 1101 "  
			severity failure;
			
			--Add 1111 to 0001 with 0 carry
		A <= "1111";   B <= "0001";   C_in <= '0';
		wait for 100 ns;
		assert (C_out = '1' and SUM = "0000") 
			report "FAILURE: Expected C_out = '1' and SUM = 0000 " 
			severity failure;	
		
		--Test cases with carry 
			--Add 0000 to 0000 with carry
		A <= "0000";   B <= "0000";   C_in <= '1';
		wait for 100 ns;
		assert (C_out = '0' and SUM = "0001") 
			report "FAILURE: Expected C_out = '0' and SUM = 0001 " 
			severity failure;
		
			--Add 1111 to 0000 with carry
		A <= "1111";   B <= "0000";   C_in <= '1';
		wait for 100 ns;
		assert (C_out = '1' and SUM = "0000") 
			report "FAILURE: Expected C_out = '1' and SUM = 0000 " 
			severity failure;
			
			--Add 1010 to 0011 with carry
		A <= "1010";   B <= "0011";   C_in <= '1';
		wait for 100 ns;
		assert (C_out = '0' and SUM = "1110") 
			report "FAILURE: Expected C_out = '0' and SUM = 1110 " 
			severity failure;
			
			--Add 1111 to 0001 with carry
		A <= "1111";   B <= "0001";   C_in <= '1';
		wait for 100 ns;
		assert (C_out = '1' and SUM = "0001") 
			report "FAILURE: Expected C_out = '1' and SUM = 0001 " 
			severity failure;	
		
		
      wait;
   end process;

END;
