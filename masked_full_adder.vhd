library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity masked_full_adder is
    Port ( a1 : in STD_LOGIC;
           a2 : in STD_LOGIC;
           a3 : in STD_LOGIC;
           b1 : in STD_LOGIC;
           b2 : in STD_LOGIC;
           b3 : in STD_LOGIC;
           c1 : in STD_LOGIC;
           c2 : in STD_LOGIC;
           c3 : in STD_LOGIC;
           s1 : out STD_LOGIC;
           s2 : out STD_LOGIC;
           s3 : out STD_LOGIC;
           c1o : out STD_LOGIC;
           c2o : out STD_LOGIC;
           c3o : out STD_LOGIC);
end masked_full_adder;

architecture Behavioral of masked_full_adder is

begin

s1 <= a1 xor b1 xor c1;
s2 <= a2 xor b2 xor c2;
s3 <= a3 xor b3 xor c3;

c1o <=  (a2 and b2) xor (a2 and b3) xor (a3 and b2) xor
        (a2 and c2) xor (a2 and c3) xor (a3 and c2) xor
        (b2 and c2) xor (b2 and c3) xor (b3 and c2);

c2o <=  (a3 and b3) xor (a3 and b1) xor (a1 and b3) xor
        (a3 and c3) xor (a3 and c1) xor (a1 and c3) xor
        (b3 and c3) xor (b3 and c1) xor (b1 and c3);

c3o <=  (a1 and b1) xor (a1 and b2) xor (a2 and b1) xor
        (a1 and c1) xor (a1 and c2) xor (a2 and c1) xor
        (b1 and c1) xor (b1 and c2) xor (b2 and c1);

end Behavioral;
