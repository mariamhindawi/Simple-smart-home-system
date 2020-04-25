LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;

ENTITY clk_lights IS
PORT(
enable,clk_in:IN STD_LOGIC;
leds:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END clk_lights;


ARCHITECTURE a1 OF clk_lights IS
BEGIN

PROCESS(enable,clk_in)
VARIABLE c:INTEGER := 0;

BEGIN

IF (enable='0') THEN
leds <= "0000";
c := 0;
ELSE
IF (clk_in'EVENT AND clk_in = '1') THEN
IF (C<3) THEN
leds <= "0001";
c := c+1;
ELSIF (c<6) THEN
leds <= "0011";
c := c+1;
ELSIF (c<9) THEN
leds <= "0111";
c := c+1;
ELSE
leds <= "1111";

END IF;
END IF;
END IF;
END PROCESS;

END a1;