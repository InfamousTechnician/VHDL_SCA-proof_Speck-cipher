library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LFA4 is
    Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
           y : in STD_LOGIC_VECTOR (3 downto 0);
           s : out STD_LOGIC_VECTOR (3 downto 0);
           p, g : out std_logic_vector(3 downto 0));
end LFA4;

architecture Behavioral of LFA4 is
    
    component carry_operator is
        Port ( propLi : in STD_LOGIC;
               genrLi : in STD_LOGIC;
               propHi : in STD_LOGIC;
               genrHi : in STD_LOGIC;
               prop_o : out STD_LOGIC;
               genr_o : out STD_LOGIC);
    end component;
    
    component LFA2 is
        Port ( x : in STD_LOGIC_VECTOR (1 downto 0);
               y : in STD_LOGIC_VECTOR (1 downto 0);
               s : out STD_LOGIC_VECTOR (1 downto 0);
               p, g : out STD_LOGIC);
    end component;
    
    signal xL, xH, yL, yH, sL, sH : std_logic_vector(1 downto 0);
    signal ci, si : std_logic_vector(3 downto 0);
    signal pL, gL, pH, gH, p2, g2, pi, gi, g0, g1, pmax, gmax, p0 : std_logic;

begin

xL <= x(1 downto 0);
yL <= y(1 downto 0);
xH <= x(3 downto 2);
yH <= y(3 downto 2);

LFA2_instL : LFA2 port map (xL, yL, sL, pL, gL);

LFA2_instH : LFA2 port map (xH, yH, sH, pH, gH);

g0 <= x(0) and y(0);
p0 <= x(0) xor y(0);
g1 <= x(1) and y(1);
p2 <= x(2) xor y(2);
g2 <= x(2) and y(2);

carry_op_inst2 : carry_operator port map(
    propLi => pL,
    genrLi => gL,
    propHi => p2,
    genrHi => g2,
    prop_o => pi,
    genr_o => gi);

carry_op_inst3 : carry_operator port map(
    propLi => pL,
    genrLi => gL,
    propHi => pH,
    genrHi => gH,
    prop_o => pmax,
    genr_o => gmax);

si <= sH & sL;
--ci <= gi & gL & g0 & '0';

s <= si;-- xor ci;
p <= pmax & pi & pL & p0;
g <= gmax & gi & gL & g0;

end Behavioral;
