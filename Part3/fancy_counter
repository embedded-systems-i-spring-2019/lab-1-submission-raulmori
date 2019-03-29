library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;a

entity fancy_counter is
      Port (clk, clk_en, dir, en, ld, rst, updn: in std_logic;  --These are all the 1 bit inputs of the multiplexer
            val: in std_logic_vector(3 downto 0);               --This is the special input of the multiplexer that has a 4-bit input
            cnt: out std_logic_vector(3 downto 0));             --This is the special out of the multiplexer that has a 4-bit out
end fancy_counter;


architecture Behavioral of fancy_counter is

        --We use a 4-bit counter, because we have a 4-bit button
        signal counter: std_logic_vector(3 downto 0) := (others => '0');    --This is the interchangeable value of the counter
        signal value: std_logic_vector(3 downto 0) := (others => '0');      --interchangeable  "value"
        signal direction : std_logic := '0';                                --interchangeable  "direction"

            begin
                process(clk, clk_en)      --Notice here  we have a clock, and a clock_enable
                    begin
     
                        if(en = '1') then --Remember changes only happen when "en=1", when clock_en is "0" nothing happens
                                if(rising_edge(clk)) then          --Remember, After the above condition is met, anything will only happen on "rising_edge".  
                                        if (rst = '1') then              --If rst is asserted while every condition above is met, the counter resets.
                                                counter <= (others => '0');     --This resets the counter, which will automatically make its 4-bit value be "0000"
                                                cnt <= counter;                 --This puts the 4-bit temporary "counter" into entitiy port "cnt"    
                                        elsif (clk_en = '1') then  --This is assuming the reset is "0" but an additional condition of "Clk_en=1" also has to be true.
                        --All the if's in this column will be executed. 
                
                                            if(updn = '1') then         --this JUST activates change in count direction
                                                     direction <= dir;           --this puts entitiy port "dir" (which can be 0 or 1)into the temporary 4-bit "direction", so that we can use temporary "direction" later
                                            end if;
                
                                            if(ld = '1')   then      --if LD is "1"  the value at "val" will be LOADED in to value register
                                                     value <= val;       --Here we actually put the entity port "val" into the temporary 4-bit "value" so that we can move "val" later
                                            end if; 
                                            
                                            if(direction = '1') then         --In this case we actually use the temporary "direction" valu      
                                                      if(unsigned(counter) < unsigned(value)) then    --Check if "counter" is less than temporary "value" 
                                                                       counter <= std_logic_vector(unsigned(counter) + 1);    --adds 1 to the counter than saves it in the temporary "counter"
                                                                       cnt <= counter;               --puts the temporary "counter" into the entity port "cnt". So that it can be printed out
                                                                        
                                                      else                               --This is the case that the temporary "counter" is is more than the temporary "value" applied to the multiplexer 
                                                                       counter <= (others => '0');    --This is will reset the temporary "counter" giving it a value of "0000"
                                                                       cnt <= counter;                --puts the temporary "counter" into the entity port "cnt". So that it can be printed out
                                                      end if;              --This ends the internal if/else condition
                                                   
                                                
                                             else          --if direction is '0'(as long as updn is "1"). COUNT DOWN from current value in counter
                                                       if(unsigned(counter) > "0000") then              --This is if the temporary counter is greater than "0"
                                                            counter <= std_logic_vector(unsigned(counter) - 1);   --This is where the counter starts counting down
                                                            cnt <= counter;    --puts the value of the counter on the output
                                                     
                                                       else  --If the "counter" is actually 0000 , "val" is sent to "counter"   
                                                             counter <= value;
                                                             cnt <= counter;   --The temporary "counter" is put on the entity port "cnt", so it can be printed out   
                                                       end if;              --Remember the loop goes back at every clock edge (count)                      
                                            end if;
                                            
                                            
                                             
                                        end if;  --This closes the  "elsif" condition
                                        
                               end if;  --This closes the second "if" condition
                               
                      end if;  --This closes the first "if" condition
                             
               end process;

end Behavioral;
