----------------------------------------------------------------------------
-- Entity:        Lab02_xps5001
-- Written By:    Saw Xue Zheng
-- Date Created:  9/4/2016
-- Description:   Add, Subtract and Display the sum in Seven Segment Display 
--
-- Revision History (date, initials, description):
-- 	4 September 16, xps5001, file created.

-- Dependencies:
--		AdderSubtractor_4bit
--		Mux4to1_4bit
--		HexToSevenSeg
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Lab02_xps5001 is
    Port ( SWITCH : in  STD_LOGIC_VECTOR (7 downto 0);
           BTNU : in  STD_LOGIC;
           BTNC : in  STD_LOGIC;
           BTND : in  STD_LOGIC;
           ANODE : out  STD_LOGIC_VECTOR (7 downto 0);
           SEGMENT : out  STD_LOGIC_VECTOR (0 to 6);
           LED : out  STD_LOGIC_VECTOR (7 downto 0));
end Lab02_xps5001;

architecture Structural of Lab02_xps5001 is

	 --Components Declaration
	 
	 COMPONENT AdderSubtractor_4bit
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         SUBTRACT : IN  std_logic;
         SUM : OUT  std_logic_vector(3 downto 0);
         OVERFLOW : OUT  std_logic
        );
    END COMPONENT;

	COMPONENT Mux4to1_4bit
    PORT(
         X0 : IN  std_logic_vector(3 downto 0);
         X1 : IN  std_logic_vector(3 downto 0);
         X2 : IN  std_logic_vector(3 downto 0);
         X3 : IN  std_logic_vector(3 downto 0);
         SEL : IN  std_logic_vector(1 downto 0);
         Y : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT HexToSevenSeg 
		port ( HEX      : in  STD_LOGIC_VECTOR (3 downto 0);
				 SEGMENT : out STD_LOGIC_VECTOR (0 to 6));
    END COMPONENT;


	 --Internal Signals
	 SIGNAL A_int : STD_LOGIC_VECTOR ( 3 downto 0);
	 SIGNAL B_int : STD_LOGIC_VECTOR ( 3 downto 0);
	 SIGNAL SEL_int : STD_LOGIC_VECTOR (1 downto 0);
	 SIGNAL HEX_int : STD_LOGIC_VECTOR ( 3 downto 0);
	 SIGNAL SUM_int : STD_LOGIC_VECTOR (3 downto 0);
	 SIGNAL BTN_cat_int : STD_LOGIC_VECTOR (2 downto 0); 
begin
	--Internal Wires Logic
	A_int <= SWITCH (7 downto 4);
	B_int <= SWITCH (3 downto 0);
	
	--Instantiate Components
	H27 : HexToSevenSeg port map(
			HEX => HEX_int,
			SEGMENT => SEGMENT
	);
	
	ADDSUB : AdderSubtractor_4bit port map(
				A => A_int,
				B => B_int,
				SUBTRACT => BTND,
				SUM => SUM_int,
				OVERFLOW => LED(7)
	);
	
	MUX4X1 : Mux4to1_4bit port map(
				X0 => SUM_int,
				X1 => SUM_int,
				X2 => A_int,
				X3 => B_int,
				SEL => SEL_int,
				Y => HEX_int
	);
	
	--ButtonEncoder
	BTN_cat_int <= BTNU & BTNC & BTND;
	with BTN_cat_int SELECT SEL_int <= "01" when "001" | "101" | "111",
												  "10" when "100",
												  "11" when "010",
												  "00" when others;
				
	
	--OUTPUTS
	ANODE <= ( 0 => '1', others => '0'); 
	LED(3 downto 0) <= SUM_int;
	LED(6 downto 4) <= (others => '0');

end Structural;

