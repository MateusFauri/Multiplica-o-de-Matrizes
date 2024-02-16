package matriz_cnt_pkg is
    type matriz_array is array(natural range <>) of integer; 
    type Matriz8 is array (0 to 7, 0 to 7) of integer;
    type Matriz4 is array (0 to 3, 0 to 3) of integer;
    type Matriz2 is array (0 to 1, 0 to 1) of integer;
end package;

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.matriz_cnt_pkg.all;

entity matriz_tb is
end;

architecture bench of matriz_tb is

  component matriz
      Port(
          clock           :   in  std_logic;
          reset           :   in  std_logic;
          entrada_a : in Matriz8;
          entrada_b : in Matriz2;
          done : out std_logic;
          resultado : out Matriz2
      );
  end component;

  signal clock: std_logic;
  signal reset: std_logic;
  signal entrada_a: Matriz8 :=  (
                                 (1,2,3,4,5,5,5,5), 
                                 (-1,-2,-3,-4,-5,-6,-7,-8), 
                                 (1,2,3,4,5,5,5,5), 
                                 (-1,-2,-3,-4,-5,-6,-7,-8), 
                                 (1,2,3,4,5,6,7,8), 
                                 (-2,-2,-2,-2,-2,-2,-2,-2), 
                                 (1,2,3,4,5,6,7,8), 
                                 (-2,-2,-2,-2,-2,-2,-2,-2));
 -- signal entrada_a: Matriz8 :=  (         
 --                                 (11,5,7,2,5,4,8,9), 
 --                                 (-1,5,7,-4,-2,-10,4,9), 
 --                                 (3,4,4,4,5,0,5,0), 
 --                                 (4,7,-6,2,1,1,-1,1), 
 --                                 (4,4,5,5,-3,3,3,12), 
 --                                 (-3,4,1,0,-2,-7,-3,-2), 
 --                                 (1,-3,9,2,14,-12,13,3), 
 --                                 (-5,-5,-5,5,-5,5,5,5));
                                  
  signal entrada_b: Matriz2 := ((1, -1),
                                (1, -1));
  signal done: std_logic; 
  signal resultado: Matriz2 ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: matriz port map ( clock     => clock,
                         reset     => reset,
                         entrada_a => entrada_a,
                         entrada_b => entrada_b,
                         done      => done,
                         resultado => resultado );

  stimulus: process
  begin
  
    wait for 1000 ns;
    -- Put initialisation code here

    reset <= '1';
    wait for 5 ns;
    reset <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clock <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;