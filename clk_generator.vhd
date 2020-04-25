LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;

ENTITY clk_generator IS
PORT(clk_in:IN STD_LOGIC; clk_out:OUT STD_LOGIC);
END clk_generator;


ARCHITECTURE a1 OF clk_generator IS
SIGNAL clk_sig:STD_LOGIC;

BEGIN

PROCESS(clk_in)
VARIABLE c:INTEGER := 0;

BEGIN
IF (clk_in'EVENT AND clk_in = '1') THEN --RISING_EDGE(CLK_IN)
IF (C=1249999) THEN
clk_sig <= NOT clk_sig;
c := 0;
ELSE
c := c+1;
END IF;
END IF;
END PROCESS;

clk_out <= clk_sig;

END a1;