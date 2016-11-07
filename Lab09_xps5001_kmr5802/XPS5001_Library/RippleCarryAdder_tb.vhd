----------------------------------------------------------------------------
-- Entity:        RippleCarryAdder_tb
-- Written By:    Saw Xue Zheng
-- Date Created:  9/17/2017
-- Description:   Testbench for RippleCarryAdder

-- Revision History (date, initials, description):
-- 	17 Sept 16, xps5001, file created.

-- Dependencies:
--		RippleCarryAdder
----------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY RippleCarryAdder_tb IS
END RippleCarryAdder_tb;
 
ARCHITECTURE behavioral OF RippleCarryAdder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
Component RippleCarryAdder
	 generic ( n: integer);
    Port ( A 		: in  STD_LOGIC_VECTOR (n-1 downto 0);
           B 		: in  STD_LOGIC_VECTOR (n-1 downto 0);
           C_in 	: in  STD_LOGIC;
           C_out 	: out  STD_LOGIC;
           SUM 	: out  STD_LOGIC_VECTOR (n-1 downto 0));
end component;

   --Inputs
   signal A 	: std_logic_vector(3 downto 0) := (others => '0');
   signal B 	: std_logic_vector(3 downto 0) := (others => '0');
   signal C_in : std_logic := '0';

 	--Outputs
   signal C_out : std_logic;
   signal SUM	 : std_logic_vector(3 downto 0);
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RippleCarryAdder 
	
	--instantiate a 4-bit adder
	GENERIC MAP ( N=> 4) 
	PORT MAP (
          A		 	=> A (3 downto 0),
          B 		=> B (3 downto 0),
          C_in 	=> C_in,
          C_out	=> C_out,
          SUM 		=> SUM (3 downto 0)
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
