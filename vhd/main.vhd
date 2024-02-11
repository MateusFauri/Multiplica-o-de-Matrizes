library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package matriz_pkg is
    type matriz_array is array(natural range <>) of integer;
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matriz_pkg.all;

entity matriz is
    generic (bus_width : positive := 8);
    Port(
        clock           :   in  std_logic;
        reset           :   in  std_logic;
        entrada_a : in matriz_array(0 to 63);
        entrada_b : in matriz_array(0 to 3);
        done : out std_logic := '0';
        resultado : out matriz_array(0 to 3)
    );
end matriz;

architecture behav of matriz is

    component operative is
        Port(
            clock :   in  std_logic;
            reset_dados :   in  std_logic;
            entrada_a : in matriz_array(0 to 63);
            entrada_b : in matriz_array(0 to 3);
            loadR : in std_logic;
            loadA : in std_logic;
            loadB : in std_logic;
            loadC : in std_logic;
            loadD : in std_logic;
            loadCount : in std_logic;
            decCount : in std_logic;
            resultado : out  matriz_array(0 to 3);
            acabouMedia : out std_logic
        );
    end component;

    type states is (SI,S1,S2, SF);
    
    signal state, next_state : states;
    signal reset_dados, endMed, decCount : std_logic;
    signal loadR, loadA, loadB, loadC, loadD, loadCount : std_logic;

begin

    calculo: operative 
    Port map(
        clock=> clock,
        reset_dados=> reset_dados ,
        entrada_a=> entrada_a,
        entrada_b => entrada_b,
        loadR=>loadR ,
        loadA=>loadA ,
        loadB=>loadB ,
        loadC=>loadC ,
        loadD=>loadD ,
        loadCount=>loadCount ,
        decCount => decCount,
        resultado => resultado,
        acabouMedia => endMed
    );

    process(clock, reset) 
    begin 
        if reset = '1' then 
            state <= SI;
            reset_dados <= '1';
        elsif rising_edge(clock) then 
            state <= next_state;
        end if;
    end process;

    process(state)
    begin
        case state is
            when SI =>
                reset_dados <= '0';
                loadCount <= '1';
                loadR <= '0';
                loadA <= '0';
                loadB <= '0';
                loadC <= '0';
                loadD <= '0';
                decCount <= '0';
                next_state <= S1;

            when S1 =>
                reset_dados <= '0';
                loadCount <= '0';
                loadR <= '0';
                decCount <= '1';
                loadA <= '1';
                loadB <= '1';
                loadC <= '1';
                loadD <= '1';
                if endMed = '1' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;

            when S2 =>
                loadCount <= '0';
                decCount <= '0';
                loadA <= '0';
                loadB <= '0';
                loadC <= '0';
                loadD <= '0';
                loadR <= '1';
                next_state <= SF;

            when SF =>  
                done <= '1';
                next_state <= SF;

        end case;
    end process;

end behav;