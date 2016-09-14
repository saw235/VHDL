----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:27:15 09/22/2014 
-- Design Name: 
-- Module Name:    combination_circuit - Behavioral 
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

entity combination_circuit is
    Port ( sw1 : in  STD_LOGIC;
           sw2 : in  STD_LOGIC;
           sw3 : in  STD_LOGIC;
           sw4 : in  STD_LOGIC;
           p : in  STD_LOGIC;
           b : in  STD_LOGIC;
           d : in  STD_LOGIC;
           F : out  STD_LOGIC;
			  F2 : out STD_LOGIC); -- main output
end combination_circuit;


architecture Behavioral of combination_circuit is

	component ignition_safety is port
		( 
			b 		: in std_logic		; -- Seat Belt sensor input 			--> 1 = belts buckled 
			d 		: in std_logic		; -- door latch sensor input 			--> 1 = door is closed 
			p 		: in std_logic 	; -- parking brake sensor input 		--> 1 = parking brake is on					
			s  	: out std_logic
		);
	end component;
	
	COMPONENT securitysystem is PORT(
         switch1 : in  STD_LOGIC;
         switch2 : in  STD_LOGIC;
         switch3 : in  STD_LOGIC;
         switch4 : in  STD_LOGIC;
         ss_normalop : OUT  std_logic
        );
    END COMPONENT;
	 
	 COMPONENT service_mode is PORT(
         sw1 : in  STD_LOGIC;
			sw2 : in  STD_LOGIC;
         sw3 : in  STD_LOGIC;
         sw4 : in  STD_LOGIC;
         sm_normalop : OUT  std_logic
        );
    END COMPONENT;

	signal securityout 	: std_logic;
	signal serviceout		: std_logic;
	signal igniteout		: std_logic;
	
	signal not_service	: std_logic;
	signal ignite_and_securityout : std_logic;
	signal wire_or			: std_logic;
	

begin

	igni_safe1: ignition_safety port map
	(
		b => b,
		d => d,
		p => p,
		s => igniteout
	);
		
		
	secu_sys1 : securitysystem port map(
		switch1 => sw1,
		switch2 => sw2,
		switch3 => sw3,
		switch4 => sw4,
		ss_normalop => securityout
		);
	service_m1 : service_mode port map(
		sw1 => sw1,
		sw2 => sw2,
		sw3 => sw3,
		sw4 => sw4,
		sm_normalop => serviceout 
		);
		

	not_service <= NOT serviceout;
	ignite_and_securityout <= igniteout and securityout;
	wire_or <= ignite_and_securityout or not_service;
	
	
	
	-- 1 = ignite, 0 = not ignite
	F <= igniteout; -- ignitesafety normal operation output
	F2 <= wire_or; -- overrided output



end Behavioral;

