----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:59:04 11/17/2014 
-- Design Name: 
-- Module Name:    fouronemux - Behavioral 
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

entity fouronemux is
    Port ( i0 : in  STD_LOGIC;
           i1 : in  STD_LOGIC;
           i2 : in  STD_LOGIC;
           i3 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           d : out  STD_LOGIC);
end fouronemux;

architecture Behavioral of fouronemux is

begin

d <= (i0 and not s0 and not s1 )or ( i1 and not s0 and s1) or (i2 and s0 and not s1)or (i3 and s0 and s1);

end Behavioral;

