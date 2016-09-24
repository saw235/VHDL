
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Reg_test IS
END Reg_test;
 
ARCHITECTURE behavior OF Reg_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Reg
    PORT(
         D : IN  std_logic_vector(8 downto 0);
         LOAD : IN  std_logic;
         CLK : IN  std_logic;
         CLR : IN  std_logic;
         Q : OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic_vector(8 downto 0) := (others => '0');
   signal LOAD : std_logic := '0';
   signal CLK : std_logic := '0';
   signal CLR : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(8 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Reg PORT MAP (
          D => D,
          LOAD => LOAD,
          CLK => CLK,
          CLR => CLR,
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

      -- insert stimulus here 

      wait;
   end process;

END;
