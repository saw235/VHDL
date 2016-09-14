----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:10:25 10/28/2014 
-- Design Name: 
-- Module Name:    MidLight - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
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

entity MidLight is
 Port ( 		LeftBt : in  STD_LOGIC;
           RightBt : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           LeftN : in  STD_LOGIC;
           RightN : in  STD_LOGIC;
           LightOn : out  STD_LOGIC);
end MidLight;

architecture Behavioral of MidLight is

component dff273 is
 port ( clk : in STD_LOGIC;
           d : in STD_LOGIC;
			  rst   : in STD_LOGIC;
           q : out STD_LOGIC);
	
end component;

signal wire1, wire2, NS0, PS0, NS1, PS1: STD_LOGIC;
 
begin

ff1 : dff273 port map 
(
	clk => Clk,
	d => NS0,
	rst => Rst,
	q => PS0
);

ff2 : dff273 port map 
(
	clk => Clk,
	d => NS1,
	rst => Rst,
	q => PS1
);

wire1 <= LeftN and (not RightN) and RightBt and (not LeftBt);
wire2 <= RightN and (not LeftN) and LeftBt and (not RightBt);
NS0 <= (not PS0 and not PS1 and(not (LeftBt xor RightBt))) 
		or (not PS0 and PS1 and(wire1 or wire2)) 
		or (PS0 and PS1 and (not (LeftBt xor RightBt)));
		
NS1 <= (not PS0 and not PS1)
		or (not PS0 and PS1)
		or (PS0 and PS1);
		
LightOn <= not PS1 or PS0;

end Behavioral;

