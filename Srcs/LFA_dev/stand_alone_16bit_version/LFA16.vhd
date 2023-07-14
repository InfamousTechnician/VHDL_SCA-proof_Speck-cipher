library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LFA16 is
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           s : out STD_LOGIC_VECTOR (15 downto 0);
           p, g : out STD_LOGIC_VECTOR (15 downto 0));
end LFA16;

architecture Behavioral of LFA16 is
    
    component carry_operator is
        Port ( propLi : in STD_LOGIC;
               genrLi : in STD_LOGIC;
               propHi : in STD_LOGIC;
               genrHi : in STD_LOGIC;
               prop_o : out STD_LOGIC;
               genr_o : out STD_LOGIC);
    end component;
    
    component LFA8 is
        Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
               y : in STD_LOGIC_VECTOR (7 downto 0);
               s : out STD_LOGIC_VECTOR (7 downto 0);
               p, g : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal xL, xH, yL, yH, sL, sH : std_logic_vector(7 downto 0);
    signal gi, pi : std_logic_vector(15 downto 0);
    signal po, go : std_logic_vector(15 downto 8);
    
begin

xL <= x(7 downto 0);
yL <= y(7 downto 0);
xH <= x(15 downto 8);
yH <= y(15 downto 8);

LFA8_instL : LFA8 port map (xL, yL, sL, pi(7 downto 0), gi(7 downto 0));

LFA8_instH : LFA8 port map (xH, yH, sH, pi(15 downto 8), gi(15 downto 8));

carries_gen : for i in 8 to 15 generate
carry_op_instances : carry_operator port map(
    propLi => pi(7),
    genrLi => gi(7),
    propHi => pi(i),
    genrHi => gi(i),
    prop_o => po(i),
    genr_o => go(i));
end generate;

s <= (sH & sL) xor (go(14 downto 8) & gi(7 downto 0) & '0');

g <= go & gi(7 downto 0);
p <= po & pi(7 downto 0);

end Behavioral;
