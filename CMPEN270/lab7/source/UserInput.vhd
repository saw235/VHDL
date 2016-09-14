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
component DFF is
 port ( Clk_DFF : in STD_LOGIC;
           D_DFF : in STD_LOGIC;
			  RST   : in STD_LOGIC;
           Q_DFF : out STD_LOGIC);
	
end component;

--internal signals 	
signal PS0, PS1, NS0, NS1: STD_LOGIC;

begin

DFF0 : DFF port map 

  (Clk_DFF => clk,
	D_DFF => NS0,
	RST => rst,
	Q_DFF => PS0
	);
	
DFF1 : DFF port map
   
   (Clk_DFF => clk,
	D_DFF => NS1,
	RST => rst,
	Q_DFF => PS1
	);
  

NS0 <= PS1 and not input;
NS1 <= not PS0 and input;

input_pulse <= PS0;

end U_input;

