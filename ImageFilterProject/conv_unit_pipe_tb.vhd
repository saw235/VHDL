LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY conv_unit_pipe_tb IS
END conv_unit_pipe_tb;
 
ARCHITECTURE behavior OF conv_unit_pipe_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT conv_unit_piped
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         Q0 : IN  std_logic_vector(3 downto 0);
         Q1 : IN  std_logic_vector(3 downto 0);
         Q2 : IN  std_logic_vector(3 downto 0);
         Q3 : IN  std_logic_vector(3 downto 0);
         Q4 : IN  std_logic_vector(3 downto 0);
         Q5 : IN  std_logic_vector(3 downto 0);
         Q6 : IN  std_logic_vector(3 downto 0);
         Q7 : IN  std_logic_vector(3 downto 0);
         Q8 : IN  std_logic_vector(3 downto 0);
			CONV_START : in 	STD_LOGIC;				
         SEL : IN  std_logic_vector(1 downto 0);
         CONV_OK : out STD_LOGIC;
			Q : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal Q0 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q1 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q2 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q3 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q4 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q5 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q6 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q7 : std_logic_vector(3 downto 0) := (others => '0');
   signal Q8 : std_logic_vector(3 downto 0) := (others => '0');
   signal SEL : std_logic_vector(1 downto 0) := (others => '0');
	signal CONV_START	:  STD_LOGIC := '0';	

 	--Outputs
   signal Q : std_logic_vector(3 downto 0);
	signal CONV_OK : STD_LOGIC;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: conv_unit_piped PORT MAP (
          CLK => CLK,
          RESET => RESET,
          Q0 => Q0,
          Q1 => Q1,
          Q2 => Q2,
          Q3 => Q3,
          Q4 => Q4,
          Q5 => Q5,
          Q6 => Q6,
          Q7 => Q7,
          Q8 => Q8,
			 CONV_START => CONV_START,
          SEL => SEL,
			 CONV_OK => CONV_OK,
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

		SEL <= "01";
		
		Q0 <= x"0";
		Q1 <= x"0";
		Q2 <= x"0";
		Q3 <= x"0";
		Q4 <= x"0";
		Q5 <= x"0";
		Q6 <= x"0";
		Q7 <= x"0";
		Q8 <= x"0";
		
		CONV_START <= '1';
		wait for 20 ns;
		CONV_START <= '0';
		
		wait until CONV_OK = '1';
		
		wait for 10 ns;
		
		Q0 <= x"1";
		Q1 <= x"2";
		Q2 <= x"3";
		Q3 <= x"1";
		Q4 <= x"2";
		Q5 <= x"3";
		Q6 <= x"1";
		Q7 <= x"2";
		Q8 <= x"3";
		
		CONV_START <= '1';
		
		wait for 20 ns;
		CONV_START <= '0';
		
		wait until CONV_OK = '1';
	
	wait for 10 ns;
		
		Q0 <= x"5";
		Q1 <= x"1";
		Q2 <= x"5";
		Q3 <= x"1";
		Q4 <= x"5";
		Q5 <= x"1";
		Q6 <= x"5";
		Q7 <= x"1";
		Q8 <= x"5";
		
		CONV_START <= '1';
		
		wait for 20 ns;
		CONV_START <= '0';
		
		wait until CONV_OK = '1';

		
		
      wait;
   end process;

END;
