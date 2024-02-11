library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package matriz_pkg is
    type matriz_array is array(natural range <>) of integer; 
end package;

library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
use work.matriz_pkg.all;


entity operative is
    Port(
        -- ENTRADA
        clock :   in  std_logic;
        reset_dados :   in  std_logic;
        entrada_a : in matriz_array(0 to 63);
        entrada_b : in matriz_array(0 to 3);
        
        -- SINAIS DE CONTROLE
        loadR : in std_logic;
        --loadM : in std_logic;
        loadA : in std_logic;
        loadB : in std_logic;
        loadC : in std_logic;
        loadD : in std_logic;
        loadCount : in std_logic;
        decCount : in std_logic;

        -- SAIDA
        resultado : out matriz_array(0 to 3);
        acabouMedia : out std_logic
    );
end operative;

architecture behav of operative is

    signal acumuladorA : integer := 0;
    signal acumuladorB : integer := 0;
    signal acumuladorC : integer := 0;
    signal acumuladorD : integer := 0;
    signal final : matriz_array(0 to 3) := (others => 0);
    signal MatrizM :  matriz_array(0 to 3) := (others => 0);
    signal count : integer;
    
begin

  -- Media dos quatro quadrantes da matriz A virando a matriz M
  process(clock, reset_dados, loadA)
  begin
      if reset_dados = '1' then
          acumuladorA <= 0;
          MatrizM(0) <= 0;
      elsif rising_edge(clock) then
          if loadA = '1' then
              for row in 0 to 3 loop
                  for col in 0 to 3 loop
                      acumuladorA <= acumuladorA + entrada_a((row * 8) + col);
                  end loop;
              end loop;
              MatrizM(0) <= MatrizM(0) +  (acumuladorA / 16);
          else
              acumuladorA <= acumuladorA;
          end if;
       end if;
  end process;   

  process(clock, reset_dados, loadB)
  begin
      if reset_dados = '1' then
          MatrizM(1) <= 0;
          acumuladorB <= 0;
      elsif rising_edge(clock) then
          if loadB = '1' then
              for row in 0 to 3 loop
                  for col in 0 to 3 loop
                      acumuladorB <= acumuladorB + entrada_a((row * 8) + col + 4);
                  end loop;
              end loop;
              MatrizM(1) <= MatrizM(1) + (acumuladorB / 16);
          else
              acumuladorB <= acumuladorB;
          end if;
      end if;
  end process;

  process(clock, reset_dados, loadC)
  begin
      if reset_dados = '1' then
          MatrizM(2) <= 0;
          acumuladorC <= 0;
      elsif rising_edge(clock) then
          if loadC = '1' then
              for row in 4 to 7 loop
                  for col in 0 to 3 loop
                      acumuladorC <= acumuladorC + entrada_a((row * 8) + col + 4);
                  end loop;
              end loop;
              MatrizM(2) <= MatrizM(2) + (acumuladorC / 16);
          else
              acumuladorC <= acumuladorC;
          end if;
      end if;
  end process;

  process(clock, reset_dados, loadD)
  begin
      if reset_dados = '1' then
          MatrizM(3) <= 0;
          acumuladorD <= 0;
      elsif rising_edge(clock) then
          if loadD = '1' then
              for row in 4 to 7 loop
                  for col in 0 to 3 loop
                      acumuladorD <= acumuladorD + entrada_a((row * 8) + col + 4);
                  end loop;
              end loop;
              MatrizM(3) <= MatrizM(3) + (acumuladorD / 16);
          else
              acumuladorD <= acumuladorD;
          end if;
      end if;
  end process;

  -- Sinal das iterações
  process(count)
  begin
      if count = 0 then
          acabouMedia <= '1';
      else
          acabouMedia <= '0';
      end if;
  end process;

  process(clock, reset_dados)
  begin
      if reset_dados = '1' then
          count <= 0;
      elsif rising_edge(clock) then
          if loadCount = '1' then
              count <= 3;
          elsif decCount = '1' then
              count <= count - 1;
          else
              count <= count;
          end if;
      end if;
  end process;

  resultado <= final;
  process(clock, reset_dados)
  begin
      if reset_dados = '1' then
          final <= (others => 0);
      elsif rising_edge(clock) then
          if loadR = '1' then
              final(0) <= (MatrizM(0) * entrada_b(0)) + (MatrizM(1) * entrada_b(2));
              final(1) <= (MatrizM(0) * entrada_b(1)) + (MatrizM(1) * entrada_b(3));
              final(2) <= (MatrizM(2) * entrada_b(0)) + (MatrizM(3) * entrada_b(2));
              final(3) <= (MatrizM(2) * entrada_b(1)) + (MatrizM(3) * entrada_b(3));
          else
              final <=  final;
          end if;
      end if;
  end process;

end behav;