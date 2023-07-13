library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity LFA4test is
end LFA4test;

architecture Behavioral of LFA4test is

    component LFA4 is
        Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
               y : in STD_LOGIC_VECTOR (3 downto 0);
               s : out STD_LOGIC_VECTOR (3 downto 0);
               p, g : out STD_LOGIC);
    end component;

    signal x : STD_LOGIC_VECTOR (3 downto 0);
    signal y : STD_LOGIC_VECTOR (3 downto 0);
    signal s : STD_LOGIC_VECTOR (3 downto 0);
    signal p, g, test : STD_LOGIC;
    
begin

dut : LFA4 port map(x, y, s, p, g);

test <= '1' when s = (x + y) else '0';

    process begin
        x <= x"1";
        y <= x"1";
        wait for 1 ns; 
        x <= x"2";
        wait for 1 ns; 
        x <= x"3";
        wait for 1 ns; 
        x <= x"4";
        wait for 1 ns;
        
        x <= x"1";
        y <= x"4";
        wait for 1 ns; 
        x <= x"2";
        wait for 1 ns; 
        x <= x"3";
        wait for 1 ns; 
        x <= x"4";
        wait for 1 ns;
        
        x <= x"1";
        y <= x"8";
        wait for 1 ns; 
        x <= x"2";
        wait for 1 ns; 
        x <= x"3";
        wait for 1 ns; 
        x <= x"4";
        wait for 1 ns;
        
        x <= x"5";
        y <= x"c";
        wait for 1 ns; 
        x <= x"7";
        wait for 1 ns; 
        x <= x"9";
        wait for 1 ns; 
        x <= x"e";
        wait for 1 ns;
        
        wait; 
    
    end process;
    
end Behavioral;
