library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library UNISIM;
use UNISIM.VComponents.all;

entity tag_valid_array_0 is
    port(clk,wren,reset_n,invalidate,validate:in STD_LOGIC;
         index:in STD_LOGIC_VECTOR(2 downto 0);
         wrdata:in STD_LOGIC_VECTOR(2 downto 0);
         output:out STD_LOGIC_VECTOR(3 downto 0)
     );
end tag_valid_array_0;

architecture behavorial of tag_valid_array_0 is
    type data_array_data is array (0 to 7) of STD_LOGIC_VECTOR(3 downto 0);
    signal data_array : data_array_data := ("1011",
                                            "1111",
                                            "1100",
                                            "1000",
                                            "1000",
                                            "1100",
                                            "1000",
                                            "0010"
                                            );
begin
    output <= data_array(to_integer(unsigned(index)));
    process(clk)
    begin
        if(wren = '1') then
            data_array(to_integer(unsigned(index)))(2 downto 0) <= wrdata;
        end if;

        if(reset_n = '1') then
            data_array <= ("0000",
                           "0000",
                           "0000",
                           "0000",
                           "0000",
                           "0000",
                           "0000",
                           "0000"
                           );
        end if;

        if(validate = '1' and wren = '1') then
            data_array(to_integer(unsigned(index)))(3) <= '1';
        end if;

        if(invalidate ='1') then
            data_array(to_integer(unsigned(index)))(3) <= '0';
        end if;

    end process;
end behavorial;
