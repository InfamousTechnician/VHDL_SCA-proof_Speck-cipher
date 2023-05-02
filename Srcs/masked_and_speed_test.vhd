library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity masked_and_speed_test is
    Generic(w : integer := 64);
    Port ( clock : in STD_LOGIC;
           a1i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"f111";
           a2i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"f222";
           a3i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"f456";
           b1i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"faaa";
           b2i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"fbbb";
           b3i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"fdef";
           s1o : out STD_LOGIC_VECTOR (w downto 0);
           s2o : out STD_LOGIC_VECTOR (w downto 0);
           s3o : out STD_LOGIC_VECTOR (w downto 0));
end masked_and_speed_test;

architecture Behavioral of masked_and_speed_test is

component masked_add is
    Generic(w : integer);
    Port ( a1i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"f111";
           a2i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"f222";
           a3i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"f456";
           b1i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"faaa";
           b2i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"fbbb";
           b3i : in STD_LOGIC_VECTOR (w-1 downto 0) := x"fdef";
           s1o : out STD_LOGIC_VECTOR (w downto 0);
           s2o : out STD_LOGIC_VECTOR (w downto 0);
           s3o : out STD_LOGIC_VECTOR (w downto 0));
end component;

signal a1ii,
       a2ii,
       a3ii,
       b1ii,
       b2ii,
       b3ii :  std_logic_vector(w-1 downto 0);  
signal s1oi,
       s2oi,
       s3oi :  std_logic_vector(w downto 0);  

begin


process(clock) begin
    if rising_edge(clock) then
            a1ii  <= a1i;
            a2ii  <= a2i;
            a3ii  <= a3i;
            b1ii  <= b1i;
            b2ii  <= b2i;
            b3ii  <= b3i;
            s1o  <= s1oi;
            s2o  <= s2oi;
            s3o  <= s3oi; 
    end if;
end process;

inst : masked_add
    generic map(w)
    port map(
            a1i  => a1ii,
            a2i  => a2ii,
            a3i  => a3ii,
            b1i  => b1ii,
            b2i  => b2ii,
            b3i  => b3ii,
            s1o  => s1oi,
            s2o  => s2oi,
            s3o  => s3oi  );


end Behavioral;
