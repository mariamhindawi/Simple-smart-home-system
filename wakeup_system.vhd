LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;

ENTITY wakeup_system IS
PORT(clk,stop,reset,press_clock,press_alarm: IN STD_LOGIC;
buzzer: OUT STD_LOGIC;
leds:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
o1,o0,o11,o10: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END wakeup_system;

ARCHITECTURE a1 OF wakeup_system IS
SIGNAL clk_x,clk_new: STD_LOGIC;
SIGNAL lights_counter_enable: STD_LOGIC;
SIGNAL x1,x0,y1,y0: STD_LOGIC_VECTOR(3 DOWNTO 0);

COMPONENT clk_minute
PORT(clk_in:IN STD_LOGIC; clk_out:OUT STD_LOGIC);
END COMPONENT;

COMPONENT clk_second
PORT(clk_in:IN STD_LOGIC; clk_out:OUT STD_LOGIC);
END COMPONENT;

COMPONENT minute_counter
PORT(clk,press,reset:IN STD_LOGIC; o1,o0:OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END COMPONENT;


COMPONENT counterin
PORT(press,reset:IN STD_LOGIC; o1,o0:OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END COMPONENT;

COMPONENT seven_seg_dec
Port (a,b,c,d:IN STD_LOGIC; x6,x5,x4,x3,x2,x1,x0:OUT STD_LOGIC);
END COMPONENT;

COMPONENT clk_lights
PORT(
enable,clk_in:IN STD_LOGIC;
leds:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END COMPONENT;


BEGIN
c1: clk_second PORT MAP (clk,clk_x);
c2: clk_minute PORT MAP (clk_x,clk_new);
s: minute_counter PORT MAP (clk_new,press_clock,reset,x1,x0);
ci: counterin PORT MAP (press_alarm,reset,y1,y0);
d1: seven_seg_dec PORT MAP (x1(3),x1(2),x1(1),x1(0),o1(6),o1(5),o1(4),o1(3),o1(2),o1(1),o1(0));
d0: seven_seg_dec PORT MAP (x0(3),x0(2),x0(1),x0(0),o0(6),o0(5),o0(4),o0(3),o0(2),o0(1),o0(0));
Counter1: seven_seg_dec PORT MAP (y1(3),y1(2),y1(1),y1(0),o11(6),o11(5),o11(4),o11(3),o11(2),o11(1),o11(0));
Counter0: seven_seg_dec PORT MAP (y0(3),y0(2),y0(1),y0(0),o10(6),o10(5),o10(4),o10(3),o10(2),o10(1),o10(0));
lights: clk_lights PORT MAP (lights_counter_enable,clk_x,leds);

PROCESS(stop)
BEGIN

IF(stop ='0') THEN
buzzer <= '0';
lights_counter_enable <= '0';
ELSE

IF(y1=x1 AND y0=x0) THEN 
buzzer <= '1';
lights_counter_enable <= '1';
ELSE
buzzer<='0';
lights_counter_enable <= '0';

END IF;
END IF;
END PROCESS;

END a1;