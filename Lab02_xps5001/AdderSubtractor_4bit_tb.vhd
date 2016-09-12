----------------------------------------------------------------------------
-- Entity:        AdderSubtractor_4bit_tb
-- Written By:    Saw Xue Zheng
-- Date Created:  8/27/2017
-- Description:   Testbench for AdderSubtractor_4bit
--
-- Revision History (date, initials, description):
-- 	27 Aug 16, xps5001, file created.

-- Dependencies:
--		AdderSubtractor_4bit
----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; --To manipulate integers
 
ENTITY AdderSubtractor_4bit_tb IS
END AdderSubtractor_4bit_tb;
 
ARCHITECTURE behavior OF AdderSubtractor_4bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AdderSubtractor_4bit
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         SUBTRACT : IN  std_logic;
         SUM : OUT  std_logic_vector(3 downto 0);
         OVERFLOW : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal SUBTRACT : std_logic := '0';
	
 	--Outputs
   signal SUM : std_logic_vector(3 downto 0);
   signal OVERFLOW : std_logic;

	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AdderSubtractor_4bit PORT MAP (
          A => A,
          B => B,
          SUBTRACT => SUBTRACT,
          SUM => SUM,
          OVERFLOW => OVERFLOW
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		-- TEST CASE: Adding
			-- Input: A = -8 to 7
			-- 		 B = -8 to 7
			--		    SUBTRACT = FALSE
			--
			-- Expected Output: IF  -8< A+B < 7 , OVERFLOW = FALSE , SUM = A + B
			--						  ELSE OVERFLOW = TRUE, SUM = 'X' 
		
		for I in -8 to 7 loop
			for J in -8 to 7 loop
				
				A <= std_logic_vector( to_signed( I, 4));   B <= std_logic_vector( to_signed( J, 4));   SUBTRACT <= '0';
				wait for 10 ns;
				
				if (( I+J > 7 ) or (I+J < -8)) then
					assert (OVERFLOW = '1') 
					report "FAILURE: DID NOT MEET OVERFLOW REQUIREMENTS" 
					severity failure;
				else
					assert (OVERFLOW = '0' and SUM = std_logic_vector( to_signed( I+J, 4))) 
					report "FAILURE: DID NOT MEET ASSERTION REQUIREMENTS" 
					severity failure;
				end if;
			end loop;
		end loop;
		
		-- TEST CASE: Subtracting
			-- Input: A = -8 to 7
			-- 		 B = -8 to 7
			--		    SUBTRACT = TRUE
			--
			-- Expected Output: IF  -8< A-B < 7 , OVERFLOW = FALSE , SUM = A - B
			--						  ELSE OVERFLOW = TRUE, SUM = 'X' 
			
		for I in -8 to 7 loop
			for J in -8 to 7 loop
				
				A <= std_logic_vector( to_signed( I, 4));   B <= std_logic_vector( to_signed( J, 4));   SUBTRACT <= '1';
				wait for 10 ns;
				
				if (( I-J > 7 ) or (I-J < -8)) then
					assert (OVERFLOW = '1') 
					report "FAILURE: DID NOT MEET OVERFLOW REQUIREMENTS" 
					severity failure;
				else
					assert (OVERFLOW = '0' and SUM = std_logic_vector( to_signed( I-J, 4))) 
					report "FAILURE: DID NOT MEET ASSERTION REQUIREMENTS" 
					severity failure;
				end if;
			end loop;
		end loop;
		
			
		report "All test cases are completed.";
      wait;
   end process;

END;
