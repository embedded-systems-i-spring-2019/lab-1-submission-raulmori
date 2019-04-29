--This is simply a copy of the "counter" with more input values
--Notice that here we use structural model, where as in the non-testbench files we used behavioral model
--Remember the clock.div always has to be manually simulated because it is the heart of the circuit model being testbenched.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fc_tb is
        --  Port ( );
end fc_tb;

architecture Behavioral of fc_tb is  
             signal clk, clk_en, en, dir, ld, rst, updn : std_logic := '0';
             signal val: std_logic_vector(3 downto 0) := (others => '0');
             signal cnt: std_logic_vector(3 downto 0) := (others => '0');  --Notice all the temporary signals are set to "0". In this case we use the "others" command because we have more than 1-bit
             
            
                 component fancy_counter    --This calls the values from the original "counter design"
                           Port (clk, clk_en, dir, en, ld, rst, updn: in std_logic;
                                 val: in std_logic_vector(3 downto 0);
                                 cnt: out std_logic_vector(3 downto 0));              
                 end component;              
    

                       begin

                            dut: fancy_counter port map    --Here, we will just assign the entity values of the "fancy_counter" into the temporary values of the "fancy_counter_testbench"
                                      (clk => clk,
                                      clk_en => clk_en,
                                      en => en,
                                      dir => dir,
                                      ld => ld,
                                      rst => rst,
                                      updn => updn,
                                      val => val,
                                      cnt => cnt);


                            process         --This is just the clock.div part manual simulation being set up
                                begin        --8ns clock cycle = 125MHZ
                                      wait for 4 ns;    --set high for half the period
                                      clk <= '1';
                                    
                                      wait for 4 ns;    --set low for half  
                                      clk <= '0';
                           end process;

 
                            process     --This is similar to the "debounce". We test high or entity values of the counter for the manually given times.
                                begin     --Remember that this whole column simulation must total 50ms, because it is our counter original total time.
                                       
                                    wait for 5ms;  --initial wait
                              --case #1, We introduce all these inputs
                                    en <= '0';  --first we try to break it, unless en = '1' nothing will change the circuit
                                    clk_en <= '1';
                                    dir <= '1';
                                    ld <= '1';
                                    val <= "1001";  --this is just a test entity "val"
                                    updn <= '1';
                                    rst <= '0';
                                    
                                    wait for 10ms;   --we give it an actual time out of 50ms
  
                                    en <= '1';        --even if en = '1' if clk_en is '0' only rst can change the circuit
                                    clk_en <= '0';
                                    ld <= '1';
                                    val <= "1001";
                                    updn <= '1';
                                    rst <= '1';      --rst should set the output to '0'
                                    wait for 5ms;
                                    
                                    rst <= '0';
                                    wait for 1ms;
                                    
                                  
                                    en <= '1';        --From here we try to count up
                                    clk_en <= '1';
                                    dir <= '1';
                                    ld <= '1';
                                    val <= "1001";
                                    updn <= '1';
                                    wait for 8ns;
                                    
                                    clk_en <= '0';  --Notice that from here on we just change the clock_enable
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0'; 
                                    
                                    wait for 20ms;
                                    
                                    en <= '1';      --Now we give input values that will cause the counter to count up and down
                                    clk_en <= '1';
                                    dir <= '0';
                                    ld <= '0';
                                    val <= "1001";
                                    updn <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 8ns;
                                    clk_en <= '1';
                                    wait for 8ns;
                                    clk_en <= '0';
                                    wait for 10ms;
    
                                    rst <= '1';     --reset output
                                    clk_en <= '0';
                                    dir <= '0';
                                    ld <= '0';
                                    val <= "0000";
                                    updn <= '0';
                                    
                                    wait;  --This is where it ends
                        end process;
 
end Behavioral;
