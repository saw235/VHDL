----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:01:15 10/13/2014 
-- Design Name: 
-- Module Name:    D-latch - d-latch 
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

entity Dlatch is
    Port ( Clk : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end Dlatch;

architecture dlatch of Dlatch is

component active_low_sr_latch 
	Port ( S_bar : in  STD_LOGIC;
           R_bar : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end component;

signal int_s_bar, int_r_bar, int_s1_bar, int_r1_bar, int_Q : std_logic;

begin

alsrlatch : active_low_sr_latch Port map (
			S_bar => int_s1_bar,
			R_bar => int_r1_bar,
			Q => int_Q
			);
			
int_s_bar <= D;
int_r_bar <= not int_s_bar;

int_s1_bar <= int_s_bar or Clk;
int_r1_bar <= int_r_bar or Clk;

Q <= int_Q; 

end dlatch;

