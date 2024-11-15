LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity cale_date is
    port ( 
	      op1  		: in  std_logic_vector(7 downto 0)          ;
        op2  		: in  std_logic_vector(7 downto 0)          ;
        rezultat_cat   	: out std_logic_vector(7 downto 0);
      	rezultat_rest	: out std_logic_vector(7 downto 0)  ;
        ck        	: in  std_logic                       ;
        reset_n    	: in  std_logic                       ;
        load_data	: in  std_logic                         ;
        end_op     	: in  std_logic                       ;
        shift_a 	: in  std_logic                         ;
        shift_p 	: in  std_logic                         ;
        scade_b  	: in  std_logic                         ;
        aduna_b  	: in  std_logic                         ;
        neg_p      	: out std_logic
    );
end cale_date;

architecture cale_date of cale_date is
    
    signal reg_a : std_logic_vector   (7 downto 0);
    signal reg_b : std_logic_vector   (7 downto 0);
    signal reg_p : std_logic_vector   (8 downto 0);
    
    begin
	 -- Procesul pentru actualizarea registrului A
      proc_a : process (ck) begin
        if(( not ck'stable ) and ( ck = '1' )) then
          if (reset_n = '0') then reg_a <= "00000000";
          elsif (load_data = '1') then reg_a <= op1;
          elsif (shift_a = '1') then reg_a <= reg_a(6 downto 0) & (not reg_p(8));      
          end if;
        end if;
      end process proc_a;
 -- Atribuirea rezultatului restului
      rezultat_rest <= reg_a;
      -- Procesul pentru actualizarea registrului B     
      proc_b : process (ck) begin
        if(( not ck'stable ) and ( ck = '1' )) then
          if (reset_n = '0') then reg_b <= "00000000";
          elsif (load_data = '1') then reg_b <= op2;
          end if;
        end if;
      end process proc_b;
        -- Procesul pentru actualizarea registrului P   
      proc_p : process (ck) begin
        if(( not ck'stable ) and ( ck = '1' )) then
          if (reset_n = '0') then reg_p <= "000000000";
          elsif (load_data = '1') then reg_p <= "000000000";
          elsif (shift_p = '1') then reg_p <= reg_p(7 downto 0) & reg_a(7);
          elsif (scade_b = '1') then reg_p <= reg_p - reg_b;
          elsif (aduna_b = '1') then reg_p <= reg_p + reg_b;
          end if;
        end if;
      end process proc_p;
	  -- Atribuirea semnalului 'neg_p' și a rezultatului câtului
      neg_p <= reg_p(8);
      rezultat_cat <= reg_p(7 downto 0);

end cale_date;
