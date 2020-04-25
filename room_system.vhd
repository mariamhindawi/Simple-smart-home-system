LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.STD_LOGIC_UNSIGNED.ALL;

ENTITY room_system IS
PORT(enable,counter_reset,light_sensor,clk: IN STD_LOGIC;
ir_sensors: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
--count: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
count1,count0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
--lights: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
lights: OUT STD_LOGIC);
END room_system;


ARCHITECTURE a1 OF room_system IS

TYPE statetype IS (start,entering,exiting,entered,exited,finished_entering,finished_exiting,error);

SIGNAL currentstate,nextstate: statetype;
--SIGNAL counter: STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
SIGNAL x1,x0: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
SIGNAL clk_new: STD_LOGIC;


COMPONENT clk_generator IS
PORT(clk_in:IN STD_LOGIC; clk_out:OUT STD_LOGIC);
END COMPONENT;

COMPONENT seven_seg_dec IS
Port (a,b,c,d:IN STD_LOGIC; x6,x5,x4,x3,x2,x1,x0:OUT STD_LOGIC);
END COMPONENT;

BEGIN

c: clk_generator PORT MAP (clk,clk_new);
ssd1: seven_seg_dec PORT MAP (x1(3),x1(2),x1(1),x1(0),count1(6),count1(5),count1(4),count1(3),count1(2),count1(1),count1(0));
ssd0: seven_seg_dec PORT MAP (x0(3),x0(2),x0(1),x0(0),count0(6),count0(5),count0(4),count0(3),count0(2),count0(1),count0(0));

fsm:PROCESS(counter_reset,ir_sensors,currentstate)
BEGIN

IF (counter_reset='1' OR enable='0') THEN
nextstate <= start;
--counter<="000";
x0 <= "0000";
x1 <= "0000";
ELSIF (clk_new'EVENT AND clk_new='1') THEN

CASE currentstate IS
	WHEN start =>
		CASE ir_sensors IS
		WHEN "11" => nextstate <= start;
		WHEN "01" => nextstate <= entering;
		WHEN "10" => nextstate <= exiting;
		WHEN others => nextstate <= error;
		END CASE;
	WHEN entering =>
		CASE ir_sensors IS
		WHEN "11" => nextstate <= entering;
		WHEN "01" => nextstate <= entering;
		WHEN "10" => nextstate <= entered;
		WHEN others => nextstate <= error;
		END CASE;
	WHEN exiting =>
		CASE ir_sensors IS
		WHEN "11" => nextstate <= exiting;
		WHEN "01" => nextstate <= exited;
		WHEN "10" => nextstate <= exiting;
		WHEN others => nextstate <= error;
		END CASE;
	WHEN entered =>
		CASE ir_sensors IS
		WHEN "11" => nextstate <= finished_entering;
		WHEN "10" => nextstate <= entered;
		WHEN others => nextstate <= error;
		END CASE;
	WHEN exited =>
		CASE ir_sensors IS
		WHEN "11" => nextstate <= finished_exiting;
		WHEN "01" => nextstate <= exited;
		WHEN others => nextstate <= error;
		END CASE;
	WHEN finished_entering =>
		nextstate <= start;
--		counter <= counter+1;
		IF (x0="1001" AND x1="1001") THEN
		x0 <= "1001";
		x1 <= "1001";
		ELSIF (x0="1001") THEN
		x0 <= "0000";
		x1 <= x1+1;
		ELSE
		x0 <= x0+1;
		END IF;
	WHEN finished_exiting =>
		nextstate <= start;
--		counter <= counter-1;
		IF (x0="0000" AND x1="0000") THEN
		x0 <= "0000";
		x1 <= "0000";
		ELSIF (x0="0000") THEN
		x0 <= "1001";
		x1 <= x1-1;
		ELSE
		x0 <= x0-1;
		END IF;
	WHEN error =>
		nextstate <= start;
--		counter <= "000";
--		x0 <= "0000";
--		x1 <= "0000";
END CASE;

END IF;
END PROCESS;


proc:PROCESS(clk)
BEGIN

IF (clk'EVENT AND clk='1') THEN
currentstate <= nextstate;
--count<=counter;

END IF;
END PROCESS;


l:PROCESS(x1,x0,light_sensor,currentstate)
BEGIN

IF ((NOT (x1="0000") OR NOT(x0="0000")) AND light_sensor='1') THEN
lights <= '1';
ELSE
lights <= '0';
END IF;

END PROCESS;

END a1;
