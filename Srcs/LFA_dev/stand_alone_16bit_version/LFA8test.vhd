library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity LFA8test is
end LFA8test;

architecture Behavioral of LFA8test is

    component LFA8 is
        Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
               y : in STD_LOGIC_VECTOR (7 downto 0);
               s : out STD_LOGIC_VECTOR (7 downto 0);
               p, g : inout STD_LOGIC);
    end component;

    signal x : STD_LOGIC_VECTOR (7 downto 0);
    signal y : STD_LOGIC_VECTOR (7 downto 0);
    signal s : STD_LOGIC_VECTOR (7 downto 0);
    signal p, g, test : STD_LOGIC;
    
begin

dut : LFA8 port map(x, y, s, p, g);

test <= '1' when s = (x + y) else '0';

    process begin
        x <= x"21";
        y <= x"a1";
        wait for 1 ns; 
        x <= x"22";
        wait for 1 ns; 
        x <= x"23";
        wait for 1 ns; 
        x <= x"24";
        wait for 1 ns;
        
        x <= x"31";
        y <= x"b4";
        wait for 1 ns; 
        x <= x"32";
        wait for 1 ns; 
        x <= x"33";
        wait for 1 ns; 
        x <= x"34";
        wait for 1 ns;
        
        x <= x"41";
        y <= x"c8";
        wait for 1 ns; 
        x <= x"42";
        wait for 1 ns; 
        x <= x"43";
        wait for 1 ns; 
        x <= x"44";
        wait for 1 ns;
        
        x <= x"f5";
        y <= x"dc";
        wait for 1 ns; 
        x <= x"d7";
        wait for 1 ns; 
        x <= x"b9";
        wait for 1 ns; 
        x <= x"ce";
        wait for 1 ns;
        
        x <= "11000101";
        y <= "00111010";
        wait for 1 ns;
        x <= "00101001";
        y <= "11010111";
        wait for 1 ns;
        
        wait; 
    
    end process;
    
end Behavioral;
