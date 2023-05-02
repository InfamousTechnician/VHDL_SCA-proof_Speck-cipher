library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity speck128x128cipherPipe is
    Port ( plain1 : in STD_LOGIC_VECTOR (127 downto 0) := x"6c617669757165207469206564616d20";
           key1 : in STD_LOGIC_VECTOR (127 downto 0) := x"0f0e0d0c0b0a09081234567890000000";
           cipher1 : inout STD_LOGIC_VECTOR (127 downto 0);
           plain2 : in STD_LOGIC_VECTOR (127 downto 0) := x"abcdef00000000000000000000000000";
           key2 : in STD_LOGIC_VECTOR (127 downto 0) := x"12345678900000000706050403020100";
           cipher2 : inout STD_LOGIC_VECTOR (127 downto 0);
           plain3 : in STD_LOGIC_VECTOR (127 downto 0) := x"abcdef00000000000000000000000000";
           key3 : in STD_LOGIC_VECTOR (127 downto 0) := x"12345678900000001234567890000000";
           cipher3 : inout STD_LOGIC_VECTOR (127 downto 0);
           test : out std_logic);

end speck128x128cipherPipe;

architecture Behavioral of speck128x128cipherPipe is

component speck_stage is
    Generic(w : integer);
    Port ( dir : in STD_LOGIC := '0';
           xi1 : in STD_LOGIC_VECTOR (w-1 downto 0);
           xi2 : in STD_LOGIC_VECTOR (w-1 downto 0);
           xi3 : in STD_LOGIC_VECTOR (w-1 downto 0);
           yi1 : in STD_LOGIC_VECTOR (w-1 downto 0);
           yi2 : in STD_LOGIC_VECTOR (w-1 downto 0);
           yi3 : in STD_LOGIC_VECTOR (w-1 downto 0);
           xo1 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           xo2 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           xo3 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           yo1 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           yo2 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           yo3 : inout STD_LOGIC_VECTOR (w-1 downto 0);
           rsk1 : in STD_LOGIC_VECTOR (w-1 downto 0);
           rsk2 : in STD_LOGIC_VECTOR (w-1 downto 0);
           rsk3 : in STD_LOGIC_VECTOR (w-1 downto 0));
end component;

type key_pipeT is array (0 to 31) of std_logic_vector(63 downto 0);
signal keyHpipe1, keyHpipe2, keyHpipe3, keyLpipe1, keyLpipe2, keyLpipe3 : key_pipeT;
type txt_pipeT is array (0 to 32) of std_logic_vector(63 downto 0);
signal txtHpipe1, txtHpipe2, txtHpipe3, txtLpipe1, txtLpipe2, txtLpipe3 : txt_pipeT;

begin

    keyHpipe1(0) <= key1(127 downto 64);
    keyHpipe2(0) <= key2(127 downto 64);
    keyHpipe3(0) <= key3(127 downto 64);
    keyLpipe1(0) <= key1(63  downto  0);
    keyLpipe2(0) <= key2(63  downto  0);
    keyLpipe3(0) <= key3(63  downto  0);
    
    key_pipe_generate: for i in 0 to 30 generate
    
        key_pipe_elements: speck_stage
            generic map (64)
            port map 
            ('0',
            keyHpipe1(i),
            keyHpipe2(i),
            keyHpipe3(i),
            keyLpipe1(i),
            keyLpipe2(i),
            keyLpipe3(i),
            keyHpipe1(i+1),
            keyHpipe2(i+1),
            keyHpipe3(i+1),
            keyLpipe1(i+1),
            keyLpipe2(i+1),
            keyLpipe3(i+1),
            std_logic_vector(to_unsigned(i,64)),
            std_logic_vector(to_unsigned(i,64)),
            std_logic_vector(to_unsigned(i,64)));
            
    end generate;
    
    txtHpipe1(0) <= plain1(127 downto 64);
    txtHpipe2(0) <= plain2(127 downto 64);
    txtHpipe3(0) <= plain3(127 downto 64);
    txtLpipe1(0) <= plain1(63  downto  0);
    txtLpipe2(0) <= plain2(63  downto  0);
    txtLpipe3(0) <= plain3(63  downto  0);
    
    txt_pipe_generate: for i in 0 to 31 generate
    
        txt_pipe_elements: speck_stage
            generic map (64)
            port map 
            ('0',
            txtHpipe1(i),
            txtHpipe2(i),
            txtHpipe3(i),
            txtLpipe1(i),
            txtLpipe2(i),
            txtLpipe3(i),
            txtHpipe1(i+1),
            txtHpipe2(i+1),
            txtHpipe3(i+1),
            txtLpipe1(i+1),
            txtLpipe2(i+1),
            txtLpipe3(i+1),
            keyLpipe1(i),
            keyLpipe2(i),
            keyLpipe3(i));
    
    end generate;
    
    cipher1 <= txtHpipe1(32) & txtLpipe1(32);
    cipher2 <= txtHpipe2(32) & txtLpipe2(32);
    cipher3 <= txtHpipe3(32) & txtLpipe3(32);
    
    --TESTING
    test <= 'H' when (cipher1 xor cipher2 xor cipher3) = x"a65d9851797832657860fedf5c570d18" else 'L';
        
end Behavioral;
