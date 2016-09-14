----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:21:58 09/16/2014 
-- Design Name: 
-- Module Name:    service_mode - service 
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

entity service_mode is
    Port ( sw1 : in  STD_LOGIC;
           sw2 : in  STD_LOGIC;
           sw3 : in  STD_LOGIC;
           sw4 : in  STD_LOGIC;
           sm_normalop : out  STD_LOGIC);
end service_mode;

architecture service of service_mode is

begin

sm_normalop <= NOT((NOT sw1) and sw2 and sw3 and (NOT sw4)); 

end service;

