library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LFA8 is
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
           y : in STD_LOGIC_VECTOR (7 downto 0);
           s : out STD_LOGIC_VECTOR (7 downto 0);
           p, g : out STD_LOGIC_VECTOR (7 downto 0));
end LFA8;

architecture Behavioral of LFA8 is
    
    component carry_operator is
        Port ( propLi : in STD_LOGIC;
               genrLi : in STD_LOGIC;
               propHi : in STD_LOGIC;
               genrHi : in STD_LOGIC;
               prop_o : out STD_LOGIC;
               genr_o : out STD_LOGIC);
    end component;
    
    component LFA4 is
        Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
               y : in STD_LOGIC_VECTOR (3 downto 0);
               s : out STD_LOGIC_VECTOR (3 downto 0);
               p, g : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal xL, xH, yL, yH, sL, sH : std_logic_vector(3 downto 0);
    signal gi, pi : std_logic_vector(7 downto 0);
    signal po, go : std_logic_vector(7 downto 4);
    
begin

xL <= x(3 downto 0);
yL <= y(3 downto 0);
xH <= x(7 downto 4);
yH <= y(7 downto 4);

LFA4_instL : LFA4 port map (xL, yL, sL, pi(3 downto 0), gi(3 downto 0));

LFA4_instH : LFA4 port map (xH, yH, sH, pi(7 downto 4), gi(7 downto 4));

carry_op_inst4 : carry_operator port map(
    propLi => pi(3),
    genrLi => gi(3),
    propHi => pi(4),
    genrHi => gi(4),
    prop_o => po(4),
    genr_o => go(4));

carry_op_inst5 : carry_operator port map(
    propLi => pi(3),
    genrLi => gi(3),
    propHi => pi(5),
    genrHi => gi(5),
    prop_o => po(5),
    genr_o => go(5));

carry_op_inst6 : carry_operator port map(
    propLi => pi(3),
    genrLi => gi(3),
    propHi => pi(6) ,
    genrHi => gi(6),
    prop_o => po(6),
    genr_o => go(6));

carry_op_inst7 : carry_operator port map(
    propLi => pi(3),
    genrLi => gi(3),
    propHi => pi(7),
    genrHi => gi(7),
    prop_o => po(7),
    genr_o => go(7));

s <= (sH & sL);-- xor (go(6 downto 4) & gi(3 downto 0) & '0'); -- yepp, only generates are needed as carries! :)

g <= go & gi(3 downto 0);
p <= po & pi(3 downto 0);

end Behavioral;
