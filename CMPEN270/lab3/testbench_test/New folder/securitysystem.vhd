----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:31:16 09/15/2014 
-- Design Name: 
-- Module Name:    securitysystem - Behavioral 
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

entity securitysystem is
    Port ( switch1 : in  STD_LOGIC;
           switch2 : in  STD_LOGIC;
           switch3 : in  STD_LOGIC;
           switch4 : in  STD_LOGIC;
           ss_normalop: out  STD_LOGIC);
end securitysystem;

architecture Behavioral of securitysystem is

begin

ss_normalop <= (NOT switch1) AND switch2 AND (NOT switch3) AND switch4;

end Behavioral;

