------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 11/4/14
-- Lab # and name	: Lab7 - TugOfWar Circuit
-- Student 1		: Saw Xue Zheng
-- Student 2		: Ryan Kelley

-- Description		: Friggin TugOfWar Game
--						: 
-- Changes 
-- 						- Version 1.0 

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TechnoTOW is
    Port ( sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7 : in STD_LOGIC;
           RightBt : in  STD_LOGIC;
           Resetgame : in  STD_LOGIC;
			  Resetcount : in STD_LOGIC;
           Clk : in  STD_LOGIC;
           A : out  STD_LOGIC;
           B : out  STD_LOGIC;
           C : out  STD_LOGIC;
           D : out  STD_LOGIC;
           E : out  STD_LOGIC;
           F : out  STD_LOGIC;
           G : out  STD_LOGIC;
           LED0 : out  STD_LOGIC;
           LED1 : out  STD_LOGIC;
           LED2 : out  STD_LOGIC;
           LED3 : out  STD_LOGIC;
           LED4 : out  STD_LOGIC;
           LED5 : out  STD_LOGIC;
           LED6 : out  STD_LOGIC;
			  Anode0: out STD_LOGIC;
			  Anode1: out STD_LOGIC;
			  Anode2: out STD_LOGIC;
			  Anode3: out STD_LOGIC);
end TechnoTOW;

architecture Behavioral of TechnoTOW is

--component clkdiv is port
--(
--clk : in  STD_LOGIC;
--	Sclk: out STD_LOGIC
--	
--);
--end component;

----LED 0-2, 4-6

--component Adder is 
--port (
--			  a : in  STD_LOGIC;
--           b : in  STD_LOGIC;
--           ci : in  STD_LOGIC;
--           co : out  STD_LOGIC;
--           s : out  STD_LOGIC);
--end component;

component Debouncer is 
 Port ( clk : in  STD_LOGIC;
			-- signals from the pmod
           Ain : in  STD_LOGIC; 
			-- debounced signals 
			  Aout: out STD_LOGIC
			  );
end component;

component NormalLight is port
(
	LeftBt : in  STD_LOGIC;
           RightBt : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           LeftN : in  STD_LOGIC;
           RightN : in  STD_LOGIC;
           LightOn : out  STD_LOGIC
);
end component;

--LED 3 
component MidLight is port
(
			  LeftBt : in  STD_LOGIC;
           RightBt : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           LeftN : in  STD_LOGIC;
           RightN : in  STD_LOGIC;
           LightOn : out  STD_LOGIC
	
);
end component;

--LEFT RIGHT BUTTONS
component UserInput is port
(
				input : in  STD_LOGIC;
			   clk : in STD_LOGIC;
				rst : in STD_LOGIC;
           input_pulse : out  STD_LOGIC
);

end component;

--counter
component Counter is port
( Count : in  STD_LOGIC;
	clk : in std_logic;
	  s0 : out  STD_LOGIC;
     s1 : out  STD_LOGIC;
     s2 : out  STD_LOGIC;
     s3 : out  STD_LOGIC;
    Rst : in  STD_LOGIC);
end component;


--lfsr
component LFSR8Bit is port
(
	clk, rst : in STD_LOGIC;
	 q0 : out  STD_LOGIC;
	q1 : out  STD_LOGIC;
           q2 : out  STD_LOGIC;
           q3 : out  STD_LOGIC;
           q4 : out  STD_LOGIC;
           q5 : out  STD_LOGIC;
           q6 : out  STD_LOGIC;
           q7 : out  STD_LOGIC
          
);
end component;

component comparator is port
(
 a0 : in  STD_LOGIC;
           a1 : in  STD_LOGIC;
           a2 : in  STD_LOGIC;
           a3 : in  STD_LOGIC;
           a4 : in  STD_LOGIC;
           a5 : in  STD_LOGIC;
           a6 : in  STD_LOGIC;
           a7 : in  STD_LOGIC;
           b0 : in  STD_LOGIC;
           b1 : in  STD_LOGIC;
           b2 : in  STD_LOGIC;
           b3 : in  STD_LOGIC;
           b4 : in  STD_LOGIC;
           b5 : in  STD_LOGIC;
           b6 : in  STD_LOGIC;
           b7 : in  STD_LOGIC;
           s0 : out  STD_LOGIC;
           s1 : out  STD_LOGIC;
           s2 : out  STD_LOGIC;
           s3 : out  STD_LOGIC;
           s4 : out  STD_LOGIC;
           s5 : out  STD_LOGIC;
           s6 : out  STD_LOGIC;
           s7 : out  STD_LOGIC;
			  s8 : out STD_LOGIC
);
end component;

component seven_seg_display is port
(
b0 : in  STD_LOGIC; --is actually b3
           b1 : in  STD_LOGIC; --actually b2
           b2 : in  STD_LOGIC; -- so on.. :(
           b3 : in  STD_LOGIC;
			  anode0in : in STD_LOGIC;
			  anode1in : in STD_LOGIC;
			  anode2in : in STD_LOGIC;
			  anode3in : in STD_LOGIC;
			  anode0 : out STD_LOGIC;
			  anode1 : out STD_LOGIC;
			  anode2 : out STD_LOGIC;
			  anode3 : out STD_LOGIC;
           A : out  STD_LOGIC;
           B : out  STD_LOGIC;
           C : out  STD_LOGIC;
           D : out  STD_LOGIC;
           E : out  STD_LOGIC;
           F : out  STD_LOGIC;
           G : out  STD_LOGIC
);
end component;

signal anode, leftbt1, rightbt1db, rightbt1, led0_in, led1_in, led2_in, led3_in, led4_in, led5_in, led6_in, out0, out1, out2, out3:STD_LOGIC; 

signal lsfr0, lsfr1, lsfr2, lsfr3, lsfr4, lsfr5, lsfr6, lsfr7: STD_LOGIc; 

signal pcinput: std_logic;

signal counting : std_logic;

--signal Clk: std_logic;

begin

--sloclk : clkdiv port map
--(
--clk => FClk,
--Sclk => Clk
--);


debounce : Debouncer port map
(
clk => Clk,
Ain => RightBt,
Aout => rightbt1db
);

RNG: LFSR8Bit port map
(
clk => Clk,
rst =>Resetgame,
q0 => lsfr0,
q1 => lsfr1,
q2 => lsfr2,
q3 => lsfr3,
q4 => lsfr4,
q5 => lsfr5,
q6 => lsfr6,
q7 => lsfr7
);

compare8bit : comparator port map
(
	a0=>lsfr7,
	a1=>lsfr6,
	a2=>lsfr5,
	a3=>lsfr4,
	a4=>lsfr3,
	a5=>lsfr2,
	a6=>lsfr1,
	a7=>lsfr0,
	b0=>sw0,
	b1=>sw1,
	b2=>sw2,
	b3=>sw3,
	b4=>sw4,
	b5=>sw5,
	b6=>sw6,
	b7=>'0',
	s8=>pcinput
);

counting <= rightbt1 and led0_in;

counter1 : Counter port map
(
	clk => clk,
	Count => counting,
	Rst => Resetcount,
	s0 => out3,
	s1 => out2,
	s2 => out1,
	s3 => out0
);
--button to shift led to left
Computer: UserInput port map
(
	input => pcinput,
	clk => Clk,
	rst => Resetgame,
	input_pulse => leftbt1
);

--button to shift led to right
RightB: UserInput port map
(
	input => rightbt1db,
	clk => Clk,
	rst => Resetgame,
	input_pulse => rightbt1
);

--normal light is off by default
LED_0: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Resetgame,
           LeftN => led1_in,
           RightN => '0',
           LightOn => led0_in
);

LED_1: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Resetgame,
           LeftN => led2_in,
           RightN => led0_in,
           LightOn => led1_in
);

LED_2: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Resetgame,
           LeftN => led3_in,
           RightN => led1_in,
           LightOn => led2_in
);

--middle light, on at the start of game and when resetted.
LED_3: MidLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Resetgame,
              LeftN => led4_in,
           RightN => led2_in,
           LightOn => led3_in
);

LED_4: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Resetgame,
          LeftN => led5_in,
           RightN => led3_in,
           LightOn => led4_in
);

LED_5: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Resetgame,
             LeftN => led6_in,
           RightN => led4_in,
           LightOn => led5_in
);

LED_6: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Resetgame,
           LeftN => '0',
           RightN => led5_in,
           LightOn => led6_in
);
--------------------------------
--------------------------------



ssd: seven_seg_display port map
(
 b0=>out3,
 b1=>out2,
 b2=>out1,
 b3=>out0,
 anode0in => anode,
			  anode1in => '1',
			  anode2in => '1',
			  anode3in => '1',
			  anode0 => Anode0,
			  anode1 => Anode1,
			  anode2 => Anode2,
			  anode3 => Anode3,

 A => A,
 B => B,
 C => C,
 D => D,
 E => E,
 F => F,
 G => G 
);

LED0 <= led0_in;
LED1 <= led1_in;
LED2 <= led2_in;
LED3 <= led3_in;
LED4 <= led4_in;
LED5 <= led5_in;
LED6 <= led6_in;

end Behavioral;

