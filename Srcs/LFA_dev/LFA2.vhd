library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LFA2 is
    Port ( x : in STD_LOGIC_VECTOR (1 downto 0);
           y : in STD_LOGIC_VECTOR (1 downto 0);
           s : out STD_LOGIC_VECTOR (1 downto 0);
           p, g : out STD_LOGIC);
end LFA2;

architecture Behavioral of LFA2 is

    component carry_operator is
        Port ( propLi : in STD_LOGIC;
               genrLi : in STD_LOGIC;
               propHi : in STD_LOGIC;
               genrHi : in STD_LOGIC;
               prop_o : out STD_LOGIC;
               genr_o : out STD_LOGIC);
    end component;

    signal pi, gi : std_logic_vector(1 downto 0);
    
begin

s <= x xor y;

pi <= x xor y;  -- xor bc. if bith are 1, the output is 0 again, and it kills the carry
gi <= x and y;  -- and, bc. if both are 1, a carry is generated at that position
                -- so a stage either generates or propagates a carry...(*)

carry_op_inst0 : carry_operator port map(
    propLi => '0',   --there is nothing to propagate without 'carry in'
    genrLi => gi(0),
    propHi => pi(1),
    genrHi => gi(1),
    prop_o => p,
    genr_o => g);

end Behavioral;
