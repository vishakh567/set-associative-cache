library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache is
    port(clk, reset_n :in STD_LOGIC;
         full_address :in STD_LOGIC_VECTOR(7 downto 0);
         wrdata :in STD_LOGIC_VECTOR(31 downto 0);
         validate : in STD_LOGIC;
         invalidate :in STD_LOGIC;
         data: out STD_LOGIC_VECTOR(31 downto 0);
         byte: out STD_LOGIC_VECTOR(7 downto 0);
         hit: out STD_LOGIC;
         LRUblk: out STD_LOGIC_VECTOR(1 downto 0)
     );
end cache;

architecture gate_level of cache is
    component data_array_0 is
        port(clk, wren:in STD_LOGIC;
             index:in STD_LOGIC_VECTOR(2 downto 0);
             wrdata:in STD_LOGIC_VECTOR(31 downto 0);
             data:out STD_LOGIC_VECTOR(31 downto 0)
         );
    end component;

    component data_array_1 is
        port(clk, wren:in STD_LOGIC;
             index:in STD_LOGIC_VECTOR(2 downto 0);
             wrdata:in STD_LOGIC_VECTOR(31 downto 0);
             data:out STD_LOGIC_VECTOR(31 downto 0)
         );
    end component;
    
    component data_array_2 is
        port(clk, wren:in STD_LOGIC;
             index:in STD_LOGIC_VECTOR(2 downto 0);
             wrdata:in STD_LOGIC_VECTOR(31 downto 0);
             data:out STD_LOGIC_VECTOR(31 downto 0)
         );
    end component;
    
    component data_array_3 is
        port(clk, wren:in STD_LOGIC;
             index:in STD_LOGIC_VECTOR(2 downto 0);
             wrdata:in STD_LOGIC_VECTOR(31 downto 0);
             data:out STD_LOGIC_VECTOR(31 downto 0)
         );
    end component;

    component tag_valid_array_0 is
        port(clk,wren,reset_n,validate,invalidate:in STD_LOGIC;
             index:in STD_LOGIC_VECTOR(2 downto 0);
             wrdata:in STD_LOGIC_VECTOR(2 downto 0);
             output:out STD_LOGIC_VECTOR(3 downto 0)
         );
    end component;

    component tag_valid_array_1 is
        port(clk,wren,reset_n,validate,invalidate:in STD_LOGIC;
             index:in STD_LOGIC_VECTOR(2 downto 0);
             wrdata:in STD_LOGIC_VECTOR(2 downto 0);
             output:out STD_LOGIC_VECTOR(3 downto 0)
         );
    end component;

    component tag_valid_array_2 is
        port(clk,wren,reset_n,validate,invalidate:in STD_LOGIC;
             index:in STD_LOGIC_VECTOR(2 downto 0);
             wrdata:in STD_LOGIC_VECTOR(2 downto 0);
             output:out STD_LOGIC_VECTOR(3 downto 0)
         );
    end component;

    component tag_valid_array_3 is
        port(clk,wren,reset_n,validate,invalidate:in STD_LOGIC;
             index:in STD_LOGIC_VECTOR(2 downto 0);
             wrdata:in STD_LOGIC_VECTOR(2 downto 0);
             output:out STD_LOGIC_VECTOR(3 downto 0)
         );
    end component;

    component lru_array is
        port(index : in STD_LOGIC_VECTOR(2 downto 0);
             k : in STD_LOGIC_VECTOR(1 downto 0);
             clk : in STD_LOGIC;
             enable : in STD_LOGIC;
             reset : in STD_LOGIC;
             LRUblk : out STD_LOGIC_VECTOR(1 downto 0)
         );
    end component;

    component miss_hit_logic is
        port(tag : in STD_LOGIC_VECTOR(2 downto 0);
		      w0 : in STD_LOGIC_VECTOR(3 downto 0);
              w1 : in STD_LOGIC_VECTOR(3 downto 0);
              w2 : in STD_LOGIC_VECTOR(3 downto 0);
              w3 : in STD_LOGIC_VECTOR(3 downto 0);
              hit : out STD_LOGIC;
         	  k : out STD_LOGIC_VECTOR(1 downto 0)
         );
    end component;

    component mux is
        port(sel:in STD_LOGIC_VECTOR(1 downto 0);
             enable : in STD_LOGIC;
	          w0:in STD_LOGIC_VECTOR(31 downto 0);
              w1:in STD_LOGIC_VECTOR(31 downto 0);
              w2:in STD_LOGIC_VECTOR(31 downto 0);
              w3:in STD_LOGIC_VECTOR(31 downto 0);
              output: out STD_LOGIC_VECTOR(31 downto 0)
         );
    end component;
    
    component Byte_Mux is
        port ( Data : in STD_LOGIC_VECTOR (31 downto 0);
               Byte : out STD_LOGIC_VECTOR (7 downto 0);
               Sel : in STD_LOGIC_VECTOR (1 downto 0)
              );
    end component;
    
    type data_array_data is array (7 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
    signal k0_data : STD_LOGIC_VECTOR(31 downto 0);
    signal k1_data : STD_LOGIC_VECTOR(31 downto 0);
    signal k2_data : STD_LOGIC_VECTOR(31 downto 0);
    signal k3_data : STD_LOGIC_VECTOR(31 downto 0);
    signal k0_tag_valid_out : STD_LOGIC_VECTOR(3 downto 0);
    signal k1_tag_valid_out : STD_LOGIC_VECTOR(3 downto 0);
    signal k2_tag_valid_out : STD_LOGIC_VECTOR(3 downto 0);
    signal k3_tag_valid_out : STD_LOGIC_VECTOR(3 downto 0);
    signal k0_wren : STD_LOGIC := '0';
    signal k1_wren : STD_LOGIC := '0';
    signal k2_wren : STD_LOGIC := '0';
    signal k3_wren : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '1';
    signal k : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal hit_readable : STD_LOGIC;
    signal LRU_K : STD_LOGIC_VECTOR(1 downto 0);
    signal out_data : STD_LOGIC_VECTOR(31 downto 0);
begin
    --Data array instantiation--
    k0_data_array: data_array_0 port map(clk => clk , wren => k0_wren, index => full_address(4 downto 2), wrdata => wrdata, data => k0_data);
    k1_data_array: data_array_1 port map(clk => clk , wren => k1_wren, index => full_address(4 downto 2), wrdata => wrdata, data => k1_data);
    k2_data_array: data_array_2 port map(clk => clk , wren => k2_wren, index => full_address(4 downto 2), wrdata => wrdata, data => k2_data);
    k3_data_array: data_array_3 port map(clk => clk , wren => k3_wren, index => full_address(4 downto 2), wrdata => wrdata, data => k3_data);

    --Tag valid instantiation--
    k0_tag_valid: tag_valid_array_0 port map(clk => clk, wren => k0_wren, reset_n => reset_n,validate => validate,invalidate => invalidate, index => full_address(4 downto 2), wrdata => full_address(7 downto 5),output => k0_tag_valid_out);

    k1_tag_valid: tag_valid_array_1 port map(clk => clk, wren => k1_wren, reset_n => reset_n,validate => validate,invalidate => invalidate, index => full_address(4 downto 2), wrdata => full_address(7 downto 5),output => k1_tag_valid_out);

    k2_tag_valid: tag_valid_array_2 port map(clk => clk, wren => k2_wren, reset_n => reset_n,validate => validate,invalidate => invalidate, index => full_address(4 downto 2), wrdata => full_address(7 downto 5),output => k2_tag_valid_out);

    k3_tag_valid: tag_valid_array_3 port map(clk => clk, wren => k3_wren, reset_n => reset_n,validate => validate,invalidate => invalidate, index => full_address(4 downto 2), wrdata => full_address(7 downto 5),output => k3_tag_valid_out);

    --Miss hit instantiation--
    miss_hit: miss_hit_logic port map(tag => full_address(7 downto 5),w0 => k0_tag_valid_out ,w1 => k1_tag_valid_out, w2 => k2_tag_valid_out, w3 => k3_tag_valid_out, hit => hit_readable, k => k);

    --Lru array instantiation--
    lru_logic: lru_array port map(index => full_address(4 downto 2),k => k, clk => clk,reset => invalidate, LRUblk => LRU_K, enable => enable);

    mux_4 : mux port map(sel => k, enable => hit_readable, w0 => k0_data, w1 => k1_data, w2 => k2_data, w3 => k3_data, output => out_data);

    Byte_Selector : Byte_Mux port map(Sel => full_address(1 downto 0), Data => out_data , Byte => byte);
    
    hit <= hit_readable;
    data <= out_data;
    LRUblk <= LRU_K;
end gate_level;