#include <genlib.h>  
  
main()  
{  
int i;  
  
   GENLIB_DEF_LOFIG("impartire_top");  
  
   GENLIB_LOCON("vdd",           IN,        "vdd");    
   GENLIB_LOCON("vss",           IN,        "vss");    
   GENLIB_LOCON("vdde",          IN,       "vdde");   
   GENLIB_LOCON("vsse",          IN,       "vsse");   
   GENLIB_LOCON("op1[7:0]",        IN,     "op1[7:0]");    
   GENLIB_LOCON("op2[7:0]",        IN,     "op2[7:0]");    
   GENLIB_LOCON("reset",         IN,      "reset");    
   GENLIB_LOCON("start",         IN,      "start");    
   GENLIB_LOCON("ck",           IN,        "ck");    
   GENLIB_LOCON("ready",        OUT,      "ready");    
   GENLIB_LOCON("cat[7:0]",     OUT,   "cat[7:0]");
   GENLIB_LOCON("rest[7:0]",    OUT,  "rest[7:0]");    
     
                              
   GENLIB_LOINS ("pvsse_sp", "p36", "cki", "vdde", "vdd", "vsse", "vss", 0);  
   GENLIB_LOINS ("pvdde_sp", "p37", "cki", "vdde", "vdd", "vsse", "vss", 0);  
   GENLIB_LOINS ("pvddeck_sp", "p38", "clock", "cki", "vdde", "vdd", "vsse", "vss",0); 
   GENLIB_LOINS ("pvssi_sp", "p39", "cki", "vdde", "vdd", "vsse", "vss", 0);  
   GENLIB_LOINS ("pvddi_sp", "p40", "cki", "vdde", "vdd", "vsse", "vss", 0);  
  
   for (i = 0; i < 8; i++)  
    GENLIB_LOINS("pi_sp", GENLIB_NAME("p%d", i),   
          GENLIB_NAME("op1[%d]", i), GENLIB_NAME("aa[%d]", i),   
         "cki", "vdde", "vdd", "vsse", "vss", 0);  
  
   for (i = 0; i < 8; i++)  
    GENLIB_LOINS("pi_sp", GENLIB_NAME("p%d", i + 8),   
          GENLIB_NAME("op2[%d]", i), GENLIB_NAME("bb[%d]", i),   
         "cki", "vdde", "vdd", "vsse", "vss", 0);  
  
   for (i = 0; i < 8; i++)  
    GENLIB_LOINS("po_sp", GENLIB_NAME("p%d", i + 16),   
          GENLIB_NAME("catcat[%d]", i), GENLIB_NAME("cat[%d]", i),  
         "cki", "vdde", "vdd", "vsse", "vss", 0);  

   for (i = 0; i < 8; i++)  
    GENLIB_LOINS("po_sp", GENLIB_NAME("p%d", i + 24),   
          GENLIB_NAME("restrest[%d]", i), GENLIB_NAME("rest[%d]", i),  
         "cki", "vdde", "vdd", "vsse", "vss", 0);
  
  
   GENLIB_LOINS("pi_sp", "p32",  
         "start", "startstart",  
         "cki", "vdde", "vdd", "vsse", "vss", 0);  
     
   GENLIB_LOINS("pi_sp", "p33",  
         "reset", "resetreset",  
         "cki", "vdde", "vdd", "vsse", "vss", 0);  
     
   GENLIB_LOINS("pck_sp", "p34",  
         "ck",  
         "cki", "vdde", "vdd", "vsse", "vss", 0);  
     
   GENLIB_LOINS("po_sp", "p35",  
         "readyready", "ready",  
         "cki", "vdde", "vdd", "vsse", "vss", 0);  
     
   GENLIB_LOINS("impartire", "impartire",  
	 "clock", "resetreset",   
         "aa[7:0]", "bb[7:0]", 
 	 "startstart", "readyready", 
	 "catcat[7:0]", "restrest[7:0]",
	 "vdd", "vss", 0);  
  
   GENLIB_SAVE_LOFIG();  
   exit(0);   
}  
