LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY theft_alarm_system IS
PORT(
enable,obstacle: IN STD_LOGIC;
buzzer: OUT STD_LOGIC;
--leds: OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
lights: OUT STD_LOGIC);
END theft_alarm_system;


ARCHITECTURE a1 OF theft_alarm_system IS

BEGIN

PROCESS(enable, obstacle)

BEGIN

IF (enable = '0') THEN
lights <= '0';
buzzer <= '0';
ELSIF (OBSTACLE = '0') THEN
lights <= '1';
BUZZER <= '1';

END IF;
END PROCESS;

END a1;