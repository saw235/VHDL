----------------------------------------------------------------------------
-- Entity:        Decoder3to8_tb
-- Written By:    Saw Xue Zheng
-- Date Created:  9/11/2016
-- Description:   Testbench for Decoder3to8
--
-- Revision History (date, initials, description):
-- 	11 Sept 16, xps5001, file created.

-- Dependencies:
--		Decoder3to8
----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Decoder3to8_tb IS
END Decoder3to8_tb;
 
ARCHITECTURE behavior OF Decoder3to8_tb IS 
 
 
    COMPONENT Decoder3to8
    PORT(
         X  : IN  std_logic_vector(2 downto 0);
         EN : IN  std_logic;
         Y  : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X  : std_logic_vector(2 downto 0) := (others => '0');
   signal EN : std_logic := '0';

 	--Outputs
   signal Y : std_logic_vector(7 downto 0);

	type test_vector_type is array(0 to 15) of STD_LOGIC_VECTOR (11 downto 0);
	constant test_vector : test_vector_type := (
	--X 		EN			Y
	"000" & "0" & "00000000",
	"001" & "0" & "00000000",
	"010" & "0" & "00000000",
	"011" & "0" & "00000000",
	"100" & "0" & "00000000",
	"101" & "0" & "00000000",
	"110" & "0" & "00000000",
	"011" & "0" & "00000000",

	"000" & "1" & "00000001",
	"001" & "1" & "00000010",
	"010" & "1" & "00000100",
	"011" & "1" & "00001000",
	"100" & "1" & "00010000",
	"101" & "1" & "00100000",
	"110" & "1" & "01000000",
	"111" & "1" & "10000000"
	
	);
 
BEGIN
 
   uut: Decoder3to8 PORT MAP (
          X  => X,
          EN => EN,
          Y  => Y
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		for i in test_vector'Range loop
			X 	<= test_vector(i)(11 downto 9);
			EN <= test_vector(i)(8);

			wait for 20ns;
			
			assert( Y = test_vector(i)(7 downto 0))
				report "***** Test failed. *****"
            severity Failure;
		end loop;
		
		 -- All tests are successful if we get this far
      report "***** All tests completed successfully. *****";
      wait;
   end process;

END;
