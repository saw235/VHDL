----------------------------------------------------------------------------
-- Entity:        Lab05_xps5001
-- Written By:    Saw Xue Zheng
-- Date Created:  10/4/2016
-- Description:   Top level for Lab5
-- Revision History (date, initials, description):
-- 	4 October 16, xps5001, file created.

-- Dependencies: 
--					XPS5001_Library
--					SequenceDetectFSM
--					TrafficLightController
----------------------------------------------------------------------------


library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.ALL;


entity Lab05_xps5001 is
    Port ( SWITCH : in  STD_LOGIC_VECTOR (15 downto 0);
           BTNL 	: in  STD_LOGIC;
           BTNR 	: in  STD_LOGIC;
           BTNU 	: in  STD_LOGIC;
           BTND 	: in  STD_LOGIC;
           BTNC 	: in  STD_LOGIC;
           CLK 	: in  STD_LOGIC;
           ANODE 	: out  STD_LOGIC_VECTOR (7 downto 0);
           SEGMENT: out  STD_LOGIC_VECTOR (0 to 6);
           LED 	: out  STD_LOGIC_VECTOR (15 downto 0));
end Lab05_xps5001;

architecture Structural of Lab05_xps5001 is

	Component SequenceDetectFSM is 
		    port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 3);
					  CLK 			: in  STD_LOGIC;
					  RESET 			: in  STD_LOGIC;
					  CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 2);
					  DEBUG_out 	: out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	Component TrafficLightController is
    Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 6);
           CLK 			: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
           CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 6);
           DEBUG_out 	: out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	signal pulse_200hz	 				: std_logic;
	signal pulse_400hz	 				: std_logic;
	
	signal word_int						: std_logic_vector (31 downto 0);
	
	signal btnl_debounced 				: std_logic;
	signal btnl_oneshot					: std_logic;
	signal btnr_debounced 				: std_logic;
	signal btnr_oneshot					: std_logic;
	signal btnc_debounced 				: std_logic;
	signal btnc_oneshot					: std_logic;
	signal btnu_debounced 				: std_logic;
	signal btnu_oneshot					: std_logic;
	signal btnd_debounced 				: std_logic;
	signal btnd_oneshot					: std_logic;
	
	signal SequenceDetectInput_in		: std_logic_vector (0 to 3);
	signal SequenceDetectOutput_in	: std_logic_vector (0 to 2);
	signal SequenceDetectDebug_in		: std_logic_vector (3 downto 0);
	
	signal tfcInput_in					: std_logic_vector (0 to 6);
	signal tfcOutput_in					: std_logic_vector (0 to 6);
	signal tfcDebug_in					: std_logic_vector (7 downto 0);
	
	
	signal reset_in 						: std_logic;
	
	signal eq_halfsec_in					: std_logic;
	signal eq_1sec_in						: std_logic;
	signal eq_2sec_in						: std_logic;	
	signal eq_5sec_in						: std_logic;
	
	signal timer_in						: std_logic_vector (7 downto 0);
	signal timer1_in						: std_logic_vector (7 downto 0);
	signal tmr_clr							: std_logic;
	signal tmr1_clr						: std_logic;
	signal timer1_tc						: std_logic;
	signal seconds							: std_logic_vector (3 downto 0);
begin
	
	reset_in <= btnl and btnd and btnr;
	
	--400hz Pulse
	pulse_gen_400hz : PulseGenerator generic map( n => 18, maxCount => 249999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> '0',
					PULSE => pulse_400hz--internal pulse
				);
	
	--200hz Pulse
	pulse_gen_200hz : PulseGenerator generic map( n => 19, maxCount => 499999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> '0',
					PULSE => pulse_200hz--internal pulse
				);
			
	
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

	-- debounce input
		dbouncer : Debounce port map(
				D 			=> BTNR,
				SAMPLE	=> pulse_200hz,
				CLK		=> CLK,
				Q			=> btnr_debounced
		);
		
	-- oneshot input
		oshotr : OneShot port map(
				D		=> btnr_debounced,
				CLK	=> CLK,
				Q		=> btnr_oneshot
		);	

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

	-- debounce input
		dbounceu : Debounce port map(
				D 			=> BTNU,
				SAMPLE	=> pulse_200hz,
				CLK		=> CLK,
				Q			=> btnu_debounced
		);
		
	-- oneshot input
		oshotu : OneShot port map(
				D		=> btnu_debounced,
				CLK	=> CLK,
				Q		=> btnu_oneshot
		);

		
		SequenceDetectInput_in <= btnl_oneshot & btnr_oneshot & btnc_oneshot & btnu_oneshot;
		
		SequenceDtc : SequenceDetectFSM port map(
			 STATUS_in 		=> SequenceDetectInput_in,
			 CLK 				=> CLK,
			 RESET 			=> reset_in,
			 CONTROL_out 	=> SequenceDetectOutput_in,
			 DEBUG_out 		=> SequenceDetectDebug_in
		);
		
		
		tfc : TrafficLightController port map(
			 STATUS_in 	   => tfcInput_in,
          CLK 			   => CLK,
          RESET 		   => reset_in,
          CONTROL_out   => tfcOutput_in,
          DEBUG_out 	   => tfcDebug_in
		
		);
		
		tfcInput_in 	<= eq_1sec_in & eq_2sec_in & eq_5sec_in & eq_halfsec_in & SequenceDetectOutput_in;
		
		tmr_clr <= tfcOutput_in(6);
		
		--use default timer that counts 0.1s and counts up to 256 * 0.1s
		timer0 : Timer port map(
			CLK => CLK,
			CLR => tmr_clr, --should be cleared by FSM
			Q 	 => timer_in
		);
		
		--counts 0.1s and counts up to 10 * 0.1s
		timer1 : Timer port map(
			CLK => CLK,
			CLR => tmr1_clr, --should be cleared by FSM
			Q 	 => timer1_in
		);

		eq_1sec_tm1 : CompareEQU generic map ( n => 8) port map (
			  A	=> timer1_in,
           B	=> STD_LOGIC_VECTOR(to_unsigned(10, 8)),
           EQU	=> timer1_tc
		);		
		
		tmr1_clr <= timer1_tc or tmr_clr;

		
		--counts up to 16 seconds in 1s div
		cntseconds : Counter generic map (n => 4) port map (
					EN  => timer1_tc,
					CLK => CLK,
					CLR => tmr_clr, --should be cleared by FSM
					Q	 => seconds
	);			 
		
		--0.5 second
		eq_0_5sec : CompareEQU generic map ( n => 8) port map (
			  A	=> timer_in,
           B	=> STD_LOGIC_VECTOR(to_unsigned(5, 8)),
           EQU	=> eq_halfsec_in
		);
		
		--1 second
		eq_1sec : CompareEQU generic map ( n => 8) port map (
			  A	=> timer_in,
           B	=> STD_LOGIC_VECTOR(to_unsigned(10, 8)),
           EQU	=> eq_1sec_in
		);		
		
		--2 seconds
		eq_2sec : CompareEQU generic map ( n => 8) port map (
			  A	=> timer_in,
           B	=> STD_LOGIC_VECTOR(to_unsigned(20, 8)),
           EQU	=> eq_2sec_in
		);
		
		--5 seconds
		eq_5sec : CompareEQU generic map ( n => 8) port map (
			  A	=> timer_in,
           B	=> STD_LOGIC_VECTOR(to_unsigned(50, 8)),
           EQU	=> eq_5sec_in
		);		
		
		
		
		word_int <= seconds & timer_in(3 downto 0) & x"00" & tfcDebug_in & x"0" & SequenceDetectDebug_in ;
		
		sevseg : WordTo8dig7seg port map(
				WORD 	 	=> word_int,
				STROBE 	=> pulse_400hz,
				CLK 		=> CLK,
				DIGIT_EN => "11001111",
				ANODE 	=> ANODE,
		      SEGMENT 	=> SEGMENT
	);	
	
	LED <= tfcOutput_in(0 to 2) & "00" & 
			 SequenceDetectOutput_in(0) & '0' & 
			 SequenceDetectOutput_in(1) & '0' & 
			 SequenceDetectOutput_in(2) & "000" &
			 tfcOutput_in(3 to 5) ;

end Structural;

