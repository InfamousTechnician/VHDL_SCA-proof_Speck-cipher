library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity LFA16test is
end LFA16test;

architecture Behavioral of LFA16test is

    component LFA16 is
        Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
               y : in STD_LOGIC_VECTOR (15 downto 0);
               s : out STD_LOGIC_VECTOR (15 downto 0);
               p, g : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    signal x : STD_LOGIC_VECTOR (15 downto 0);
    signal y : STD_LOGIC_VECTOR (15 downto 0);
    signal s : STD_LOGIC_VECTOR (15 downto 0);
    signal p, g : STD_LOGIC_VECTOR (15 downto 0);
    signal test : STD_LOGIC;
    
begin

dut : LFA16 port map(x, y, s, p, g);

test <= '1' when s = (x + y) else '0';

    process begin
        x <= x"1121";
        y <= x"22a1";
        wait for 1 ns; 
        x <= x"3322";
        wait for 1 ns; 
        x <= x"4423";
        wait for 1 ns; 
        x <= x"5524";
        wait for 1 ns;
        
        x <= x"6631";
        y <= x"77b4";
        wait for 1 ns; 
        x <= x"8832";
        wait for 1 ns; 
        x <= x"9933";
        wait for 1 ns; 
        x <= x"aa34";
        wait for 1 ns;
        
        x <= x"bb41";
        y <= x"ccc8";
        wait for 1 ns; 
        x <= x"dd42";
        wait for 1 ns; 
        x <= x"ee43";
        wait for 1 ns; 
        x <= x"ff44";
        wait for 1 ns;
        
        x <= x"7f51";
        y <= x"3dc8";
        wait for 1 ns; 
        x <= x"9d75";
        wait for 1 ns; 
        x <= x"5b93";
        wait for 1 ns; 
        x <= x"fcef";
        wait for 1 ns;
        
        x <= "1100010100101001";
        y <= "0011101011010111";
        wait for 1 ns;
        x <= "0010100111000101";
        y <= "1101011100111010";
        wait for 1 ns;
        
        wait; 
    
    end process;
    
end Behavioral;
