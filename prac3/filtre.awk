#!/bin/awk
# aquest és un comentari!
# però la primera línia és important, perque ajuda a l'editor a reconeixer el tipus de fitxer
# i colorejar-ho bé!!!!
# sempre que hi hagi un caràcter # el text següent no es te en compte.
BEGIN	{
	print "Resultat del filtratge del fitxer"; 
	eleconta=0;
	tigrconta=0;
	}
/^[^-]/ {				#selecciona les  línies que no comencen per "-"
	suma=$5+$6+$7+$8+$9+$10;	#calcula la suma de les columnes de 5 a 10
	print "El pes total dels exemplars de la espècie " $1 " avui és " suma; # escriu coses
	}
/^Ele/	{
	eleconta=eleconta+NF-4;		#afegeix al nombre d'elefants el nombre de columnes (menys 4, que les primeres no conten)
	print eleconta " elefantes se balanceaban sobre la tela de una araña..."  ; # canta una cançó...
	print "y como veían que no se caían fueron a llamar a otro elefante!!";
	}
/^Tigr/	{ 
	tigrconta=tigrconta+1;		#conta totes les vegades que observem tigres.
	}
	
END	{
	print "S'han observat Tigres en " tigrconta " dies diferents!"
	}

