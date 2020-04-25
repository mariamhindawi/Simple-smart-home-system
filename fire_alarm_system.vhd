LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fire_alarm_system IS
PORT(
enable,reset,smoke: IN std_logic;
buzzer: OUT std_Logic);
END fire_alarm_system;


ARCHITECTURE a1 OF fire_alarm_system IS
SIGNAL dff: std_logic;

BEGIN

PROCESS(enable,reset,smoke)
BEGIN

IF(enable='0') THEN
dff <= '0';
ELSE

IF(smoke='0') THEN
dff <= '1';
ELSIF(reset='1') THEN
dff <= '0';

END IF;
END IF;
END PROCESS;

buzzer <= dff;

END a1;