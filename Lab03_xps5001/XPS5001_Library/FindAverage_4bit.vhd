library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FindAverage_4bit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           C : in  STD_LOGIC_VECTOR (3 downto 0);
           D : in  STD_LOGIC_VECTOR (3 downto 0);
           AVERAGE : out  STD_LOGIC_VECTOR (3 downto 0));
end FindAverage_4bit;

architecture Behavioral of FindAverage_4bit is


	--Internal Signals (Use 7 bit for SUM to safeguard overflow)
	signal SUM : STD_LOGIC_VECTOR (6 downto 0);	
begin
	
	SUM <= STD_LOGIC_VECTOR(to_signed(to_integer(signed(A)) + to_integer(signed(B))
			 + to_integer(signed(C)) + to_integer(signed(D)),7));
	AVERAGE <= STD_LOGIC_VECTOR(to_signed(to_integer(signed((SUM(5 downto 2)))) + 1,4)) --round up 
				  when ( SUM(5) = '0' and SUM(1) = '1') else --if positive number and 0.5
				  
				  STD_LOGIC_VECTOR(to_signed(to_integer(signed((SUM(5 downto 2)))) + 1,4)) --round up
				  when ( SUM(5) = '1' and SUM(1 downto 0) = "11" ) else --if negative number and 0.5
				  SUM(5 downto 2);
				  
	
end Behavioral;

