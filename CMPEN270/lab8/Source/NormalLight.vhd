------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 11/4/14
-- Lab # and name	: Lab7 Normal Light
-- Student 1		: Saw Xue Zheng
-- Student 2		: Ryan Kelley


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

entity NormalLight is
    Port ( LeftBt : in  STD_LOGIC;
           RightBt : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           LeftN : in  STD_LOGIC;
           RightN : in  STD_LOGIC;
           LightOn : out  STD_LOGIC);
end NormalLight;

architecture Behavioral of NormalLight is

component dff271 is
 port ( clk : in STD_LOGIC;
           d : in STD_LOGIC;
			  rst   : in STD_LOGIC;
           q : out STD_LOGIC);
	
end component;

signal wire1, wire2, NS0, PS0: STD_LOGIC;
 
begin

dff1 : dff271 port map 
(
	clk => Clk,
	d => NS0,
	rst => Rst,
	q => PS0
);


wire1 <= LeftN and (not RightN) and RightBt and (not LeftBt);
wire2 <= RightN and (not LeftN) and LeftBt and (not RightBt);
NS0 <= ((not PS0) and (wire1 or wire2)) or (PS0 and (not (LeftBt xor RightBt)));
LightOn <= PS0;

end Behavioral;

