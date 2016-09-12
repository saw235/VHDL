----------------------------------------------------------------------------
-- Entity:        Mux4to1_4bit_tb
-- Written By:    Saw Xue Zheng
-- Date Created:  9/4/2016
-- Description:   Testbench for Mux4to1_4bit
--
-- Revision History (date, initials, description):
-- 	4 September 16, xps5001, file created.

-- Dependencies:
--		Mux4to1_4bit
----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Mux4to1_4bit_tb IS
END Mux4to1_4bit_tb;
 
ARCHITECTURE behavior OF Mux4to1_4bit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux4to1_4bit
    PORT(
         X0 : IN  std_logic_vector(3 downto 0);
         X1 : IN  std_logic_vector(3 downto 0);
         X2 : IN  std_logic_vector(3 downto 0);
         X3 : IN  std_logic_vector(3 downto 0);
         SEL : IN  std_logic_vector(1 downto 0);
         Y : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X0 : std_logic_vector(3 downto 0) := (others => '0');
   signal X1 : std_logic_vector(3 downto 0) := (others => '0');
   signal X2 : std_logic_vector(3 downto 0) := (others => '0');
   signal X3 : std_logic_vector(3 downto 0) := (others => '0');
   signal SEL : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Y : std_logic_vector(3 downto 0);
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux4to1_4bit PORT MAP (
          X0 => X0,
          X1 => X1,
          X2 => X2,
          X3 => X3,
          SEL => SEL,
          Y => Y
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		
		for I in 0 to 15 loop 
			X0 <= STD_LOGIC_VECTOR(TO_UNSIGNED(I,4));
			X1 <= "0000";
			X2 <= "0000";
			X3 <= "0000";
			SEL <= "00";
			wait for 10 ns;
			assert (Y = X0) report "Test failed for X0." severity failure;
		end loop;
		
		for I in 0 to 15 loop 
			X0 <= "0000";
			X1 <= STD_LOGIC_VECTOR(TO_UNSIGNED(I,4));
			X2 <= "0000";
			X3 <= "0000";
			SEL <= "01";
			wait for 10 ns;
			assert (Y = X1) report "Test failed for X1." severity failure;
		end loop;
		
		for I in 0 to 15 loop 
			X0 <= "0000";
			X1 <= "0000";
			X2 <= STD_LOGIC_VECTOR(TO_UNSIGNED(I,4));
			X3 <= "0000";
			SEL <= "10";
			wait for 10 ns;
			assert (Y = X2) report "Test failed for X2." severity failure;
		end loop;
		
		for I in 0 to 15 loop 
			X0 <= "0000";
			X1 <= "0000";
			X2 <= "0000";
			X3 <= STD_LOGIC_VECTOR(TO_UNSIGNED(I,4));
			SEL <= "11";
			wait for 10 ns;
			assert (Y = X3) report "Test failed for X3." severity failure;
		end loop;
		
		report "All tests completed successfully!";
		
      wait;
   end process;

END;
