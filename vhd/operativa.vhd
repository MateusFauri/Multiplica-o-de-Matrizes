package matriz_cnt_pkg is
    type matriz_array is array(natural range <>) of integer; 
    type Matriz8 is array (0 to 7, 0 to 7) of integer;
    type Matriz4 is array (0 to 3, 0 to 3) of integer;
    type Matriz2 is array (0 to 1, 0 to 1) of integer;
end package;

library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
use IEEE.NUMERIC_STD.ALL;
use work.matriz_cnt_pkg.all;


entity operative is
    Port(
        clock :   in  std_logic;
        reset_dados :   in  std_logic;
        entrada_a : in Matriz8;
        entrada_b : in Matriz2;
        loadR : in std_logic;
        loadA : in std_logic;
        loadB : in std_logic;
        loadC : in std_logic;
        loadD : in std_logic;
        doneA : out std_logic;
        doneB : out std_logic;
        doneC : out std_logic;
        doneD : out std_logic;
        doneR : out std_logic;
        resultado : out Matriz2
    );
end operative;

architecture behav of operative is

    signal MatrizA, MatrizB, MatrizC, MatrizD : Matriz4;
    signal Final,MatrizM : Matriz2;
    
begin

  process(clock, reset_dados, loadA)
    variable acumulador : integer;
  begin
      if reset_dados = '1' then
        acumulador := 0;
        MatrizM(0,0) <= 0;
        doneA <= '0';
        
        for row in 0 to 3 loop
            for col in 0 to 3 loop
                MatrizA(row,col) <= 0;
            end loop;
        end loop;
            
      elsif rising_edge(clock) then
          if loadA = '1' then
              acumulador := 0;
              for row in 0 to 3 loop
                  for col in 0 to 3 loop
                    MatrizA(row,col) <= entrada_a(row,col);
                    acumulador := acumulador + entrada_a(row,col);
                  end loop;
              end loop;
              MatrizM(0,0) <= acumulador / 16;
              doneA <= '1';
          else
            MatrizA <= MatrizA;
          end if;
       end if;
  end process;   

  process(clock, reset_dados, loadB)
    variable acumulador : integer;
    variable mcol : integer;
  begin
      if reset_dados = '1' then
          MatrizM(0,1) <= 0;
          acumulador := 0;
          doneB <= '0';
                  
        for row in 0 to 3 loop
            for col in 0 to 3 loop
                MatrizB(row,col) <= 0;
            end loop;
        end loop;

      elsif rising_edge(clock) then
          if loadB = '1' then
              acumulador := 0;
              for row in 0 to 3 loop
                  for col in 4 to 7 loop
                      mcol := col -4;
                      MatrizB(row, mcol) <= entrada_a(row,col);
                      acumulador := acumulador + entrada_a(row,col);
                  end loop;
              end loop;
            MatrizM(0,1) <= (acumulador / 16);
            doneB <= '1';
            else
                MatrizB <= MatrizB;
          end if;
      end if;
  end process;

  process(clock, reset_dados, loadC)
    variable acumulador : integer;
    variable mrow : integer;
  begin
      if reset_dados = '1' then
          MatrizM(1,0) <= 0;
          acumulador := 0;
          doneC <= '0';

        for row in 0 to 3 loop
            for col in 0 to 3 loop
                MatrizC(row,col) <= 0;
            end loop;
        end loop;

      elsif rising_edge(clock) then
          if loadC = '1' then
              acumulador := 0;
              for row in 4 to 7 loop
                  for col in 0 to 3 loop
                      mrow := row - 4;
                      MatrizC(mrow,col) <= entrada_a(row,col);
                      acumulador := acumulador + entrada_a(row,col);
                  end loop;
              end loop;
              MatrizM(1,0) <=  (acumulador / 16);
              doneC <= '1';
          else
            MatrizC <= MatrizC;
          end if;
      end if;
  end process;

  process(clock, reset_dados, loadD)
    variable acumulador : integer;
    variable mrow, mcol : integer;
  begin
      if reset_dados = '1' then
        MatrizM(1,1) <= 0;
        acumulador := 0;
        doneD <= '0';
                            
        for row in 0 to 3 loop
            for col in 0 to 3 loop
                MatrizD(row,col) <= 0;
            end loop;
        end loop;

      elsif rising_edge(clock) then
          if loadD = '1' then
              acumulador := 0;
              for row in 4 to 7 loop
                  for col in 4 to 7 loop
                      mrow := row - 4;
                      mcol := col - 4;
                      MatrizD(mrow,mcol) <= entrada_a(row,col);
                      acumulador := acumulador + entrada_a(row,col);
                  end loop;
              end loop;
              MatrizM(1,1) <= (acumulador / 16);
              doneD <= '1';
          else
            MatrizD <= MatrizD;
          end if;
      end if;
  end process;


  process(clock, reset_dados)
  begin
      if reset_dados = '1' then
        doneR <= '0';
        for row in 0 to 1 loop
            for col in 0 to 1 loop
                final(row,col) <= 0;
            end loop;
        end loop;
      elsif rising_edge(clock) then
          if loadR = '1' then
              final(0,0) <= (MatrizM(0,0) * entrada_b(0,0)) + (MatrizM(0,1) * entrada_b(1,0));
              final(0,1) <= (MatrizM(0,0) * entrada_b(0,1)) + (MatrizM(0,1) * entrada_b(1,1));
              final(1,0) <= (MatrizM(1,0) * entrada_b(0,0)) + (MatrizM(1,1) * entrada_b(1,0));
              final(1,1) <= (MatrizM(1,0) * entrada_b(0,1)) + (MatrizM(1,1) * entrada_b(1,1));
              doneR <= '1';
          else
              final <=  final;
          end if;
      end if;
  end process;
  resultado <= final;

end behav;