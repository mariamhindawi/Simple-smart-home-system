LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.STD_LOGIC_UNSIGNED.ALL;

ENTITY smart_home_system IS
PORT(
--fire_alarm_system
enable_fire_alarm_system,reset_fire_alarm_system,smoke_sensor: IN std_logic;
buzzer: OUT std_Logic;

--wakeup_system
clk,enable_wakeup_system,reset_wakeup_system,press_clock,press_alarm: IN STD_LOGIC;
--buzzer: OUT STD_LOGIC; (same as above)
lights_wakeup:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
ssd_time_1,ssd_time_0,ssd_alarm_1,ssd_alarm_0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);

--theft_alarm_system
enable_theft_alarm_system: IN STD_LOGIC;
--ir_sensor: IN STD_LOGIC; (same as below)
--buzzer: OUT STD_LOGIC; (same as above)
lights_alarm: OUT STD_LOGIC;

--room_system
enable_room_system,counter_reset,light_sensor: IN STD_LOGIC;
--clk: IN STD_LOGIC; (same as above)
ir_sensors: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
count1,count0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
lights_room: OUT STD_LOGIC

);
END smart_home_system;


ARCHITECTURE a1 OF smart_home_system IS

COMPONENT fire_alarm_system
PORT(
enable,reset,smoke: IN std_logic;
buzzer: OUT std_Logic);
END COMPONENT;

COMPONENT wakeup_system
PORT(
clk,stop,reset,press_clock,press_alarm: IN STD_LOGIC;
buzzer: OUT STD_LOGIC;
leds:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
o1,o0,o11,o10: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END COMPONENT;

COMPONENT theft_alarm_system
PORT(
enable,obstacle: IN STD_LOGIC;
buzzer: OUT STD_LOGIC;
lights: OUT STD_LOGIC);
END COMPONENT;

COMPONENT room_system
PORT(
enable,counter_reset,light_sensor,clk: IN STD_LOGIC;
ir_sensors: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
count1,count0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
lights: OUT STD_LOGIC);
END COMPONENT;


SIGNAL buzzer1,buzzer2,buzzer3: STD_LOGIC;

BEGIN

c1: theft_alarm_system PORT MAP (enable_theft_alarm_system,ir_sensors(0),buzzer1,lights_alarm);
c2: fire_alarm_system PORT MAP (enable_fire_alarm_system,reset_fire_alarm_system,smoke_sensor,buzzer2);
c3: wakeup_system PORT MAP (clk,enable_wakeup_system,reset_wakeup_system,press_clock,press_alarm,buzzer3,lights_wakeup,ssd_time_1,ssd_time_0,ssd_alarm_1,ssd_alarm_0);
c4: room_system PORT MAP (enable_room_system,counter_reset,light_sensor,clk,ir_sensors,count1,count0,lights_room);

buzzer <= buzzer1 OR buzzer2 OR buzzer3;

END a1;