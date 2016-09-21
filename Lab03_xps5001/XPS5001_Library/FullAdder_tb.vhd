----------------------------------------------------------------------------
-- Entity:        FullAdder_tb
-- Written By:    E. George Walters
-- Date Created:  18 Aug 13
-- Description:   VHDL testbench for FullAdder
--
-- Revision History (date, initials, description):
--   26 Aug 14, egw100, Modified port signal names to reflect course standard
--   27 Aug 16, xps5001, Added exhaustive test cases
-- 
-- Dependencies:
--   FullAdder
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity FullAdder_tb is
end    FullAdder_tb;
----------------------------------------------------------------------------

architecture Behavioral of FullAdder_tb is

	-- Unit Under Test (UUT)
	component FullAdder is
		Port ( A    	: in  STD_LOGIC;
				 B   	 	: in  STD_LOGIC;
				 C_in    : in  STD_LOGIC;
				 C_out   : out STD_LOGIC;
				 Sum 		: out STD_LOGIC);
	end component FullAdder;

   --Inputs
   signal A    : std_logic := '0';
   signal B    : std_logic := '0';
   signal C_in : std_logic := '0';

 	--Outputs
   signal C_out : std_logic;
   signal SUM   : std_logic;
	
begin

	-- Instantiate the Unit Under Test (UUT)
   uut: FullAdder port map (
          A     => A,
          B     => B,
          C_in  => C_in,
          C_out => C_out,
          Sum   => SUM
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
		A <= '0';   B <= '0';   C_in <= '0';
		wait for 100 ns;
		assert (C_out = '0' and SUM = '0') 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
		
		A <= '0';   B <= '0';   C_in <= '1';
		wait for 100 ns;
		assert (C_out = '0' and SUM = '1') 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
		
		A <= '0';   B <= '1';   C_in <= '0';
		wait for 100 ns;
		assert (C_out = '0' and SUM = '1') 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
			
		A <= '0';   B <= '1';   C_in <= '1';
		wait for 100 ns;
		assert (C_out = '1' and SUM = '0') 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
			
		A <= '1';   B <= '0';   C_in <= '0';
		wait for 100 ns;
		assert (C_out = '0' and SUM = '1') 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
			
		A <= '1';   B <= '0';   C_in <= '1';
		wait for 100 ns;
		assert (C_out = '1' and SUM = '0') 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
			
		A <= '1';   B <= '1';   C_in <= '0';
		wait for 100 ns;
		assert (C_out = '1' and SUM = '0') 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
			
		A <= '1';   B <= '1';   C_in <= '1';
		wait for 100 ns;
		assert (C_out = '1' and SUM = '1') 
			report "FAILURE: C_out and/or SUM does not equal expected value." 
			severity failure;
		
      wait;
		
   end process;

end Behavioral;

