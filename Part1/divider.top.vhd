--This is the First initial part where we simulate all the parts of an example simple entire circuit together.
--Divider.top will help you understand how to do the last part where we actually bring all the components together.
--This dummy-circuit is composed of an "inverter", a "clock" (the one we made), and a "D-Flip-flop"
--the part of the "inverter" and the "D Flip-Flop" were made  

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity divider_top is
      Port (
            clk: in std_logic;
             led0: out std_logic);
end divider_top;


architecture Behavioral of divider_top is

    signal led: std_logic := '0';           --temporary "led" (which is the output of the register which gets fed back as an input)
    signal div_CE: std_logic := '0';        --This is just the "temporary" output of the clock


    component clock_div                  --Here we  call (INSTANTIATE) all of clock.div by calling its entity parts.
            port(
                clk: in std_logic;
                 div: out std_logic);
    end component;

        
    begin
         U1: clock_div port map          --We call create a PORT-MAP that works with the COMPONENT of the "CLOCK-ENABLE" which is the (ClOCK.DIV)
                 (clk => clk,             --We assign the entity "clk" (from clock.div)  into the temporary "clk" from divider.top
                  div => div_CE);             --We assign the entity "div" (from clock.div)  into the temporary "div_ce" from divider.top 
            

         process(clk)  --At every clock tick we will loop everything inside process
                  begin  --This is the D Flip-Flop. Here we use the Newly Added "CLOCK-ENABLE (CLOCK.DIV) to generate the LED-output Logic.      
                        if(clk'event and clk = '1') then   --If the temporary "clk" is "1" (This is just RISING-EDGE)  
                                if(div_CE = '1') then   -- If the temporary "div_CE" is "1" (this is the output of the clock)
                                         led <= not led; --This is the "INPUT" to the D-Flip-Flop which is the output of the DflipFlop Inverted.      
                                end if;
                        end if;
         led0 <= led;  --We then  reassign  the TEMPORARY "led" (Inverted) to the ENTITY-LED
         end process;
end Behavioral;
