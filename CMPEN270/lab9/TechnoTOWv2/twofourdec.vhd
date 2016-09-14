----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:55:24 11/17/2014 
-- Design Name: 
-- Module Name:    twofourdec - Behavioral 
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

entity twofourdec is --active low
    Port ( s0 : in  STD_LOGIC; --s0 left most bit
           s1 : in  STD_LOGIC;
           d0 : out  STD_LOGIC;
           d1 : out  STD_LOGIC;
           d2 : out  STD_LOGIC;
           d3 : out  STD_LOGIC);
end twofourdec;

architecture Behavioral of twofourdec is

begin

d0 <= not ( not s0 and not s1);
d1 <= not ( not s0 and s1);
d2 <= not ( s0 and not s1);
d3 <= not (s0 and s1);

end Behavioral;

