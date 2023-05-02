library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity speck_stage is
    Generic(w : integer := 64);
    Port ( dir : in STD_LOGIC := '0';
           xi1 : in STD_LOGIC_VECTOR (w-1 downto 0) := x"7d33b2de7ad431f8"; --round 10 Pt high
           xi2 : in STD_LOGIC_VECTOR (w-1 downto 0) := x"0000000000000000";
           xi3 : in STD_LOGIC_VECTOR (w-1 downto 0) := x"0000000000000000";
           yi1 : in STD_LOGIC_VECTOR (w-1 downto 0) := x"0000000000000000";
           yi2 : in STD_LOGIC_VECTOR (w-1 downto 0) := x"582299d79a7c84ce"; --round 10 Pt low
           yi3 : in STD_LOGIC_VECTOR (w-1 downto 0) := x"0000000000000000";
           xo1 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           xo2 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           xo3 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           yo1 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           yo2 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           yo3 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           rsk1 : in STD_LOGIC_VECTOR (w-1 downto 0) := x"0000000000000000";
           rsk2 : in STD_LOGIC_VECTOR (w-1 downto 0) := x"0000000000000000";
           rsk3 : in STD_LOGIC_VECTOR (w-1 downto 0) := x"b243d7c9869cac18"; --round 10 subkey
           test_x, test_y : out STD_LOGIC);
end speck_stage;

architecture Behavioral of speck_stage is

    component masked_add is
        Generic(w : integer);
        Port ( dir : in STD_LOGIC;
               a1i : in STD_LOGIC_VECTOR (w-1 downto 0);
               a2i : in STD_LOGIC_VECTOR (w-1 downto 0);
               a3i : in STD_LOGIC_VECTOR (w-1 downto 0);
               b1i : in STD_LOGIC_VECTOR (w-1 downto 0);
               b2i : in STD_LOGIC_VECTOR (w-1 downto 0);
               b3i : in STD_LOGIC_VECTOR (w-1 downto 0);
               s1o : out STD_LOGIC_VECTOR (w downto 0);
               s2o : out STD_LOGIC_VECTOR (w downto 0);
               s3o : out STD_LOGIC_VECTOR (w downto 0));
    end component;
    
    component ROTL_3 is
        Generic(w : integer);
        Port ( yi : in STD_LOGIC_VECTOR (w-1 downto 0);
               yo : out STD_LOGIC_VECTOR (w-1 downto 0));
    end component;
    
    component ROTR_8 is
        Generic(w : integer);
        Port ( xi : in STD_LOGIC_VECTOR (w-1 downto 0);
               xo : out STD_LOGIC_VECTOR (w-1 downto 0));
    end component;
    
    signal rotr1, rotr2, rotr3 : STD_LOGIC_VECTOR (w-1 downto 0);
    signal rotl1, rotl2, rotl3 : STD_LOGIC_VECTOR (w-1 downto 0);
    signal xori1, xori2, xori3 : STD_LOGIC_VECTOR (w downto 0);
    
begin

    inst_rotr1 : ROTR_8 generic map (w) port map(xi1, rotr1);
    inst_rotr2 : ROTR_8 generic map (w) port map(xi2, rotr2);
    inst_rotr3 : ROTR_8 generic map (w) port map(xi3, rotr3);
    
    inst_add : masked_add generic map(w) port map(dir, rotr1, rotr2, rotr3, yi1, yi2, yi3, xori1, xori2, xori3);
    
    inst_rotl1 : ROTL_3 generic map (w) port map(yi1, rotl1);
    inst_rotl2 : ROTL_3 generic map (w) port map(yi2, rotl2);
    inst_rotl3 : ROTL_3 generic map (w) port map(yi3, rotl3);
    
    xo1 <= xori1(w-1 downto 0) xor rsk1;
    xo2 <= xori2(w-1 downto 0) xor rsk2;
    xo3 <= xori3(w-1 downto 0) xor rsk3;
    
    yo1 <= xo1 xor rotl1;
    yo2 <= xo2 xor rotl2;
    yo3 <= xo3 xor rotl3;
    
    -- TESTING
    test_x <= 'H' when (xo1 xor xo2 xor xo3) = x"e2dc1a43fe6bf4e7" else 'L';
    test_y <= 'H' when (yo1 xor yo2 xor yo3) = x"23c8d4ff2d8fd295" else 'L';
    
end Behavioral;
