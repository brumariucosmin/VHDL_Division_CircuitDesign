LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

entity test_bench is
end test_bench;

architecture test_bench of test_bench is
    component impartire is
        port (   op1 : in std_logic_vector (7 downto 0)               ;
                 op2 : in std_logic_vector (7 downto 0);
                 rezultat_cat  : out std_logic_vector(7 downto 0)   ;
                 rezultat_rest : out std_logic_vector(7 downto 0)   ;
                 ck       : in std_logic                           ;
                 reset_n   : in std_logic                           ;
                 start     : in std_logic                           ;
                 ready     : out std_logic
			 );
    end component;
    
    signal ck       : std_logic := '0'                 ;
    signal op1         : std_logic_vector(7 downto 0)     ;
    signal op2         : std_logic_vector(7 downto 0)     ;
    signal rezultat_cat  : std_logic_vector(7 downto 0) ;
    signal rezultat_rest : std_logic_vector(7 downto 0) ;
    signal reset_n   : std_logic                        ;
    signal start     : std_logic                        ;
    signal ready     : std_logic                        ;
    
    begin
        DIV : impartire port map 
         ( 
		   op1                 =>    op1             ,
           op2                 =>    op2             ,
           rezultat_cat      =>    rezultat_rest ,
		   rezultat_rest     =>    rezultat_cat  ,
           start             =>    start         ,
           ready             =>    ready         ,
           reset_n           =>    reset_n       ,
           ck               =>    ck 
		 );
           
        ck <= not ck after 5 ns;
        op1 <= "01001111";
        op2 <= "00000010";
        start   <= '0', '1' after 60 ns, '0' after 70 ns, '1' after 470 ns, '0' after 480 ns;
        reset_n <= '0', '1' after 10 ns;
end test_bench;