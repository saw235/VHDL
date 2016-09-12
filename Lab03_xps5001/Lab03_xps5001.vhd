library IEEE;
library XPS5001_Library;
use IEEE.STD_LOGIC_1164.ALL;
use XPS5001_Library.XPS5001_Components.ALL;

entity Lab03_xps5001 is
    Port ( SWITCH 	: in  STD_LOGIC_VECTOR (15 downto 0);
           BTNR 		: in  STD_LOGIC;
           BTNL 		: in  STD_LOGIC;
           BTNU 		: in  STD_LOGIC;
           BTND 		: in  STD_LOGIC;
           BTNC 		: in  STD_LOGIC;
           SEGMENT 	: out  STD_LOGIC_VECTOR (0 to 6);
           ANODE 		: out  STD_LOGIC_VECTOR (7 downto 0);
           LED 		: out  STD_LOGIC_VECTOR (15 downto 0));
end Lab03_xps5001;

architecture Structural of Lab03_xps5001 is
	
	--Internal signals
	signal SUMorA_int 	: STD_LOGIC_VECTOR(3 downto 0);
	signal SUM_int 		: STD_LOGIC_VECTOR(3 downto 0);
	signal MAX_int 		: STD_LOGIC_VECTOR(3 downto 0);
	signal MIN_int 		: STD_LOGIC_VECTOR(3 downto 0);
	signal AVE_int 		: STD_LOGIC_VECTOR(3 downto 0);
	signal HEX_int 		: STD_LOGIC_VECTOR(3 downto 0);
	signal sum_sel_int 	: STD_LOGIC;
	signal disp_sel_int	: STD_LOGIC_VECTOR(1 downto 0);
	signal disp_sel_en	: STD_LOGIC;
	signal anode_sel_int : STD_LOGIC;
	signal decode_int 	: STD_LOGIC_VECTOR(7 downto 0);
	signal xor_decode_int: STD_LOGIC_VECTOR(7 downto 0);	
	
begin

	AddSub : AdderSubtractor_4bit port map(
				A 			=> SWITCH(15 downto 12),
				B 			=> SWITCH(11 downto 8),
				OVERFLOW => OPEN,
				SUBTRACT => BTNR,
				SUM 		=> SUM_int
	);
	
	inst_Max : FindMax_4bit port map(
				A 		=>	SWITCH(15 downto 12),
				B  	=>	SWITCH(11 downto 8),
				C		=>	SWITCH(7 downto 4),
				D		=>	SWITCH(3 downto 0),
				MAX 	=>	MAX_int
	);
	
	inst_Min : FindMin_4bit port map(
				A 		=>	SWITCH(15 downto 12),
				B  	=>	SWITCH(11 downto 8),
				C		=>	SWITCH(7 downto 4),
				D		=>	SWITCH(3 downto 0),
				MIN 	=>	MIN_int
	);	
	
	inst_Ave : FindAverage_4bit port map(
				A 			=>	SWITCH(15 downto 12),
				B  		=>	SWITCH(11 downto 8),
				C			=>	SWITCH(7 downto 4),
				D			=>	SWITCH(3 downto 0),
				AVERAGE 	=>	AVE_int
	);
	
	
	--muxes
	inst_mux0 : Mux2to1_4bit port map(
				X0 	=> SWITCH(15 downto 12),
				X1 	=> SUM_int,
				SEL 	=> sum_sel_int,
				Y 		=> SUMorA_int
	);
	
	inst_mux1 : Mux4to1_4bit port map(
				X0		=> SUMorA_int,
				X1 	=> MAX_int,
				X2		=> MIN_int,
				X3		=> AVE_int,
				SEL	=> disp_sel_int,
				Y		=> HEX_int
	);
	
	--8 bit mux
	with anode_sel_int select
		ANODE <= xor_decode_int when '0',
					"11111110" when '1',
					"00000000" when others;
	
	H27 : HexToSevenSeg port map(
			HEX 		=> HEX_int,
			SEGMENT 	=> SEGMENT
	);
	
	D3to8 : Decoder3to8 port map(
			X	=> SWITCH(10 downto 8),
			EN	=> '1',
			Y	=> decode_int
	);
		
	-- SumOrASel
	sum_sel_int <= BTNR xor BTNL;

	-- Disp_Sel
	disp_sel_en <= BTNR nor BTNL;
	disp_sel_int <= "00" when ( disp_sel_en = '0') else
						 "01" when ( BTNU = '1' and BTNC = '0' and BTND = '0' and disp_sel_en = '1') else
						 "10" when ( BTNU = '0' and BTNC = '1' and BTND = '0' and disp_sel_en = '1') else
						 "11" when ( BTNU = '0' and BTNC = '0' and BTND = '1' and disp_sel_en = '1') else
						 "00";
	
	-- Anode_Sel
	anode_sel_int <= BTNR or BTNL or BTNU or BTNC or BTND;
	
	-- Decode_xor
	xor_decode_int <= decode_int xor "11111111";
	
	LED <= SWITCH;
	

end Structural;

