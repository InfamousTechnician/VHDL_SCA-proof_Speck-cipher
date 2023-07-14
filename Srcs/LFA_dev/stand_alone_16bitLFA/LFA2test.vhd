library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity LFA2test is
end LFA2test;

architecture Behavioral of LFA2test is

    component LFA2 is
        Port ( x : in STD_LOGIC_VECTOR (1 downto 0);
               y : in STD_LOGIC_VECTOR (1 downto 0);
               s : out STD_LOGIC_VECTOR (1 downto 0);
               p, g : out STD_LOGIC);
    end component;

    signal x : STD_LOGIC_VECTOR (1 downto 0);
    signal y : STD_LOGIC_VECTOR (1 downto 0);
    signal s : STD_LOGIC_VECTOR (1 downto 0);
    signal p, g, test : STD_LOGIC;
    
begin

dut : LFA2 port map(x, y, s, p, g);

test <= '1' when s = (x + y) else '0';

    process begin
        x <= "00";
        y <= "00";
        wait for 1 ns; 
        x <= "01";
        wait for 1 ns; 
        x <= "10";
        wait for 1 ns; 
        x <= "11";
        wait for 1 ns; 
    
        x <= "00";
        y <= "01";
        wait for 1 ns; 
        x <= "01";
        wait for 1 ns; 
        x <= "10";
        wait for 1 ns; 
        x <= "11";
        wait for 1 ns; 
    
        x <= "00";
        y <= "10";
        wait for 1 ns; 
        x <= "01";
        wait for 1 ns; 
        x <= "10";
        wait for 1 ns; 
        x <= "11";
        wait for 1 ns; 
    
        x <= "00";
        y <= "11";
        wait for 1 ns; 
        x <= "01";
        wait for 1 ns; 
        x <= "10";
        wait for 1 ns; 
        x <= "11";
        wait for 1 ns;
        
        wait; 
    
    end process;
    
end Behavioral;
