
library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.ALL;

entity Lab06_xps5001 is
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
end Lab06_xps5001;

architecture Behavioral of Lab06_xps5001 is

	component CandyBarFSM is
	    Port	( 	STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 6);
					CLK 			: in  STD_LOGIC;
					RESET 		: in  STD_LOGIC;
					CONTROL_out : out  STD_LOGIC_VECTOR (0 to 6);
					DEBUG_out 	: out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component CandyBarDataPath is
    Port ( CLK				: in STD_LOGIC;
			  DEC_80 		: in  STD_LOGIC;
           INC_CRED 		: in  STD_LOGIC_VECTOR (1 downto 0);
           DEC_CANDY 	: in  STD_LOGIC;
           INC_SALES_80 : in  STD_LOGIC;
           CLR_CREDIT 	: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
			  hasCandy		: out STD_LOGIC;
			  enoughCredit	: out STD_LOGIC;
           SALES 			: out  STD_LOGIC_VECTOR (11 downto 0);
           CANDY 			: out  STD_LOGIC_VECTOR (15 downto 0);
           CREDIT 		: out  STD_LOGIC_VECTOR (11 downto 0));
	end component;

	signal FSM_in_int 		: STD_LOGIC_VECTOR(0 to 6);
	signal FSM_out_int		: STD_LOGIC_VECTOR(0 to 6);
	signal DEBUG_out_int 	: STD_LOGIC_VECTOR(3 downto 0);
	
	signal reset_int			: STD_LOGIC;
	signal hasCandy_int		: STD_LOGIC;
	signal enoughCredit_int	: STD_LOGIC;
	
	signal sales_int			: STD_LOGIC_VECTOR(11 downto 0);
	signal candy_int			: STD_LOGIC_VECTOR(15 downto 0);
	signal credit_int			: STD_LOGIC_VECTOR(11 downto 0);
	
	
	signal N_int				: STD_LOGIC := '0';
	signal D_int				: STD_LOGIC := '0';
	signal Q_int				: STD_LOGIC := '0';
	signal CR_int				: STD_LOGIC := '0';
	signal Purchase_int		: STD_LOGIC := '0';
	
	
	signal word_int 			: STD_LOGIC_VECTOR(31 downto 0);
	
	signal pulse_400hz 		: STD_LOGIC;
	signal pulse_200hz 		: STD_LOGIC;

	signal btnu_debounced 				: std_logic;
	signal btnu_oneshot					: std_logic;
	
	signal btnd_debounced 				: std_logic;
	signal btnd_oneshot					: std_logic;
	
	signal switch0_debounced			: std_logic;
	signal switch1_debounced			: std_logic;
	signal switch2_debounced			: std_logic;
	
	signal bar_switch0_oneshot			: std_logic;
	signal bar_switch1_oneshot			: std_logic;
	signal bar_switch2_oneshot			: std_logic;
	
	signal n_delatch						: std_logic;
	signal d_delatch						: std_logic;
	signal q_delatch						: std_logic;
	
begin
	
	
	
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
		
	-- debounce switches
		sw0dbounced : Debounce port map(
				D 			=> SWITCH(0),
				SAMPLE	=> pulse_200hz,
				CLK		=> CLK,
				Q			=> switch0_debounced
		);
		sw1dbounced : Debounce port map(
				D 			=> SWITCH(1),
				SAMPLE	=> pulse_200hz,
				CLK		=> CLK,
				Q			=> switch1_debounced
		);
		sw2dbounced : Debounce port map(
				D 			=> SWITCH(2),
				SAMPLE	=> pulse_200hz,
				CLK		=> CLK,
				Q			=> switch2_debounced
		);
		
		
		
	-- oneshot switches
		sw0oshot : OneShotR port map(
				D		=> switch0_debounced,
				CLK	=> CLK,
				Q		=> bar_switch0_oneshot
		);
		
		sw1oshot : OneShotR port map(
				D		=> switch1_debounced,
				CLK	=> CLK,
				Q		=> bar_switch1_oneshot
		);

		sw2oshot : OneShotR port map(
				D		=> switch2_debounced,
				CLK	=> CLK,
				Q		=> bar_switch2_oneshot
		);
	

	n_delatch <= '1' when (FSM_out_int(1 to 2) = "01") else
					 '0';
					 
	d_delatch <= '1' when (FSM_out_int(1 to 2) = "10") else
					 '0';

	q_delatch <= '1' when (FSM_out_int(1 to 2) = "11") else
					 '0';
	
	nickel_latch: SR_FF port map(
			S 		=> bar_switch0_oneshot,
			R 		=> n_delatch,
			RESET => reset_int,
			CLK	=> CLK,
			Q 		=> N_int,
			Q_bar => OPEN
	);
	
	dime_latch: SR_FF port map(
			S 		=> bar_switch1_oneshot,
			R 		=> d_delatch,
			RESET => reset_int,			
			CLK	=> CLK,
			Q 		=> D_int,
			Q_bar => OPEN
	);		
		
	quarter_latch: SR_FF port map(
			S 		=> bar_switch2_oneshot,
			R 		=> q_delatch,
			RESET => reset_int,			
			CLK	=> CLK,
			Q 		=> Q_int,
			Q_bar => OPEN
	);	

	purchase_latch: SR_FF port map(
			S 		=> btnu_oneshot,
			R 		=> FSM_out_int(6),
			RESET => reset_int,				
			CLK	=> CLK,
			Q 		=> Purchase_int,
			Q_bar => OPEN			
	);
			
	CR_latch	: SR_FF port map(
			S 		=> btnd_oneshot,
			R 		=> FSM_out_int(5),
			RESET => reset_int,				
			CLK	=> CLK,
			Q 		=> CR_int,
			Q_bar => OPEN
	);
	
	
	reset_int <= btnl and btnd and btnr;
	FSM_in_int <= N_int & D_int & Q_int & Purchase_int & CR_int & hasCandy_int & enoughCredit_int;
	
	
	
	candyFSM : CandyBarFSM port map(
		STATUS_in 		=> FSM_in_int,
		CLK 				=> CLK,
		RESET 			=> reset_int,
		CONTROL_out 	=> FSM_out_int,
		DEBUG_out 		=> DEBUG_out_int
	);
	
	candyDP : CandyBarDataPath port map(
		CLK				=> CLK,
		DEC_80 			=> FSM_out_int(0),
      INC_CRED 	   => FSM_out_int(1 to 2),
      DEC_CANDY 		=> FSM_out_int(3),
      INC_SALES_80 	=> FSM_out_int(4),
      CLR_CREDIT 		=> FSM_out_int(5),
      RESET 			=> reset_int,
		hasCandy			=> hasCandy_int,
		enoughCredit	=> enoughCredit_int,
      SALES 		 	=> sales_int,
      CANDY 			=> candy_int,
      CREDIT 		 	=> credit_int
	);
	
	word_int <= sales_int & x"00" & credit_int;
		
	sevseg : WordTo8dig7seg port map(
				WORD 	 	=> word_int,
				STROBE 	=> pulse_400hz,
				CLK 		=> CLK,
				DIGIT_EN => "11100111",
				ANODE 	=> ANODE,
		      SEGMENT 	=> SEGMENT
	);		
	
	LED <= candy_int;

end Behavioral;

