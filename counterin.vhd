LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.STD_LOGIC_unsigned.ALL;

Entity counterin IS
PORT(Press, Reset: IN STD_LOGIC;
o1,o0:OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END counterin;

ARCHITECTURE a1 OF counterin IS
SIGNAL x1,x0:STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
PROCESS(Press,Reset)
BEGIN
IF(Reset = '1') THEN
x0<="0000";
x1<="0000";
ELSIF (Press'Event AND Press ='0') THEN
IF(x1 ="0010" AND x0 ="0011") THEN 
x1<="0000";
x0<="0000";
ELSIF(x0 ="1001") THEN
x0<="0000";
x1<=x1+1;
ELSE
x0<=x0+1;
END IF;
END IF;
END PROCESS;
o1 <= x1;
o0 <= x0;

END A1;