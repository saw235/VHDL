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

entity TugOfWarCircuit is
    Port ( LeftBt : in  STD_LOGIC;
           RightBt : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
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
end TugOfWarCircuit;

architecture Behavioral of TugOfWarCircuit is

----LED 0-2, 4-6
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

--Output to 7 seg display depending on left or right player wins
component VictoryCircuit is port
(
clk : in STD_LOGIC;
			  rst : in  STD_LOGIC;
           LeftBt : in  STD_LOGIC;
           RightBt : in  STD_LOGIC;
           LeftMLED : in  STD_LOGIC;
           RightMLED : in  STD_LOGIC;
           out0 : out  STD_LOGIC;
           out1 : out  STD_LOGIC;
           out2 : out  STD_LOGIC;
           out3 : out  STD_LOGIC;
           anode : out  STD_LOGIC
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

signal anode, leftbt1, rightbt1, led0_in, led1_in, led2_in, led3_in, led4_in, led5_in, led6_in, out0, out1, out2, out3:STD_LOGIC; 
begin

--button to shift led to left
LeftB: UserInput port map
(
	input => LeftBt,
	clk => Clk,
	rst => Reset,
	input_pulse => leftbt1
);

--button to shift led to right
RightB: UserInput port map
(
	input => RightBt,
	clk => Clk,
	rst => Reset,
	input_pulse => rightbt1
);

--normal light is off by default
LED_0: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Reset,
           LeftN => led1_in,
           RightN => '0',
           LightOn => led0_in
);

LED_1: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Reset,
           LeftN => led2_in,
           RightN => led0_in,
           LightOn => led1_in
);

LED_2: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Reset,
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
           Rst =>Reset,
              LeftN => led4_in,
           RightN => led2_in,
           LightOn => led3_in
);

LED_4: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Reset,
          LeftN => led5_in,
           RightN => led3_in,
           LightOn => led4_in
);

LED_5: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Reset,
             LeftN => led6_in,
           RightN => led4_in,
           LightOn => led5_in
);

LED_6: NormalLight port map
(
	LeftBt => leftbt1,
   RightBt => rightbt1,
           Clk => Clk,
           Rst =>Reset,
           LeftN => '0',
           RightN => led5_in,
           LightOn => led6_in
);
--------------------------------
--------------------------------



Vic1: VictoryCircuit port map
(		rst => Reset,
		clk => Clk,
			LeftBt  => leftbt1,
           RightBt => rightbt1,
           LeftMLED => led6_in,
           RightMLED => led0_in,
           out0 => out0,
          out1 => out1,
			 out2 => out2,
			 out3 => out3,
           anode => anode
);

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

