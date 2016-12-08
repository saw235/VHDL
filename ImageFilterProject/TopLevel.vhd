library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;


entity TopLevel is
	port (
		CLK		: in STD_LOGIC;
		BTNL		: in STD_LOGIC;
		SWITCH 	: in STD_LOGIC_VECTOR ( 15 downto 0);
      ANODE 	: out  STD_LOGIC_VECTOR (7 downto 0);
      SEGMENT 	: out  STD_LOGIC_VECTOR (0 to 6);		
      HS 		: out  STD_LOGIC;
      VS 		: out  STD_LOGIC;
      VGA_R 	: out  STD_LOGIC_VECTOR (3 downto 0);
      VGA_G 	: out  STD_LOGIC_VECTOR (3 downto 0);
      VGA_B 	: out  STD_LOGIC_VECTOR (3 downto 0)	
	);
end TopLevel;


architecture Structural of TopLevel is

	component KernelFilter_3x3 is
	generic ( 
		constant DATA_WIDTH 			: positive := 12;	
		constant CHANNEL_WIDTH		: positive := 4;
		constant totalpxcnt 			: positive := 36;
		constant img_width			: positive := 9;
		constant imgWidth_bitwidth : positive := 4;
		constant PxPos_bitwidth 	: positive := 19;
		constant addr_width			: positive := 15
	);
	port (	
		CLK 		  	: in  STD_LOGIC;
		RESET	  		: in  STD_LOGIC;
		SEL			: in  STD_LOGIC_VECTOR ( 3 downto 0);
		FRAMESTART	: in  STD_LOGIC;
		PXBYTE_IN	: in 	STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	   PXBYTE_OUT	: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	   PXLOAD		: out STD_LOGIC;
		PXREAD		: out STD_LOGIC;
		PXCOUNT_OUT : out STD_LOGIC_VECTOR ( PxPos_bitwidth - 1 downto 0);
		ADDR_OUT		: out STD_LOGIC_VECTOR (addr_width - 1 downto 0);		 
		FRAMEOK		: out STD_LOGIC
	);
	end component;

	COMPONENT parrot
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
	END COMPONENT;
	
	COMPONENT image2
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
	END COMPONENT;
	
	COMPONENT imgadd
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
	END COMPONENT;	

   component ImgBuffer is
	generic ( constant data_width : positive := 12;
				 constant addr_width : positive := 15;
				 constant row_width	: positive := 9;
				 constant col_width  : positive := 10;
				 constant img_width	: positive := 150;
				 constant img_height : positive := 200
	);			 		 
	
	port (
		CLK 				: in STD_LOGIC; 
		RESET 			: in STD_LOGIC;
		WE 				: in STD_LOGIC;
		WRITE_ADDRA 	: in STD_LOGIC_VECTOR( addr_width - 1 downto 0);
		Data_in  		: in STD_LOGIC_VECTOR( data_width - 1 downto 0);
		rowCount 		: in  STD_LOGIC_VECTOR(row_width - 1 downto 0);
		colCount 		: in  STD_LOGIC_VECTOR(col_width - 1 downto 0);
      RE		 		   : in  STD_LOGIC;
      RGB_out 	  		: out  STD_LOGIC_VECTOR (data_width - 1 downto 0)
	);		
	
	
	end component;
	
	component VGA_Controller is
    Port ( 
			  CLK  	  : in STD_LOGIC;
			  RESET	  : in STD_LOGIC;
			  RGB_in : in STD_LOGIC_VECTOR (11 downto 0);
			  POS_X	: out STD_LOGIC_VECTOR (9 downto 0);
			  POS_Y	: out STD_LOGIC_VECTOR (8 downto 0);
			  HS 		: out  STD_LOGIC;
           VS 		: out  STD_LOGIC;
			  PULSE	: out  STD_LOGIC;
           RGB_out: out  STD_LOGIC_VECTOR (11 downto 0));
	end component;	
	
	COMPONENT RAM
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 clkb : IN STD_LOGIC;
		 rstb : IN STD_LOGIC;
		 enb : IN STD_LOGIC;
		 addrb : IN STD_LOGIC_VECTOR(14  DOWNTO 0);
		 doutb : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	  );
	END COMPONENT;


	signal filter_frame_ok_int		: std_logic;
	signal filter_addr_out_int 	: std_logic_vector (14 downto 0); 	
	signal filter_pxbyte_out_int 	: std_logic_vector (11 downto 0); 
	signal filter_pxcount_out_int : std_logic_vector (14 downto 0); 	
	signal filter_pxload_int 		: std_logic;	
	signal filter_pxread_int 		: std_logic;	

	signal filter2_frame_ok_int	: std_logic;
	signal filter2_addr_out_int 	: std_logic_vector (14 downto 0); 	
	signal filter2_pxbyte_out_int : std_logic_vector (11 downto 0); 
	signal filter2_pxcount_out_int: std_logic_vector (14 downto 0); 	
	signal filter2_pxload_int 		: std_logic;	
	signal filter2_pxread_int 		: std_logic;

	signal pxread_int : std_logic;
	signal pxload_int	: std_logic;
	
	
	signal addra 				: std_logic_vector (14 downto 0);
	
	signal pxcount_out_int 	: std_logic_vector (14 downto 0);
	signal pxbyte_out_int 	: std_logic_vector (11 downto 0); 
	
	
	signal douta_int 	: std_logic_vector (11 downto 0);
	signal parrot_dat : std_logic_vector (11 downto 0);
	signal img2_dat 	: std_logic_vector (11 downto 0);
	
	
	signal addr_out_int : std_logic_vector (14 downto 0);
	
	signal frame_start_int 	: std_logic;

	
	signal reset_int			: std_logic;
	
	signal x_int : STD_LOGIC_VECTOR(9 downto 0);
	signal y_int : STD_LOGIC_VECTOR(8 downto 0);
	
	signal RGB_int : STD_LOGIC_VECTOR(11 downto 0);
	signal buf1_doutb_int : STD_LOGIC_VECTOR(11 downto 0);
	
	signal RGB_out_int : STD_LOGIC_VECTOR(11 downto 0);
	signal vga_pulse : STD_LOGIC;
	
	signal sel_int_1 			:	std_logic_vector(3 downto 0);
	signal sel_int_2 			:	std_logic_vector(3 downto 0);	
	
	signal word_int 			: STD_LOGIC_VECTOR(31 downto 0);
	
	
	-----------------------------------------------------------
	signal add_sel						: std_logic;
	signal mask_int 					: std_logic_vector (11 downto 0);	
	signal mask_applied_int			: std_logic_vector (11 downto 0);
	signal d_add_int 					: std_logic_vector (11 downto 0);	
	signal d_added_int 				: std_logic_vector (11 downto 0);
	signal filter_pxbyte_in_int 	: std_logic_vector (11 downto 0);
---------------------------------------------------------------
	
	signal pulse_800hz 		: STD_LOGIC;	

begin
	--two rom image source
	img : parrot PORT MAP (
    clka => CLK,
	 ena  => pxread_int,
    addra => addra,
    douta => parrot_dat
  );
  
	img2 : image2 PORT MAP (
    clka => CLK,
	 ena  => pxread_int,
    addra => addra,
    douta => img2_dat
  );
	  
	imgadd1 : imgadd PORT MAP (
    clka => CLK,
	 ena  => pxread_int,
    addra => addra,
    douta => d_add_int
  );
	  	  

	--800hz Pulse
	pulse_gen_800hz : PulseGenerator generic map( n => 17, maxCount => 124999)
		port map(
					EN 	=> '1',
					CLK	=> CLK,
					CLR	=> '0',
					PULSE => pulse_800hz--internal pulse
				);

	word_int <= "000" & switch(15) & x"00" & sel_int_2 & x"000" & sel_int_1;
		
	sevseg : WordTo8dig7seg port map(
				WORD 	 	=> word_int,
				STROBE 	=> pulse_800hz,
				CLK 		=> CLK,
				DIGIT_EN => "10010001",
				ANODE 	=> ANODE,
		      SEGMENT 	=> SEGMENT
	);		




	reset_int 		 <= btnl; 
	frame_start_int <= switch(0);
	sel_int_1			 <= switch(4 downto 1);
	sel_int_2			 <= switch(8 downto 5);

	with switch(15) select douta_int <= img2_dat when '1', 
													parrot_dat when others;
																																					
--------------------------------------------------------------------

	add_sel <= switch(14);

	mask_int <= x"FFF" when (d_add_int = x"000") else
					x"000";
					
	mask_applied_int <= mask_int and douta_int;
	
	d_added_int <= d_add_int or mask_applied_int;
	
	with add_sel select filter_pxbyte_in_int <= 	d_added_int when '1',
																douta_int when others;
--------------------------------------------------------------------

	filter : KernelFilter_3x3 generic map (
		DATA_WIDTH 			=> 12,
		CHANNEL_WIDTH		=> 4,
	   totalpxcnt 			=> 30000,
	   img_width			=> 150,
	   imgWidth_bitwidth => 8,
	   PxPos_bitwidth 	=> 15,
		addr_width			=> 15) port map (
		CLK 		  			=> CLK,
		RESET	  				=> reset_int,
		SEL					=> sel_int_1,
		FRAMESTART			=> frame_start_int,
	   PXBYTE_IN			=> filter_pxbyte_in_int,
	   PXBYTE_OUT			=> filter_pxbyte_out_int,
	   PXLOAD				=> filter_pxload_int,
		PXREAD				=> filter_pxread_int,
	   PXCOUNT_OUT 		=> filter_pxcount_out_int,
		ADDR_OUT				=> filter_addr_out_int,
	   FRAMEOK				=> filter_frame_ok_int
	);
	
	addra 			<= filter_pxcount_out_int;									 
	pxread_int 		<= filter_pxread_int;
	pxload_int 		<= filter_pxload_int;								 
	addr_out_int 	<= filter_addr_out_int;
	pxbyte_out_int <= filter_pxbyte_out_int;
	
	--buffer after stage 1 filter
	imgbuf1 : RAM
  PORT MAP (
    clka => CLK,
    wea(0) => pxload_int,
    addra => addr_out_int,
    dina => pxbyte_out_int,
    clkb => CLK,
    rstb => reset_int,
	 enb =>	 filter2_pxread_int,
    addrb => filter2_pxcount_out_int,
    doutb => buf1_doutb_int
  );


	
	filter2 : KernelFilter_3x3 generic map (
		DATA_WIDTH 			=> 12,
		CHANNEL_WIDTH		=> 4,
	   totalpxcnt 			=> 29304,	-- 148 * 198
	   img_width			=> 148,		-- when gone through 1st stage filtering image width and height is reduced by 2 respectively.
	   imgWidth_bitwidth => 8,
	   PxPos_bitwidth 	=> 15,
		addr_width			=> 15) port map (
		CLK 		  			=> CLK,
		RESET	  				=> reset_int,
		SEL					=> sel_int_2,
		FRAMESTART			=> filter_frame_ok_int,  --start of 2nd stage filtering is indicated when first stage started to load to its own buffer
	   PXBYTE_IN			=> buf1_doutb_int, --gets input pixel from 1st stage filter output
	   PXBYTE_OUT			=> filter2_pxbyte_out_int,
	   PXLOAD				=> filter2_pxload_int,
		PXREAD				=> filter2_pxread_int,
	   PXCOUNT_OUT 		=> filter2_pxcount_out_int,
		ADDR_OUT				=> filter2_addr_out_int,
	   FRAMEOK				=> filter2_frame_ok_int
	);	
	
	
	--send to image buffer 
	bufimg : ImgBuffer generic map (
		data_width 	=> 12, 
	   addr_width  => 15,
	   row_width	=> 9,
	   col_width   => 10,
		img_width	=> 146,
		img_height 	=> 196		 		
	) port map (
		CLK 				=> CLK,
	   RESET 			=> reset_int,
	   WE 				=> filter2_pxload_int,
	   WRITE_ADDRA 	=> filter2_addr_out_int,
	   Data_in  		=> filter2_pxbyte_out_int,
		rowCount 		=> y_int,
		colCount 		=> x_int,
	   RE		 		   => vga_pulse,
	   RGB_out 	  		=> RGB_int
	);
	
	vga : VGA_Controller port map (
		CLK 		=> CLK,
		RESET 	=> reset_int,
		RGB_in 	=> RGB_int,
		POS_X		=> x_int,
		POS_y		=> y_int,
		HS			=> HS,
		VS			=> VS,
		PULSE		=> vga_pulse,
      RGB_out  => RGB_out_int
	);

	VGA_R <= RGB_out_int(11 downto 8);
	VGA_G <= RGB_out_int(7 downto 4);
	VGA_B <= RGB_out_int(3 downto 0);

end Structural;

