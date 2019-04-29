library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock_div is
    port (
          clk : in std_logic;
          div : out std_logic               --This is the output in form of result
          );
end clock_div;

architecture clk_div of clock_div is
        signal count : std_logic_vector (25 downto 0) := (others => '0'); --use 26 bits to be able to count to 62.5MHZ. The (others=>'0') represents that the signal is initialized to "0"
     
        begin
              process(clk) begin --declare process  
                     if rising_edge(clk) then  --Every period on (rising edge) the logic goes through this loop
                            if(unsigned(count) < 62499999) then      --update counter while less than 62.5MHZ
                                    div <= '0';  --we will only get an output of "1" after we reach a certain number of counts 
                                    count <= std_logic_vector( unsigned(count) + 1 );    --Here, for every rising edge of the input-CLOCK, we increment the signal by 1

                            else --once you reach 62.5MHZ (more than 62499999  counts). This is where the SIGNAL reaches the "DIVISION-RATIO".
                                    count <= (others => '0');   --Here we reset the temporary "counter"
                                    div <= '1';                 --a "1" is given to the output value of "div". Remember we work with the output "div" not the counter.
                            end if;
                     end if;    --Here we end the original "if"
              end process;
end clk_div;
