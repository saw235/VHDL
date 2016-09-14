----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:01:28 10/27/2014 
-- Design Name: 
-- Module Name:    VictoryCircuit - Behavioral 
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

entity VictoryCircuit is
    Port ( 
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
           anode : out  STD_LOGIC);
end VictoryCircuit;

architecture Behavioral of VictoryCircuit is
component DFF is
 port ( Clk_DFF : in  STD_LOGIC;
           D_DFF : in  STD_LOGIC;
			  RST   : in STD_LOGIC;
           Q_DFF : out  STD_LOGIC);
	
end component;

signal PS0, PS1, NS1, NS0: STD_LOGIC;

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


NS0 <= not PS1 and ((RightBt and RightMLED and not LeftBt and not PS0) or PS0);
NS1 <= not PS0 and ((LeftBt and not RightBt and LeftMLED and not PS1) or PS1);

anode <= not(PS0 xor PS1);

out0 <= PS0 and not PS1;
out1 <= '0';
out2 <= PS0 and not PS1;
out3 <= not PS0 and PS1;

end Behavioral;

