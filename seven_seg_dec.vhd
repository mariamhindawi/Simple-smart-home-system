LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;

ENTITY seven_seg_dec IS
Port (a,b,c,d:IN STD_LOGIC; x6,x5,x4,x3,x2,x1,x0:OUT STD_LOGIC);
END seven_seg_dec;


ARCHITECTURE a1 OF seven_seg_dec IS
BEGIN
x0 <= NOT((NOT b AND NOT d) OR c OR (b AND d) OR a);
x1 <= NOT(NOT b OR (NOT c AND NOT d) OR (c AND d));
x2 <= NOT(NOT c OR d OR b);
x3 <= NOT((NOT b AND NOT d) OR (NOT b AND c) OR (b AND NOT c AND d) OR (c AND NOT d) OR a);
x4 <= NOT((NOT b AND NOT d) OR (c AND NOT d) );
x5 <= NOT((NOT c AND NOT d) OR (b AND NOT c) OR (b AND NOT d) OR a);
x6 <= NOT((NOT b AND c) OR(b AND NOT c) OR a OR (b AND NOT d));
END a1;