----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:33:14 10/13/2014 
-- Design Name: 
-- Module Name:    active_low_sr_latch - sr_latch 
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

entity active_low_sr_latch is
    Port ( S_bar : in  STD_LOGIC;
           R_bar : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end active_low_sr_latch;

architecture sr_latch of active_low_sr_latch is

signal int_t, int_s : std_logic;

begin

int_t <= not(s_bar and int_s);
int_s <= not(r_bar and int_t);

Q <= int_t;

end sr_latch;

