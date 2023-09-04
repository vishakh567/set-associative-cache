library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux is
    port(sel:in STD_LOGIC_VECTOR(1 downto 0);
         enable: in STD_LOGIC;
         w0:in STD_LOGIC_VECTOR(31 downto 0);
         w1:in STD_LOGIC_VECTOR(31 downto 0);
         w2:in STD_LOGIC_VECTOR(31 downto 0);
         w3:in STD_LOGIC_VECTOR(31 downto 0);
         output: out STD_LOGIC_VECTOR(31 downto 0)
     );
end mux;

architecture behavioral of mux is
begin
 process(enable,sel)
  begin
   if (enable ='1') then
      if (sel="00") then
        output <= w0;
      elsif (sel="01") then
        output <= w1;
      elsif (sel="10") then
        output <= w2;
      elsif (sel="11") then
        output <= w3;
      end if;
   else
     output <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
   end if;
 end process;    
end behavioral;
