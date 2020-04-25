LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.STD_LOGIC_UNSIGNED.ALL;

ENTITY minute_counter IS
PORT(clk,press,reset:IN STD_LOGIC; o1,o0:OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END minute_counter;


ARCHITECTURE a1 OF minute_counter IS
SIGNAL clk_new: STD_LOGIC;
SIGNAL x1,x0: STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

clk_new <= clk or not (press);

p1:PROCESS(clk_new)
BEGIN

IF(reset='1') THEN
x1 <= "0000";
x0 <= "0000";
ELSE

IF(clk_new'EVENT AND clk_new='1') THEN

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

END IF;
END PROCESS;

o1 <= x1;
o0 <= x0;

END a1;
