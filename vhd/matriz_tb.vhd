library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package matriz_pkg is
    type matriz_array is array(natural range <>) of integer;
end package;

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.matriz_pkg.all;

entity matriz_tb is
end;

architecture bench of matriz_tb is

  component matriz
      generic (bus_width : positive := 8);
      Port(
          clock           :   in  std_logic;
          reset           :   in  std_logic;
          entrada_a : in matriz_array(0 to 63);
          entrada_b : in matriz_array(0 to 3);
          done : out std_logic := '0';
          resultado : out matriz_array(0 to 3)
      );
  end component;

  signal clock: std_logic;
  signal reset: std_logic;
  signal entrada_a: matriz_array(0 to 63) :=  (1,2,3,4,5,5,5,5, -1,-2,-3,-4,-5,-6,-7,-8,1,2,3,4,5,5,5,5,-1,-2,-3,-4,-5,-6,-7,-8,1,2,3,4,5,6,7,8,-2,-2,-2,-2,-2,-2,-2,-2,1,2,3,4,5,6,7,8,-2,-2,-2,-2,-2,-2,-2,-2);
  signal entrada_b: matriz_array(0 to 3) := (1,-1,1,-1);
  signal done: std_logic := '0';
  signal resultado: matriz_array(0 to 3) := (0,0,0,0) ;
 

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: matriz
     port map ( clock     => clock,
                reset     => reset,
                entrada_a => entrada_a,
                entrada_b => entrada_b,
                done      => done,
                resultado => resultado );
    
  stimulus: process
  begin
     
    wait for 1000 ns;

    reset <= '1';
    wait for 5 ns;
    reset <= '0';
    wait for 5 ns;
   
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