----------------------------------------------------------------------------
-- Entity:        Lab04_xps5001
-- Written By:    Saw Xue Zheng
-- Date Created:  9/21/2016
-- Description:   Top Level for Lab04
-- Revision History (date, initials, description):
-- 	21 September 2016, xps5001, file created.

-- Dependencies:
--		None
----------------------------------------------------------------------------

library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;

entity Lab04_xps5001 is
    Port ( SWITCH : in  STD_LOGIC_VECTOR (15 downto 0);
           BTNL : in  STD_LOGIC;
           BTNR : in  STD_LOGIC;
           BTNU : in  STD_LOGIC;
           BTND : in  STD_LOGIC;
           BTNC : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           ANODE : out  STD_LOGIC_VECTOR (7 downto 0);
           SEGMENT : out  STD_LOGIC_VECTOR (0 to 6);
           LED : out  STD_LOGIC_VECTOR (15 downto 0));
end Lab04_xps5001;

architecture Structural of Lab04_xps5001 is

	--internal signals
	signal pulse_400hz 		: std_logic;
	signal pulse_200hz 		: std_logic;
	signal pulse_16hz 		: std_logic;
	signal pulse_50mhz 		: std_logic;
	
	--signals for REG 0
	signal btnc_debounced 	: std_logic;
	signal btnc_oneshot		: std_logic;
	signal reg0_int 	: std_logic_vector (15 downto 0);
	
	--signals for REG 1
	signal reg1_int 	: std_logic_vector (15 downto 0);
	
	--signals for REG 2
	signal reg2_int 	: std_logic_vector (15 downto 0);

	--signals for REG 3
	signal btnl_debounced 	: std_logic;
	signal btnl_oneshot		: std_logic;
	signal reg3_int 	: std_logic_vector (15 downto 0);

	--signals for REG 4
	signal reg4_int 	: std_logic_vector (15 downto 0);

	--signals for REG 5
	signal sync0_int  	: std_logic;
	signal sync1_int 		: std_logic;
	signal btnu_oneshot	: std_logic;
	signal reg5_int 		: std_logic_vector (15 downto 0);

	--signals for REG 6
	signal btnu_debounced 				: std_logic;
	signal btnu_debounced_oneshot		: std_logic;
	signal reg6_int 						: std_logic_vector (15 downto 0);

	--signals for REG 7
	signal btnd_debounced 	: std_logic;
	signal btnd_oneshot		: std_logic;
	signal reg7_int 	: std_logic_vector (15 downto 0);	
	
	
	--signals for NumericDisplay
	signal reg_val  : std_logic_vector (15 downto 0);
	signal reg_num	 : std_logic_vector (2 downto 0);
	signal word_int : std_logic_vector (31 downto 0);

begin
	
	--400hz Pulse : Pulse once every 400 count
	pulse_gen_400hz : PulseGenerator generic map( n => 18, maxCount => 249999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> '0',
					PULSE => pulse_400hz--internal pulse
				);

	--200hz Pulse : Pulse once every 500 count
	pulse_gen_200hz : PulseGenerator generic map( n => 19, maxCount => 499999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> '0',
					PULSE => pulse_200hz--internal pulse
				);
	
	--Register 0, Serial-In-Parallel-Out (SIPO) shift register
		-- debounce input
			dbouncec : Debounce port map(
					D 			=> BTNC,
					SAMPLE	=> pulse_200hz,
					CLK		=> CLK,
					Q			=> btnc_debounced
			);
			
		-- oneshot input
			oshotc : OneShot port map(
					D		=> btnc_debounced,
					CLK	=> CLK,
					Q		=> btnc_oneshot
			);	
		
			shif_reg : Reg_SIPO generic map (n => 16) port map(
					D 			=> SWITCH(0),
					SHIFT_EN => btnc_oneshot,
					CLK 		=> CLK,
					CLR 		=> '0',
			      Q 			=> reg0_int
			);
	
	--Register 1, 16 Hz clock counter
	pulse_gen_16hz : PulseGenerator generic map( n => 23, maxCount => 6249999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> BTNR,
					PULSE => pulse_16hz--internal pulse
				);
	
	reg1	 : Counter generic map( n => 16) port map (
					EN  => pulse_16hz,
					CLK => CLK,
					CLR => BTNR,
					Q	 => reg1_int
	);
	
	
	
	
	--Register 2, 50 MHz clock counter	
	pulse_gen_50mhz : PulseGenerator generic map (n => 1, maxCount => 1)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> BTNR,
					PULSE => pulse_50mhz--internal pulse
				);
	
	reg2	 : Counter generic map (n => 16) port map (
					EN  => pulse_50mhz,
					CLK => CLK,
					CLR => BTNR,
					Q	 => reg2_int
	);	
	
	--Register 3, Random number generator
			-- debounce input
			dbouncel : Debounce port map(
					D 			=> BTNL,
					SAMPLE	=> pulse_200hz,
					CLK		=> CLK,
					Q			=> btnl_debounced
			);
			
		-- oneshot input
			oshotl : OneShot port map(
					D		=> btnl_debounced,
					CLK	=> CLK,
					Q		=> btnl_oneshot
			);	
	
	reg3	  : Reg generic map (n => 16) port map(
					D 		=>	reg2_int, 
					LOAD 	=>	btnl_oneshot,
					CLK 	=>	CLK,
					CLR 	=>	'0',
					Q 		=> reg3_int
	);
	
	--Register 4, Button press counter #1
	reg4	 : Counter generic map (n => 16) port map (
					EN  => BTNU,
					CLK => CLK,
					CLR => BTNR,
					Q	 => reg4_int
	);	
	
	--Register 5, Button press counter #2
		--synchronizer
		syncdff0 : DFF_CE port map(
	   	 D 	=> BTNU,
          CE 	=> '1',
          CLK  => CLK,
          Q 	=> sync0_int
		);
	
		syncdff1 : DFF_CE port map(
			 D 	=> sync0_int,
          CE 	=> '1',
          CLK  => CLK,
          Q 	=> sync1_int
		);	
		
		oshotu : OneShot port map(
			 D		=> sync1_int,
			 CLK	=> CLK,
			 Q		=> btnu_oneshot
		);	
		
	reg5	 : Counter generic map (n => 16) port map (
					EN  => btnu_oneshot,
					CLK => CLK,
					CLR => BTNR,
					Q	 => reg5_int
	);	
	
	--Register 6, Button press counter #3
		-- debounce input
			dbounceu : Debounce port map(
					D 			=> BTNU,
					SAMPLE	=> pulse_200hz,
					CLK		=> CLK,
					Q			=> btnu_debounced
			);
			
		-- oneshot input
			oshotu_2 : OneShot port map(
					D		=> btnu_debounced,
					CLK	=> CLK,
					Q		=> btnu_debounced_oneshot
			);		

	reg6	 : Counter generic map (n => 16) port map (
					EN  => btnu_debounced_oneshot,
					CLK => CLK,
					CLR => BTNR,
					Q	 => reg6_int
	);		
	
	--Register 7, Up/Down Counter
		-- debounce input
			dbounced : Debounce port map(
					D 			=> BTND,
					SAMPLE	=> pulse_200hz,
					CLK		=> CLK,
					Q			=> btnd_debounced
			);
			
		-- oneshot input
			oshotd : OneShot port map(
					D		=> btnd_debounced,
					CLK	=> CLK,
					Q		=> btnd_oneshot
			);			
	
	reg7	: CounterUpDown generic map (n => 16) port map(
			  EN 		=> '1',
           UP 		=> btnu_debounced_oneshot,
           DOWN 	=> btnd_oneshot,
           CLK	 	=> CLK,
           CLR 	=> BTNR,
           Q 		=> reg7_int
	);
	
	--Numeric Display
	reg_num <= SWITCH(15 downto 13);
	
	with reg_num select 
		reg_val <= reg0_int when "000",
					  reg1_int when "001",
					  reg2_int when "010",
					  reg3_int when "011",
					  reg4_int when "100",
					  reg5_int when "101",
					  reg6_int when "110",
					  reg7_int when "111",
					  (others => '0') when others;
					  
	word_int <= '0' & reg_num & "000000000000" & reg_val;
	
	sevseg : WordTo8dig7seg port map(
				WORD 	 	=> word_int,
				STROBE 	=> pulse_400hz,
				CLK 		=> CLK,
				DIGIT_EN => "10001111",
				ANODE 	=> ANODE,
		      SEGMENT 	=> SEGMENT
	);
	
	--LED Display : Display Reg 0
	LED <= reg0_int;
	
end Structural;

