
library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;


entity Lab09_xps5001_kmr5802 is
    Port ( BTNC 		: in  STD_LOGIC;
			  BTNU		: in  STD_LOGIC;
			  BTNL		: in 	STD_LOGIC;
			  BTNR		: in 	STD_LOGIC;
			  BTND		: in 	STD_LOGIC;
           CLK		 	: in  STD_LOGIC;
           SWITCH 	: in  STD_LOGIC_VECTOR(15 downto 0);
		led16_r   	: out STD_LOGIC;
		led16_g		: out STD_LOGIC;
		led16_b   	: out STD_LOGIC;
		led17_r   	: out STD_LOGIC;
		led17_g		: out STD_LOGIC;
		led17_b   	: out STD_LOGIC;
		ANODE			: out STD_LOGIC_VECTOR(7 downto 0);
		SEGMENT		: out STD_LOGIC_VECTOR(0 to 6)
		);
end Lab09_xps5001_kmr5802;

architecture Behavioral of Lab09_xps5001_kmr5802 is
	
 	component PulseWidthModulator is
    	Generic ( nbits  	 		: integer := 8);
    	Port ( 	CLK 			 	: in  STD_LOGIC;
	   	PERIOD_IN		 		: in  STD_LOGIC_VECTOR( nbits - 1 downto 0);
	   	PULSEWIDTH_IN 	 		: in  STD_LOGIC_VECTOR( nbits - 1 downto 0);
	   	RESET						: in  STD_LOGIC;
           	PULSE_OUT 	 		: out  STD_LOGIC);
	end component;
	
	component RAM is 
	generic( n 		: integer := 8;
		 bit_width 	: integer := 48;
		 bit_depth	: integer := 256);
    	Port ( ADDRESS 	: in  STD_LOGIC_VECTOR(n-1 downto 0);
               DATA_in 	: in  STD_LOGIC_VECTOR(bit_width-1 downto 0);
               WE			: in  STD_LOGIC;
               CLK		: in  STD_LOGIC;
               DATA_out	: out STD_LOGIC_VECTOR(bit_width-1 downto 0));
	end component;
	
	
	signal rl_int : integer := 0; 
	signal gl_int : integer := 0;
	signal bl_int : integer := 0;
	
	signal rr_int : integer := 0; 
	signal gr_int : integer := 0;
	signal br_int : integer := 0;
	
	signal color_int 		: std_logic_vector (23 downto 0);
	signal word_int	 	: std_logic_vector (31 downto 0);

	signal reset_int 		: std_logic;
	
	signal pulse_400hz 	: std_logic;
		

	signal address_sel_int 			: std_logic_vector (7 downto 0);
	signal read_val_int				: std_logic_vector (7 downto 0);
	signal ram_write_enable_int 	: std_logic;
	signal ram_data_out				: std_logic_vector (47 downto 0);
	signal ram_data_in				: std_logic_vector (47 downto 0);
	
	
	alias colorleft_in is ram_data_in(47 downto 24);
	alias colorright_in is ram_data_in(23 downto 0);
	
	
	alias colorleft : std_logic_vector(23 downto 0) is ram_data_out(47 downto 24);
	alias colorright : std_logic_vector(23 downto 0) is ram_data_out(23 downto 0);
	
	alias color_in is SWITCH(7 downto 0);
	
	
begin
	
	reset_int <= BTND;
	
	address_sel_int 	<= SWITCH(15 downto 8);
	read_val_int 	 	<= SWITCH(7 downto 0);
	
	ram_write_enable_int <= btnc or btnl or btnr;
	
		
	colorleft_in <= color_in & colorleft(15 downto 0) when (btnl = '1' and btnu = '1') else
					 colorleft(23 downto 16) & color_in & colorleft( 7 downto 0) when (btnc = '1' and btnu = '1') else
					 colorleft(23 downto 8) & color_in when (btnr = '1' and btnu = '1') else
					 colorleft;
					 
	colorright_in <= color_in & colorright(15 downto 0) when (btnl = '1' and btnu = '0') else
					 colorright(23 downto 16) & color_in & colorright( 7 downto 0) when (btnc = '1' and btnu = '0') else
					 colorright(23 downto 8) & color_in when (btnr = '1' and btnu = '0') else
					 colorright;
	
	--400hz Pulse
	pulse_gen_400hz : PulseGenerator generic map( n => 18, maxCount => 249999)
	port map(
				EN 	=> '1',
				CLK	=> CLK,
				CLR	=> reset_int,
				PULSE => pulse_400hz--internal pulse
	);

	

	color_ram : ram port map(
	
		ADDRESS   	=> address_sel_int,
	   	DATA_in  => ram_data_in,
	   	WE 		=> ram_write_enable_int,
	   	CLK 	  	=> CLK,
	   	DATA_out => ram_data_out
	);
	
		rl_int	<= to_integer(unsigned(ram_data_out(47 downto 40)));
		gl_int	<= to_integer(unsigned(ram_data_out(39 downto 32)));
		bl_int	<= to_integer(unsigned(ram_data_out(31 downto 24)));
		rr_int	<= to_integer(unsigned(ram_data_out(23 downto 16)));
		gr_int	<= to_integer(unsigned(ram_data_out(15 downto 8)));
		br_int	<= to_integer(unsigned(ram_data_out(7 downto 0)));
		
	
	rl : PulseWidthModulator generic map ( nbits => 11) port map
	(
		CLK 			 		=> CLK,
		PERIOD_IN			=> (others => '1'),
		PULSEWIDTH_IN  	=> std_logic_vector(to_unsigned(rl_int, 11)),
		RESET					=> reset_int,
		PULSE_OUT 			=> led17_r
	);
	
	gl : PulseWidthModulator generic map ( nbits => 11) port map
	(
		CLK 			 		=> CLK,
		PERIOD_IN			=> (others => '1'),
		PULSEWIDTH_IN 	 	=> std_logic_vector(to_unsigned(gl_int, 11)),
		RESET					=> reset_int,
		PULSE_OUT 			=> led17_g
	);
	
	bl : PulseWidthModulator generic map ( nbits => 11) port map
	(
		CLK 			 		=> CLK,
		PERIOD_IN			=> (others => '1'),
		PULSEWIDTH_IN  	=> std_logic_vector(to_unsigned(bl_int, 11)),
		RESET					=> reset_int,
		PULSE_OUT 			=> led17_b
	);
	
	rr : PulseWidthModulator generic map ( nbits => 11) port map
	(
		CLK 			 		=> CLK,
		PERIOD_IN			=> (others => '1'),
		PULSEWIDTH_IN  	=> std_logic_vector(to_unsigned(rr_int, 11)),
		RESET					=> reset_int,
		PULSE_OUT 			=> led16_r
	);
	
	gr : PulseWidthModulator generic map ( nbits => 11) port map
	(
		CLK 			 		=> CLK,
		PERIOD_IN			=> (others => '1'),
		PULSEWIDTH_IN  	=> std_logic_vector(to_unsigned(gr_int, 11)),
		RESET					=> reset_int,
		PULSE_OUT 			=> led16_g
	);
	
	br : PulseWidthModulator generic map ( nbits => 11) port map
	(
		CLK 			 		=> CLK,
		PERIOD_IN			=> (others => '1'),
		PULSEWIDTH_IN  	=> std_logic_vector(to_unsigned(br_int, 11)),
		RESET					=> reset_int,
		PULSE_OUT 			=> led16_b
	);

	
	with btnu select
			color_int <= ram_data_out(47 downto 24) when '1', --left
				     ram_data_out(23 downto 0) when others; --right


	word_int <= address_sel_int & color_int;

	sevseg : WordTo8dig7seg port map(
				WORD 	 		=> word_int,
				STROBE 		=> pulse_400hz,
				CLK 			=> CLK,
				DIGIT_EN 	=> "11111111",
				ANODE 		=> ANODE,
		      SEGMENT 		=> SEGMENT
	);	



end Behavioral;

