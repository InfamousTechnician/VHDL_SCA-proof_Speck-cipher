library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROTR_8 is
    Generic(w : integer);
    Port ( xi : in STD_LOGIC_VECTOR (w-1 downto 0);
           xo : out STD_LOGIC_VECTOR (w-1 downto 0));
end ROTR_8;

architecture Behavioral of ROTR_8 is

begin

xo <= xi(7 downto 0) & xi(w-1 downto 8);

end Behavioral;
