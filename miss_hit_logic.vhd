library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity miss_hit_logic is
    port(tag : in STD_LOGIC_VECTOR(2 downto 0);
         w0 : in STD_LOGIC_VECTOR(3 downto 0);
         w1 : in STD_LOGIC_VECTOR(3 downto 0);
         w2 : in STD_LOGIC_VECTOR(3 downto 0);
         w3 : in STD_LOGIC_VECTOR(3 downto 0);
         hit : out STD_LOGIC;
         k : out STD_LOGIC_VECTOR(1 downto 0)
     );
end miss_hit_logic;

architecture gate_level of miss_hit_logic is

    signal equal_w0: STD_LOGIC_VECTOR(2 downto 0);
    signal equal_w1: STD_LOGIC_VECTOR(2 downto 0);
    signal equal_w2: STD_LOGIC_VECTOR(2 downto 0);
    signal equal_w3: STD_LOGIC_VECTOR(2 downto 0);
    signal is_w0: STD_LOGIC;
    signal is_w1: STD_LOGIC;
    signal is_w2: STD_LOGIC;
    signal is_w3: STD_LOGIC;
begin
    equal_w0 <= w0(2 downto 0) xnor tag;
    equal_w1 <= w1(2 downto 0) xnor tag;
    equal_w2 <= w2(2 downto 0) xnor tag;
    equal_w3 <= w3(2 downto 0) xnor tag;
    is_w0 <= equal_w0(2) and equal_w0(1) and equal_w0(0);
    is_w1 <= equal_w1(2) and equal_w1(1) and equal_w1(0);
    is_w2 <= equal_w2(2) and equal_w2(1) and equal_w2(0);
    is_w3 <= equal_w3(2) and equal_w3(1) and equal_w3(0);
    k(1) <= ((not (is_w0 and w0(3))) and (not (is_w1 and w1(3))) and ((is_w2 and w2(3)) xor (is_w3 and w3(3))));
    k(0) <= ((not (is_w0 and w0(3))) and (not (is_w2 and w2(3))) and ((is_w1 and w1(3)) xor (is_w3 and w3(3))));
    hit <= (is_w0 and w0(3)) or (is_w1 and w1(3)) or (is_w2 and w2(3)) or (is_w3 and w3(3));
end gate_level;

