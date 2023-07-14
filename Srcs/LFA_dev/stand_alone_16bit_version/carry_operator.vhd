library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity carry_operator is
    Port ( propLi : in STD_LOGIC;
           genrLi : in STD_LOGIC;
           propHi : in STD_LOGIC;
           genrHi : in STD_LOGIC;
           prop_o : out STD_LOGIC;
           genr_o : out STD_LOGIC);
end carry_operator;

architecture Behavioral of carry_operator is

begin

    prop_o <= propLi and propHi;
    genr_o <= genrHi or (genrLi and propHi);

end Behavioral;
