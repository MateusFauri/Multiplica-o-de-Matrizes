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

entity matriz is
    Port(
        clock           :   in  std_logic;
        reset           :   in  std_logic;
        entrada_a : in Matriz8;
        entrada_b : in Matriz2;
        done : out std_logic;
        resultado : out Matriz2
    );
end matriz;

architecture behav of matriz is

    component operative is
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
    end component;

    type states is (S0,S1,S2,S3);
    
    signal state, next_state : states;
    signal reset_dados, doneA, doneB, doneC, doneD, doneR : std_logic;
    signal loadR, loadA, loadB, loadC, loadD : std_logic ;

begin

    op: operative 
    Port map(
        clock => clock,
        reset_dados => reset_dados,
        entrada_a => entrada_a,
        entrada_b => entrada_b,
        loadR => loadR,
        loadA => loadA,
        loadB => loadB,
        loadC => loadC,
        loadD => loadD,
        doneA => doneA,
        doneB => doneB,
        doneC => doneC,
        doneD => doneD,
        doneR => doneR,
        resultado => resultado
    );

    process(clock, reset) 
    begin 
        if reset = '1' then 
            state <= S0;
        elsif rising_edge(clock) then 
            state <= next_state;
        end if;
    end process;

    process(state,doneA,doneB,doneC,doneD,doneR)
    begin
        case state is
            when S0 =>
                reset_dados <= '1';
                done <= '0';
                loadR <= '0';
                loadA <= '0';
                loadB <= '0';
                loadC <= '0';
                loadD <= '0';
                next_state <= S1;

            when S1 =>
                reset_dados <= '0';
                loadR <= '0';
                loadA <= '1';
                loadB <= '1';
                loadC <= '1';
                loadD <= '1';
                if doneA = '1' and doneB = '1' and doneC = '1' and doneD = '1' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;

            when S2 =>
                reset_dados <= '0';
                loadA <= '0';
                loadB <= '0';
                loadC <= '0';
                loadD <= '0';
                loadR <= '1';
                if doneR = '1' then
                    next_state <= S3;
                else 
                    next_state <= S2;
                end if;

            when S3 => 
                loadR <= '0'; 
                done <= '1';
                next_state <= S3;

        end case;
    end process;
end behav;
