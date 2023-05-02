library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROTL_3 is
    Generic(w : integer);
    Port ( yi : in STD_LOGIC_VECTOR (w-1 downto 0);
           yo : out STD_LOGIC_VECTOR (w-1 downto 0));
end ROTL_3;

architecture Behavioral of ROTL_3 is

begin

yo <= yi(w-4 downto 0) & yi(w-1 downto w-3);


end Behavioral;
