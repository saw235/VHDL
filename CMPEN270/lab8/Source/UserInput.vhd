----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:48:19 10/27/2014 
-- Design Name: 
-- Module Name:    UserInput - U_input 
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

entity UserInput is
    Port ( input : in  STD_LOGIC;
			   clk : in STD_LOGIC;
				rst : in STD_LOGIC;
           input_pulse : out  STD_LOGIC);
end UserInput;

architecture U_input of UserInput is

--flipflops for FSM
component dff271 is
 port ( clk : in STD_LOGIC;
           d : in STD_LOGIC;
			  rst   : in STD_LOGIC;
           q : out STD_LOGIC);
	
end component;

--internal signals 	
signal PS0, PS1, NS0, NS1: STD_LOGIC;

begin

DFF0 : dff271 port map 

  (clk => clk,
	d => NS0,
	rst => rst,
	q => PS0
	);
	
DFF1 : dff271 port map
   
   (clk => clk,
	d => NS1,
	rst => rst,
	q => PS1
	);
  

NS0 <= PS1 and not input;
NS1 <= not PS0 and input;

input_pulse <= PS0;

end U_input;

