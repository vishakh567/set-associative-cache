library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lru_array is
    port(index : in STD_LOGIC_VECTOR(2 downto 0);
         k : in STD_LOGIC_VECTOR(1 downto 0);
         clk : in STD_LOGIC;
         enable : in STD_LOGIC;
         reset : in STD_LOGIC;
         LRUblk : out STD_LOGIC_VECTOR(1 downto 0)
     );
end entity;

architecture behavorial of lru_array is
    type data_array is array (0 to 7) of integer;
    signal w0s : data_array := (others => 0);
    signal w1s : data_array := (others => 1);
    signal w2s : data_array := (others => 2);
    signal w3s : data_array := (others => 3);
    signal last_index : STD_LOGIC_VECTOR(2 downto 0);
    signal last_k : STD_LOGIC_VECTOR(1 downto 0);
begin
    process (clk)
    begin
        if(reset = '1') then
            if(k = "00") then
                w0s(to_integer(unsigned(index))) <= 0;
                w1s(to_integer(unsigned(index))) <= 1;
                w2s(to_integer(unsigned(index))) <= 2;
                w3s(to_integer(unsigned(index))) <= 3;
            elsif(k = "01") then
                w0s(to_integer(unsigned(index))) <= 1;
                w1s(to_integer(unsigned(index))) <= 0;
                w2s(to_integer(unsigned(index))) <= 2;
                w3s(to_integer(unsigned(index))) <= 3;
            elsif(k = "10") then
                w0s(to_integer(unsigned(index))) <= 1;
                w1s(to_integer(unsigned(index))) <= 2;
                w2s(to_integer(unsigned(index))) <= 0;
                w3s(to_integer(unsigned(index))) <= 3;
            elsif(k = "11") then
                w0s(to_integer(unsigned(index))) <= 1;
                w1s(to_integer(unsigned(index))) <= 2;
                w2s(to_integer(unsigned(index))) <= 3;
                w3s(to_integer(unsigned(index))) <= 0;
            end if;
            last_index <= "XXX";
            last_k <= "XX";
        elsif(enable = '1') then
            if(k = "00" and (last_index /= index or k /= last_k)) then 
                if(w0s(to_integer(unsigned(index)))=0) then
                    w0s(to_integer(unsigned(index))) <= 3;
                    w1s(to_integer(unsigned(index))) <= w1s(to_integer(unsigned(index))) - 1;
                    w2s(to_integer(unsigned(index))) <= w2s(to_integer(unsigned(index))) - 1;
                    w3s(to_integer(unsigned(index))) <= w3s(to_integer(unsigned(index))) - 1;
                
                elsif(w0s(to_integer(unsigned(index)))=1) then
                    w0s(to_integer(unsigned(index))) <= 3;
                    if (w1s(to_integer(unsigned(index))) /= 0) then
                        w1s(to_integer(unsigned(index))) <= w1s(to_integer(unsigned(index))) - 1;
                    end if;
                    if (w2s(to_integer(unsigned(index))) /= 0) then
                        w2s(to_integer(unsigned(index))) <= w2s(to_integer(unsigned(index))) - 1;
                    end if;                        
                    if (w3s(to_integer(unsigned(index))) /= 0) then
                        w3s(to_integer(unsigned(index))) <= w3s(to_integer(unsigned(index))) - 1;
                    end if;
                    
                elsif(w0s(to_integer(unsigned(index)))=2) then
                        w0s(to_integer(unsigned(index))) <= 3;
                        if (w1s(to_integer(unsigned(index))) = 3) then
                            w1s(to_integer(unsigned(index))) <= w1s(to_integer(unsigned(index))) - 1;
                        end if;
                        if (w2s(to_integer(unsigned(index))) = 3) then
                            w2s(to_integer(unsigned(index))) <= w2s(to_integer(unsigned(index))) - 1;
                        end if;                        
                        if (w3s(to_integer(unsigned(index))) = 3) then
                            w3s(to_integer(unsigned(index))) <= w3s(to_integer(unsigned(index))) - 1;
                        end if;
                end if;
            end if;   
            if(k = "01" and (last_index /= index or k /= last_k)) then 
                  if(w1s(to_integer(unsigned(index)))=0) then
                      w1s(to_integer(unsigned(index))) <= 3;
                      w0s(to_integer(unsigned(index))) <= w0s(to_integer(unsigned(index))) - 1;
                      w2s(to_integer(unsigned(index))) <= w2s(to_integer(unsigned(index))) - 1;
                      w3s(to_integer(unsigned(index))) <= w3s(to_integer(unsigned(index))) - 1;
                  
                  elsif(w1s(to_integer(unsigned(index)))=1) then
                      w1s(to_integer(unsigned(index))) <= 3;
                      if (w0s(to_integer(unsigned(index))) /= 0) then
                          w0s(to_integer(unsigned(index))) <= w0s(to_integer(unsigned(index))) - 1;
                      end if;
                      if (w2s(to_integer(unsigned(index))) /= 0) then
                          w2s(to_integer(unsigned(index))) <= w2s(to_integer(unsigned(index))) - 1;
                      end if;                        
                      if (w3s(to_integer(unsigned(index))) /= 0) then
                          w3s(to_integer(unsigned(index))) <= w3s(to_integer(unsigned(index))) - 1;
                      end if;
                      
                  elsif(w1s(to_integer(unsigned(index)))=2) then
                          w1s(to_integer(unsigned(index))) <= 3;
                          if (w0s(to_integer(unsigned(index))) = 3) then
                              w0s(to_integer(unsigned(index))) <= w0s(to_integer(unsigned(index))) - 1;
                          end if;
                          if (w2s(to_integer(unsigned(index))) = 3) then
                              w2s(to_integer(unsigned(index))) <= w2s(to_integer(unsigned(index))) - 1;
                          end if;                        
                          if (w3s(to_integer(unsigned(index))) = 3) then
                              w3s(to_integer(unsigned(index))) <= w3s(to_integer(unsigned(index))) - 1;
                          end if;
                  end if;
            end if;     
            if(k = "10" and (last_index /= index or k /= last_k)) then 
                      if(w2s(to_integer(unsigned(index)))=0) then
                          w2s(to_integer(unsigned(index))) <= 3;
                          w0s(to_integer(unsigned(index))) <= w0s(to_integer(unsigned(index))) - 1;
                          w1s(to_integer(unsigned(index))) <= w1s(to_integer(unsigned(index))) - 1;
                          w3s(to_integer(unsigned(index))) <= w3s(to_integer(unsigned(index))) - 1;
                      
                      elsif(w2s(to_integer(unsigned(index)))=1) then
                          w2s(to_integer(unsigned(index))) <= 3;
                          if (w0s(to_integer(unsigned(index))) /= 0) then
                              w0s(to_integer(unsigned(index))) <= w0s(to_integer(unsigned(index))) - 1;
                          end if;
                          if (w1s(to_integer(unsigned(index))) /= 0) then
                              w1s(to_integer(unsigned(index))) <= w1s(to_integer(unsigned(index))) - 1;
                          end if;                        
                          if (w3s(to_integer(unsigned(index))) /= 0) then
                              w3s(to_integer(unsigned(index))) <= w3s(to_integer(unsigned(index))) - 1;
                          end if;
                          
                      elsif(w2s(to_integer(unsigned(index)))=2) then
                              w2s(to_integer(unsigned(index))) <= 3;
                              if (w0s(to_integer(unsigned(index))) = 3) then
                                  w0s(to_integer(unsigned(index))) <= w0s(to_integer(unsigned(index))) - 1;
                              end if;
                              if (w1s(to_integer(unsigned(index))) = 3) then
                                  w1s(to_integer(unsigned(index))) <= w1s(to_integer(unsigned(index))) - 1;
                              end if;                        
                              if (w3s(to_integer(unsigned(index))) = 3) then
                                  w3s(to_integer(unsigned(index))) <= w3s(to_integer(unsigned(index))) - 1;
                              end if;
                       end if;
             end if;                
            if(k = "11" and (last_index /= index or k /= last_k)) then 
                      if(w3s(to_integer(unsigned(index)))=0) then
                          w3s(to_integer(unsigned(index))) <= 3;
                          w0s(to_integer(unsigned(index))) <= w0s(to_integer(unsigned(index))) - 1;
                          w1s(to_integer(unsigned(index))) <= w1s(to_integer(unsigned(index))) - 1;
                          w2s(to_integer(unsigned(index))) <= w2s(to_integer(unsigned(index))) - 1;
                      
                      elsif(w3s(to_integer(unsigned(index)))=1) then
                          w3s(to_integer(unsigned(index))) <= 3;
                          if (w0s(to_integer(unsigned(index))) /= 0) then
                              w0s(to_integer(unsigned(index))) <= w0s(to_integer(unsigned(index))) - 1;
                          end if;
                          if (w1s(to_integer(unsigned(index))) /= 0) then
                              w1s(to_integer(unsigned(index))) <= w1s(to_integer(unsigned(index))) - 1;
                          end if;                        
                          if (w2s(to_integer(unsigned(index))) /= 0) then
                              w2s(to_integer(unsigned(index))) <= w2s(to_integer(unsigned(index))) - 1;
                          end if;
                          
                      elsif(w3s(to_integer(unsigned(index)))=2) then
                              w3s(to_integer(unsigned(index))) <= 3;
                              if (w0s(to_integer(unsigned(index))) = 3) then
                                  w0s(to_integer(unsigned(index))) <= w0s(to_integer(unsigned(index))) - 1;
                              end if;
                              if (w1s(to_integer(unsigned(index))) = 3) then
                                  w1s(to_integer(unsigned(index))) <= w1s(to_integer(unsigned(index))) - 1;
                              end if;                        
                              if (w2s(to_integer(unsigned(index))) = 3) then
                                  w2s(to_integer(unsigned(index))) <= w2s(to_integer(unsigned(index))) - 1;
                              end if;
                       end if;
            end if;               
            last_index <= index;
            last_k <= k;
        end if;        
        
        if(w0s(to_integer(unsigned(index))) = 0) then
          LRUblk <= "00";
        elsif(w1s(to_integer(unsigned(index))) = 0) then
          LRUblk <= "01";         
        elsif(w2s(to_integer(unsigned(index))) = 0) then
          LRUblk <= "10";                
        elsif(w3s(to_integer(unsigned(index))) = 0) then
          LRUblk <= "11";                
        end if;        
 end process;
end behavorial;
