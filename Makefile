all: TRANSLATE SYNTH VERIF PLACE ROUTE GEN S2R

TRANSLATE:
	vasy -I vhd -a -o -p impartire
	
	vasy -I vhd -a -o -p cale_date
	
	vasy -I vhd -a -o -p cale_control

SYNTH:
	boog cale_date cale_date
	
	boog cale_control cale_control
VERIF:
	asimut impartire impartire r1

PLACE:
	ocp -ring impartire impartire
	
	graal -l impartire

ROUTE:
	nero -V   impartire impartire
	
	graal -l impartire

GEN:
	genlib impartire_top
	
	ring impartire_top impartire_top
	
	graal -l impartire_top
	
S2R:
	s2r -r impartire_top impartire_top

	dreal -l impartire_top

clean:
	rm -f *.al impartire.ap impartire_r.ap impartire_top.ap *.cif *.vst *.xsc *.dat *.drc *.bak *.al *.vbe r1.pat
