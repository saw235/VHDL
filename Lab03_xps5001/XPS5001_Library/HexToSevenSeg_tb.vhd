----------------------------------------------------------------------------
-- Entity:        HexToSevenSeg_tb
-- Written By:    E. George Walters
-- Date Created:  2 Sep 14
-- Description:   VHDL test bench for HexToSevenSeg
--
-- Revision History (date, initials, description):
-- 	4 September 2016, sxz, fixed test vector for --7
-- Dependencies:
--		HexToSevenSeg
----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL; 

--------------------------------------------------------------------------------
entity HexToSevenSeg_tb is
end    HexToSevenSeg_tb;
--------------------------------------------------------------------------------
 
architecture Behavioral of HexToSevenSeg_tb is 
 
	-- Unit Under Test (UUT)
   component HexToSevenSeg is
		port ( HEX      : in  STD_LOGIC_VECTOR (3 downto 0);
				 SEGMENT  : out STD_LOGIC_VECTOR (0 to 6));
   end component;
    
   --Inputs
   signal HEX : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

 	--Outputs
   signal SEGMENT : STD_LOGIC_VECTOR (0 to 6);
   
   -- Test vector includes input stimuli and expected outputs
   -- HEX      : bits 10..7
   -- SEGMENT : bits 6..0
	-- test vector is HEX & SEGMENT
   type test_vector_type is array (0 to 15) of STD_LOGIC_VECTOR (10 downto 0);
   constant test_vector : test_vector_type := (
      -- HEX    SEGMENT
      "0000" & "0000001", -- 0
      "0001" & "1001111", -- 1
      "0010" & "0010010", -- 2
      "0011" & "0000110", -- 3
      "0100" & "1001100", -- 4
      "0101" & "0100100", -- 5
      "0110" & "0100000", -- 6
      "0111" & "0001111", -- 7
      "1000" & "0000000", -- 8
      "1001" & "0000100", -- 9
      "1010" & "0001000", -- A
      "1011" & "1100000", -- B
      "1100" & "0110001", -- C
      "1101" & "1000010", -- D
      "1110" & "0110000", -- E
      "1111" & "0111000"  -- F
   );
 
begin

	-- Instantiate the Unit Under Test (UUT)
   uut: HexToSevenSeg port map (
		     HEX      => HEX,
			  SEGMENT  => SEGMENT
	     );

   -- Stimulus process
   stim_proc: process
   begin

      -- hold reset state for 100 ns.
      wait for 100 ns;
		
		-- run through all test vectors
      for i in test_vector'Range loop
      
         -- Assign test inputs
         HEX <= test_vector(i)(10 downto 7);
         
         -- Compare outputs to expected values
         wait for 2ns;
         assert (SEGMENT = test_vector(i)(6 downto 0))
            report "***** Test failed. *****"
            severity Failure;
      end loop;
      
      -- All tests are successful if we get this far
      report "***** All tests completed successfully. *****";
      wait;
   end process;

end Behavioral;
