LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

entity impartire is
    port ( 
	       op1 		     : in  std_logic_vector(7 downto 0); 
           op2 		     : in  std_logic_vector(7 downto 0);
           ck       	 : in  std_logic                   ;
           reset_n   	 : in  std_logic                   ;
           start     	 : in  std_logic                   ;
           ready     	 : out std_logic                   ;
	       rezultat_cat  : out std_logic_vector(7 downto 0);
	       rezultat_rest : out std_logic_vector(7 downto 0)
           );
end impartire;

architecture impartire of impartire is
    signal load_data    : std_logic;
    signal shift_a  	: std_logic;
    signal shift_p  	: std_logic;
    signal scade_b  	: std_logic;
    signal aduna_b  	: std_logic;
    signal end_op     	: std_logic;
    signal neg_p      	: std_logic;
    
    component cale_control
    	port ( 
	       ck        : in  std_logic;
           reset_n    : in  std_logic;
           start      : in  std_logic;
           neg_p      : in  std_logic;
           ready      : out std_logic;
	       load_data  : out std_logic;
           end_op     : out std_logic;
           shift_a    : out std_logic;
           shift_p    : out std_logic;
           scade_b    : out std_logic;
           aduna_b    : out std_logic
	);
    end component;

    component cale_date
    	port ( 
	            op1  		       : in  std_logic_vector(7 downto 0);
                op2  		       : in  std_logic_vector(7 downto 0);
                rezultat_cat   : out std_logic_vector(7 downto 0);
	            rezultat_rest  : out std_logic_vector(7 downto 0);
                ck        	   : in  std_logic                   ;
                reset_n    	   : in  std_logic                   ;
                load_data	   : in  std_logic                   ;
                end_op     	   : in  std_logic                   ;
                shift_a 	   : in  std_logic                   ;
                shift_p 	   : in  std_logic                   ;
                scade_b  	   : in  std_logic                   ;
                aduna_b  	   : in  std_logic                   ;
                neg_p      	   : out std_logic
	);
    end component;

    begin
    i_data : cale_date port map( 
	    op1 => op1,
      	op2 => op2 ,
        rezultat_cat => rezultat_cat,
	    rezultat_rest => rezultat_rest,
      	ck =>  ck,
      	reset_n => reset_n,
      	neg_p => neg_p,
	    load_data => load_data,
      	end_op => end_op,
      	shift_a => shift_a,
      	shift_p => shift_p,
      	scade_b => scade_b,
      	aduna_b => aduna_b);
    
    i_control : cale_control port map( 
	    ck => ck,
      	reset_n => reset_n,
      	start => start,
      	neg_p => neg_p,
      	ready => ready,
      	end_op => end_op,
      	load_data => load_data,
      	shift_a => shift_a,
      	shift_p => shift_p,
      	scade_b => scade_b,
      	aduna_b => aduna_b);
      
end impartire;
