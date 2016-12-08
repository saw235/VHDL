library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;

entity FilterDataPath is
	 Generic ( constant imgWidth 	 			: positive := 9;
				  constant imgWidth_bitwidth  : positive := 4;
				  constant DATA_WIDTH 			: positive := 12;
				  constant CHANNEL_WIDTH		: positive := 4;
				  constant PxPos_bitwidth 		: positive := 19;
				  constant totalpxcnt			: positive := 36;
				  constant addr_width			: positive := 15
				  );
    Port ( CONTROL_in 	: in  STD_LOGIC_VECTOR (0 to 8);
           CLK 		  	: in  STD_LOGIC;
			  RESET	  		: in  STD_LOGIC;
			  SEL				: in  STD_LOGIC_VECTOR (3 downto 0);
			  FRAMESTART	: in  STD_LOGIC;
			  PXBYTE_IN		: in 	STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
			  PXBYTE_OUT	: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
			  PXLOAD			: out STD_LOGIC;
			  PXREAD			: out STD_LOGIC;
			  FRAMEOK		: out STD_LOGIC;
			  PXCOUNT		: out STD_LOGIC_VECTOR (PxPos_bitwidth -1 downto 0);
			  PXPOS_OUT		: out STD_LOGIC_VECTOR (addr_width - 1 downto 0);
           STATUS_out : out  STD_LOGIC_VECTOR (0 to 4));
end FilterDataPath;

architecture Structural of FilterDataPath is


	 component Kernel is
	 Generic ( constant imgWidth 	 		: positive := 9;
				  constant DATA_WIDTH 		: positive := 4;
				  constant PxPos_bitwidth 	: positive := 19);
    Port ( PxByte 	: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
           ShiftPx 	: in  STD_LOGIC;
           PxCnt 		: in  STD_LOGIC_VECTOR (PxPos_bitwidth - 1 downto 0);
			  CLK			: in  STD_LOGIC;
			  CLR			: in  STD_LOGIC;
			  CONV_START	: in 	STD_LOGIC;			  
			  SEL			: in 	STD_LOGIC_VECTOR ( 3 downto 0);
           Px_Out 	: out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
			  CONV_OK		: out STD_LOGIC
			  );
	end component;


	component H_Counter is
	 Generic ( n : integer := 10; maxCount : integer := 799);
    Port ( 
			  EN  : in  STD_LOGIC;
			  CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           TC 	: out  STD_LOGIC;
           Q 	: out  STD_LOGIC_VECTOR (n-1 downto 0));
	end component;

	--inputs for FSM
	alias FRAMESTART_FSM			is Status_out(0);
	alias ISENOUGHPX_FSM			is Status_out(1);
	alias ISENOUGHHPX_FSM		is Status_out(2);
	alias TOTALPXREACHED_FSM 	is STATUS_out(3);
	alias CONV_OK				 	is STATUS_out(4);

	--outputs for FSM
	alias SHIFTPX			is CONTROL_in(0);
	
	alias INC_CNT			is CONTROL_in(1);
	alias INC_H				is CONTROL_in(2);
	
	alias LOAD_PX		 	is CONTROL_in(3);
	
	alias CLR_H				is CONTROL_in(4);
	alias CLR_PXCNT	 	is CONTROL_in(5);
	alias CLR_KNL			is CONTROL_in(6);
	
	alias FRAMEDONE	 	is CONTROL_in(7);
	alias CONV_START		is CONTROL_in(8);


	signal px_cnt_int 		: std_logic_vector(PxPos_bitwidth -1 downto 0);  
                                                             
	signal hpx_tc_int 		: std_logic;                      
	signal hpxcounter_int 	: std_logic_vector(imgWidth_bitwidth-1 downto 0);
	
	signal addr_ctnr_int : std_logic_vector ( addr_width - 1 downto 0);
	
	signal CONV_OK_r : std_logic;
	signal CONV_OK_g : std_logic;
	signal CONV_OK_b : std_logic;
	
begin

	CONV_OK <= CONV_OK_r and CONV_OK_g and CONV_OK_b; --need to be fixed because might cause statemachine to get stuck

	addr_ctnr : Counter generic map ( n => addr_width ) port map(
		EN 	=> LOAD_PX,
	   CLK 	=> CLK,
	   CLR   => CLR_PXCNT,
	   Q 		=> addr_ctnr_int
	);
	
	PXPOS_OUT <= addr_ctnr_int;
	
	
	knrlr : Kernel generic map ( imgWidth => imgWidth, DATA_WIDTH => CHANNEL_WIDTH, PxPos_bitwidth => PxPos_bitwidth) port map (
		PxByte	 => PXBYTE_IN(DATA_WIDTH - 1 downto DATA_WIDTH - CHANNEL_WIDTH), 	
	   ShiftPx 	 => SHIFTPX,
	   PxCnt 	 => px_cnt_int,
	   CLK		 => CLK,
	   CLR		 => CLR_KNL,
		SEL		 => SEL,
	   Px_Out 	 => PXBYTE_OUT(DATA_WIDTH - 1 downto DATA_WIDTH - CHANNEL_WIDTH),
		CONV_START => CONV_START,
		CONV_OK	 => CONV_OK_r
	);
	
	
	knrlg : Kernel generic map ( imgWidth => imgWidth, DATA_WIDTH => CHANNEL_WIDTH, PxPos_bitwidth => PxPos_bitwidth) port map (
		PxByte	 => PXBYTE_IN(DATA_WIDTH - CHANNEL_WIDTH-1 downto DATA_WIDTH - CHANNEL_WIDTH - CHANNEL_WIDTH), 	
	   ShiftPx 	 => SHIFTPX,
	   PxCnt 	 => px_cnt_int,
	   CLK		 => CLK,
	   CLR		 => CLR_KNL,
		SEL 		 => SEL,
	   Px_Out 	 => PXBYTE_OUT(DATA_WIDTH - CHANNEL_WIDTH-1 downto DATA_WIDTH - CHANNEL_WIDTH - CHANNEL_WIDTH),
		CONV_START => CONV_START,
		CONV_OK	 => CONV_OK_g		
	);

	knrlb : Kernel generic map ( imgWidth => imgWidth, DATA_WIDTH => CHANNEL_WIDTH, PxPos_bitwidth => PxPos_bitwidth) port map (
		PxByte	 => PXBYTE_IN(CHANNEL_WIDTH - 1 downto 0),
	   ShiftPx 	 => SHIFTPX,
	   PxCnt 	 => px_cnt_int,
	   CLK		 => CLK,
	   CLR		 => CLR_KNL,
		SEL		 => SEL,
	   Px_Out 	 => PXBYTE_OUT(CHANNEL_WIDTH - 1 downto 0),
		CONV_START => CONV_START,
		CONV_OK	 => CONV_OK_b		
	);	
	
	hcounter : H_Counter generic map ( n => imgWidth_bitwidth , maxCount => imgWidth) port map(
		EN  => INC_H,
	   CLK => CLK,
	   RST => CLR_H,
	   TC  => hpx_tc_int,
	   Q 	 => hpxcounter_int
	);
	
	pxcounter : Counter generic map ( n =>PxPos_bitwidth) port map(
		EN 	=> INC_CNT,	
	   CLK 	=> CLK,
	   CLR   => CLR_PXCNT,
	   Q 		=> px_cnt_int
	); 
		
	PXLOAD	<= LOAD_PX;
	PXREAD	<= SHIFTPX;
	FRAMEOK  <= FRAMEDONE;
	
	PXCOUNT <= px_cnt_int;
	
	FRAMESTART_FSM	 <= FRAMESTART;
	ISENOUGHPX_FSM	 <= '1' when ( to_integer(unsigned(px_cnt_int)) >= ImgWidth + ImgWidth + 2) else '0';
	ISENOUGHHPX_FSM <= '1' when (to_integer(unsigned(hpxcounter_int)) >= 2) else '0';
	TOTALPXREACHED_FSM <= '1' when (to_integer(unsigned(px_cnt_int)) = totalpxcnt) else '0';

end Structural;

