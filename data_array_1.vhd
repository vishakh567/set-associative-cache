LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity data_array_1 is
    port(clk, wren:in STD_LOGIC;
         index:in STD_LOGIC_VECTOR(2 downto 0);
         wrdata:in STD_LOGIC_VECTOR(31 downto 0);
         data:out STD_LOGIC_VECTOR(31 downto 0));
end data_array_1;

architecture behavorial_data_array of data_array_1 is

    type data_array_data is array (0 to 7) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_array : data_array_data := ("01000000000000000000000000000011",
                                            "01000000000000000000000000000111",
                                            "01000000000000000000000000000100",
                                            "01000000000000000000000000001000",
                                            "01000000000000000000000000010000",
                                            "01000000000000000000000000100000",
                                            "01000000000000000000000001000000",
                                            "01000000001111110000000010000000"
                                            );
begin
    data <= data_array(to_integer(unsigned(index)));
    process(clk)
    begin
        if(wren = '1') then
            data_array(to_integer(unsigned(index))) <= wrdata;
        end if;

    end process;

end behavorial_data_array;
