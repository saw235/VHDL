library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.all;

entity KernelFilter_3x3 is
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
end KernelFilter_3x3;

architecture Structural of KernelFilter_3x3 is

	component FilterDataPath is
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
	end component;

	component FilterFSM is
    Port ( STATUS_in 	: in  STD_LOGIC_VECTOR (0 to 4);
           CLK 			: in  STD_LOGIC;
           RESET 			: in  STD_LOGIC;
           CONTROL_out 	: out  STD_LOGIC_VECTOR (0 to 8);
           DEBUG_out 	: out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	signal dp_status_out_int 	: STD_LOGIC_VECTOR (0 to 4);
	signal fsm_control_out_int : STD_LOGIC_VECTOR (0 to 8);	


begin
	
	filterdp : FilterDataPath generic map ( 
		DATA_WIDTH 			=> DATA_WIDTH, 
		CHANNEL_WIDTH 		=> CHANNEL_WIDTH,
		imgWidth 			=> img_width, 
		imgWidth_bitwidth => imgWidth_bitwidth,
		totalpxcnt 			=> totalpxcnt,
		PxPos_bitwidth 	=> PxPos_bitwidth,
		addr_width			=> addr_width	
		) port map(
		CONTROL_in => fsm_control_out_int,
	   CLK 		  => CLK,
	   RESET	  	  => RESET,
		SEL		  => SEL,
	   FRAMESTART => FRAMESTART,
	   PXBYTE_IN  => PXBYTE_IN,
	   PXBYTE_OUT => PXBYTE_OUT,
	   PXLOAD	  => PXLOAD,
		PXREAD	  => PXREAD,
	   FRAMEOK	  => FRAMEOK,
		PXCOUNT	  => PXCOUNT_OUT,
		PXPOS_OUT  => ADDR_OUT,
	   STATUS_out => dp_status_out_int
	);
	
	filter_fsm : FilterFSM port map (
		STATUS_in 	=> dp_status_out_int,
	   CLK 			=> CLK,
	   RESET 		=> RESET,
	   CONTROL_out => fsm_control_out_int,
	   DEBUG_out 	=> open
	);
	
end Structural;

