----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:05:04 09/22/2014 
-- Design Name: 
-- Module Name:    combination - Behavioral 
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

entity combination is
    Port ( 1 : in  STD_LOGIC;
           2 : in  STD_LOGIC;
           3 : in  STD_LOGIC;
           4 : in  STD_LOGIC;
           5 : in  STD_LOGIC;
           6 : in  STD_LOGIC;
           7 : in  STD_LOGIC;
           8 : out  STD_LOGIC);
end combination;

architecture Behavioral of combination is


	component ignition_safety is port
		( 
			b 		: in std_logic		; -- Seat Belt sensor input
			d 		: in std_logic		; -- door latch sensor input
			p 		: in std_logic 	; -- parking brake sensor input
			s  	: out std_logic	  -- ignition safety circuit output
		);
end component;
	
	 COMPONENT securitysystem
    PORT(
         switch1 : IN  std_logic;
         switch2 : IN  std_logic;
         switch3 : IN  std_logic;
         switch4 : IN  std_logic;
         safe : OUT  std_logic
        );
    END COMPONENT;
	 
	 
    COMPONENT service_mode
    PORT(
         sw1 : IN  std_logic;
         sw2 : IN  std_logic;
         sw3 : IN  std_logic;
         sw4 : IN  std_logic;
         normalop : OUT  std_logic
        );
    END COMPONENT;
	
	
begin

ignition1: ignition_safety port map

end Behavioral;

