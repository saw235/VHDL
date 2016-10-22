----------------------------------------------------------------------------
-- Entity:        PS2KBD_ScanCodeReader
-- Written By:    Saw Xue Zheng
-- Date Created:  10/19/2016
-- Description:   Component to get a scan code from PS/2 Keyboard
--
-- Revision History (date, initials, description):
-- 	19 Oct 16, xps5001, file created.

-- Dependencies:
--		ScanCodeReaderFSM
--		ScanCodeDataPath
----------------------------------------------------------------------------


library IEEE;
library XPS5001_Library;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use XPS5001_Library.XPS5001_Components.ALL;



entity PS2KBD_ScanCodeReader is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           KB_DAT : in  STD_LOGIC;
           KB_CLK : in  STD_LOGIC;
           CODE_READY : out  STD_LOGIC;
           SCAN_CODE : out  STD_LOGIC_VECTOR (7 downto 0));
end PS2KBD_ScanCodeReader;

architecture Structural of PS2KBD_ScanCodeReader is

begin


end Structural;

