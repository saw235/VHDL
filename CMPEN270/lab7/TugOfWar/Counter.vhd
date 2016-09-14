----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:15:23 11/03/2014 
-- Design Name: 
-- Module Name:    Counter - Behavioral 
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

entity Counter is
    Port ( Count : in  STD_LOGIC;
           s0 : out  STD_LOGIC;
           s1 : out  STD_LOGIC;
           s2 : out  STD_LOGIC;
           s3 : out  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
end Counter;

architecture Behavioral of Counter is

component Adder is port
(
			a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           ci : in  STD_LOGIC;
           co : out  STD_LOGIC;
           s : out  STD_LOGIC);
			  
end component;
component dff270 is port
(
		clk 	: in std_logic ;
	 clken	: in std_logic ;
		 rst 	: in std_logic ;
		 d 	: in std_logic ;
		 q 	: out std_logic
    );
end component;


begin


end Behavioral;

