library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all;

entity masked_add is
    Generic(w : integer := 128);
    Port ( a1i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"f111";
           a2i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"f222";
           a3i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"f456";
           b1i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"faaa";
           b2i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"fbbb";
           b3i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"fdef";
           s1o : inout STD_LOGIC_VECTOR (w downto 0);
           s2o : inout STD_LOGIC_VECTOR (w downto 0);
           s3o : inout STD_LOGIC_VECTOR (w downto 0);
           helyes : out STD_LOGIC_VECTOR (w-1 downto 0);
           teszt : out STD_LOGIC_VECTOR (w downto 0));
end masked_add;

architecture Behavioral of masked_add is

component masked_full_adder is
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
end component;

signal carry1, carry2, carry3: STD_LOGIC_VECTOR(w-1 downto 1);

begin

first_inst: masked_full_adder
    port map (
        a1  => a1i(0),
        a2  => a2i(0),
        a3  => a3i(0),
        b1  => b1i(0),
        b2  => b2i(0),
        b3  => b3i(0),
        c1  => '0',
        c2  => '0',
        c3  => '0',
        s1  => s1o(0),
        s2  => s2o(0),
        s3  => s3o(0),
        c1o  => carry1(1),
        c2o  => carry2(1),
        c3o  => carry3(1));

generate_masked_adder: for i in 1 to w-2 generate
    w_insts: masked_full_adder
        port map (
            a1  => a1i(i),
            a2  => a2i(i),
            a3  => a3i(i),
            b1  => b1i(i),
            b2  => b2i(i),
            b3  => b3i(i),
            c1  => carry1(i),
            c2  => carry2(i),
            c3  => carry3(i),
            s1  => s1o(i),
            s2  => s2o(i),
            s3  => s3o(i),
            c1o  => carry1(i+1),
            c2o  => carry2(i+1),
            c3o  => carry3(i+1));
end generate;

last_inst: masked_full_adder
    port map (
        a1  => a1i(w-1),
        a2  => a2i(w-1),
        a3  => a3i(w-1),
        b1  => b1i(w-1),
        b2  => b2i(w-1),
        b3  => b3i(w-1),
        c1  => carry1(w-1),
        c2  => carry2(w-1),
        c3  => carry3(w-1),
        s1  => s1o(w-1),
        s2  => s2o(w-1),
        s3  => s3o(w-1),
        c1o  => s1o(w),
        c2o  => s2o(w),
        c3o  => s3o(w));

-- TESTING

correct <= (a1i xor a2i xor a3i) + (b1i xor b2i xor b3i);
testing <= s1o xor s2o xor s3o;

end Behavioral;
