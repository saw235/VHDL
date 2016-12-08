
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY KernelFilter3x3_tb IS
END KernelFilter3x3_tb;
 
ARCHITECTURE behavior OF KernelFilter3x3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT KernelFilter_3x3
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         FRAMESTART : IN  std_logic;
         PXBYTE_IN : IN  std_logic_vector(3 downto 0);
         PXBYTE_OUT : OUT  std_logic_vector(3 downto 0);
		   PXCOUNT_OUT : out STD_LOGIC_VECTOR ( 18 downto 0);			
         PXLOAD : OUT  std_logic;
         FRAMEOK : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal FRAMESTART : std_logic := '0';
   signal PXBYTE_IN : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
	signal PXCOUNT_OUT : std_logic_vector( 18 downto 0);
   signal PXBYTE_OUT : std_logic_vector(3 downto 0);
   signal PXLOAD : std_logic;
   signal FRAMEOK : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: KernelFilter_3x3 PORT MAP (
          CLK => CLK,
          RESET => RESET,
          FRAMESTART => FRAMESTART,
          PXBYTE_IN => PXBYTE_IN,
          PXBYTE_OUT => PXBYTE_OUT,
			 PXCOUNT_OUT => PXCOUNT_OUT,
          PXLOAD => PXLOAD,
          FRAMEOK => FRAMEOK
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

      PXBYTE_IN	<= x"0";
		FRAMESTART  <= '1';

		wait for 20ns;
		
		FRAMESTART  <= '0';
		PXBYTE_IN	<= x"1";

		wait until to_integer(unsigned(PXCOUNT_OUT)) = 1;
		
		
		PXBYTE_IN	<= x"2";
		

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 2;
		
		PXBYTE_IN	<= x"3";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 3;
		
		PXBYTE_IN	<= x"4";
		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 4;
		
		
		PXBYTE_IN	<= x"5";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 5;
		
		PXBYTE_IN	<= x"6";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 6;
		
		PXBYTE_IN	<= x"7";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 7;
		
		PXBYTE_IN	<= x"8";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 8;
		
		---------------------------------------------------
		
		PXBYTE_IN	<= x"0";


		wait until to_integer(unsigned(PXCOUNT_OUT)) = 9;
		
		PXBYTE_IN	<= x"1";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 10;
		
		PXBYTE_IN	<= x"2";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 11;
		
		PXBYTE_IN	<= x"3";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 12;
		
		PXBYTE_IN	<= x"4";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 13;
		
		PXBYTE_IN	<= x"5";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 14;
		
		PXBYTE_IN	<= x"6";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 15;
		
		PXBYTE_IN	<= x"7";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 16;
		
		PXBYTE_IN	<= x"8";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 17;
		
		------------------------------------------------
		
		
		PXBYTE_IN	<= x"A";


		wait until to_integer(unsigned(PXCOUNT_OUT)) = 18;
		
		PXBYTE_IN	<= x"B";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 19;
		
		PXBYTE_IN	<= x"C";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 20;
		
		PXBYTE_IN	<= x"D";

		wait until to_integer(unsigned(PXCOUNT_OUT)) = 21;
		
		PXBYTE_IN	<= x"E";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 22;
		
		PXBYTE_IN	<= x"F";

		wait until to_integer(unsigned(PXCOUNT_OUT)) = 23;

		PXBYTE_IN	<= x"A";


		wait until to_integer(unsigned(PXCOUNT_OUT)) = 24;
		
		PXBYTE_IN	<= x"B";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 25;
		
		PXBYTE_IN	<= x"C";
		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 26;		
		--------------------------------------------------
		
		PXBYTE_IN	<= x"C";


		wait until to_integer(unsigned(PXCOUNT_OUT)) = 27;
		
		PXBYTE_IN	<= x"C";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 28;
		
		PXBYTE_IN	<= x"E";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 29;
		
		PXBYTE_IN	<= x"C";


		wait until to_integer(unsigned(PXCOUNT_OUT)) = 30;
		
		PXBYTE_IN	<= x"C";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 31;
		
		PXBYTE_IN	<= x"C";
		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 32;

		PXBYTE_IN	<= x"C";


		wait until to_integer(unsigned(PXCOUNT_OUT)) = 33;
		
		PXBYTE_IN	<= x"C";

		
		wait until to_integer(unsigned(PXCOUNT_OUT)) = 34;
		
		PXBYTE_IN	<= x"C";
		
      wait;
   end process;

END;
