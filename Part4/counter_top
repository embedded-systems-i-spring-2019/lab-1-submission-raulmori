--This is assuming that all the other design files for "clock.div", "debounce", and "fancy_counter" have been also uploaded to the Vivado software along with this "counter_top"


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_top is                               --Remember the Entity parts are the inputs and outputs on the outter part of the "black-box" model        
      Port (btn : in std_logic_vector(3 downto 0);          --These are the entity values belonging strictly to "counter_top"
            clk: in std_logic;
            sw: in std_logic_vector(3 downto 0);            --Notice this is a new value that we put in here because it appeared on Fig 1.8
            led: out std_logic_vector(3 downto 0));
end counter_top;


architecture my_ct of counter_top is

        signal U1_out, U2_out, U3_out, U4_out, U5_out: std_logic := '0';

                component debounce
                  Port (clk: in std_logic;
                        btn: in std_logic;
                        dbnc: out std_logic );
                end component;
        ------------------------------------------------------
        
                component clock_div
                port (
                  clk : in std_logic;
                  div : out std_logic);
                end component;
        ------------------------------------------------------
           
                component fancy_counter
                  Port (clk, clk_en, dir, en, ld, rst, updn: in std_logic;
                        val: in std_logic_vector(3 downto 0);
                         cnt: out std_logic_vector(3 downto 0));
                end component;

         ------------------------------------------------------

                begin       --Notice that each of these ports represent each bit of the main inputs of the main components
                     
                        U1: debounce port map          --This is for the 0th bit of the button
                                              (btn => btn(0),        --here we assign the entity "btn" of counter_top to temporary "btn"'s 0th bit of "component-debounce"
                                              clk => clk,
                                              dbnc => U1_out);
                                              
                        U2: debounce port map
                                              (btn => btn(1),        --here we assign the entity "btn" of counter_top to temporary "btn"'s 1th bit of "component-debounce"
                                              clk => clk,
                                              dbnc => U2_out);
                                              
                        U3: debounce port map
                                              (btn => btn(2),
                                              clk => clk,
                                              dbnc => U3_out);
                        
                        U4: debounce port map
                                              (btn => btn(3),
                                              clk => clk,
                                              dbnc => U4_out);
                                              
                        U5: clock_div port map              --This is for Clock.div only
                                              (clk => clk,
                                               div => U5_out);
                                               
                        U6: fancy_counter port map          --This is for fancy.counter only
                                             (clk => clk,
                                             clk_en => U5_out, --Notice this one has the temporary signal "U5_out"
                                             dir => sw(0),
                                             en => U2_out,
                                             ld => U4_out,
                                             rst => U1_out,
                                             updn => U3_out,
                                             val => sw,
                                             cnt => led);
                                                          
end my_ct;
