LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity cale_control is
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
end cale_control;

architecture cale_control of cale_control is
    -- Definim tipul 'stare' care conține diferitele stări ale mașinii de stări.
    type stare is (INIT, SETUP, SHIFTP, SHIFTA, SUB, ADD, ENDOP);

    signal stare_curenta  : stare    ;
    signal stare_urmatoare: stare    ;
    signal valid          : std_logic;
    signal count          : integer  ;
    -- Procesul principal care gestionează logica de control a stărilor
    begin
    CLC : process (reset_n, stare_curenta, start, neg_p, count) begin
	-- Mașina de stări, care decide următoarea stare bazată pe condițiile curente
        case stare_curenta is
            when INIT =>
                if (reset_n = '0') then 
		            stare_urmatoare <= INIT;
                elsif (start = '1') then
		            stare_urmatoare <= SETUP;
                else
     	            stare_urmatoare <= INIT;
                end if;
              
             when SETUP =>
                if (reset_n = '0') then 
			        stare_urmatoare <= INIT;
                else 
		            stare_urmatoare <= SHIFTP;
                end if;
               
            when SHIFTP =>
                if (reset_n = '0') then
      	            stare_urmatoare <= INIT;
                elsif (count = 0) then 
		            stare_urmatoare <= ENDOP;
                else
     	            stare_urmatoare <= SUB;
                end if;
              
            when SUB =>
                if (reset_n = '0') then
     		       stare_urmatoare <= INIT;
                else
     	            stare_urmatoare <= SHIFTA;
                end if;
                  
            when SHIFTA =>
               if (reset_n = '0') then
     		       stare_urmatoare <= INIT;
               elsif (neg_p = '1') then
   		            stare_urmatoare <= ADD;
               elsif (count = 0) then 
		            stare_urmatoare <= ENDOP; 
               else
     		       stare_urmatoare <= SHIFTP;
               end if;
				 
            when ADD =>
                if (reset_n = '0') then
   		            stare_urmatoare <= INIT;
                elsif (count = 0) then 
		            stare_urmatoare <= ENDOP;
                else 
		            stare_urmatoare <= SHIFTP;
                end if;
               
            when ENDOP =>
                if (reset_n = '0') then 
		            stare_urmatoare <= INIT;
                else
  		            stare_urmatoare <= INIT; 
                end if;                                
        end case; 
		  -- Logica de control pentru semnalele de ieșire bazate pe starea curentă 
        if (stare_curenta = SETUP) then load_data <= '1';
        else load_data <= '0';
        end if;
           
        if (stare_curenta = SHIFTP) then shift_p <= '1';
        else shift_p <= '0';
        end if;
           
        if (stare_curenta = SUB) then scade_b <= '1';
        else scade_b <= '0';
        end if;
          
        if (stare_curenta = SHIFTA) then shift_a <= '1';
        else shift_a <= '0';
        end if;
           
        if (stare_curenta = ADD) then aduna_b <= '1';
        else aduna_b <= '0';
        end if;
           
        if (stare_curenta = ENDOP) then end_op <= '1';
        else end_op <= '0';
        end if;   
		
    end process CLC;
     -- Procesul pentru actualizarea stării curente
    REG : process (ck) begin
        if ((not ck'stable) and (ck = '1')) then
            stare_curenta <= stare_urmatoare;
        end if; 
    end process REG;
  -- Procesul pentru controlul contorului     
    CONTOR : process (ck) begin
        if ((not ck'stable) and (ck = '1')) then
            if (reset_n = '0') then count <= 0;
            elsif (stare_curenta = INIT) then count <= 8;
            elsif (stare_curenta = SHIFTP) then count <= count - 1;
            end if;
        end if;
    end process CONTOR;
     -- Procesul pentru validarea stării curente    
    VALIDARE : process (ck) begin
        if ((not ck'stable ) and (ck = '1')) then
            if (reset_n = '0') then valid <= '0';
            elsif (stare_curenta = ENDOP) then valid <= '1';
            elsif (stare_curenta = INIT) then valid <='0';
            end if;
        end if;
    end process VALIDARE;
       -- Atribuirea semnalului 'ready' bazat pe semnalul 'valid'   
    ready <= valid;    

end cale_control;
