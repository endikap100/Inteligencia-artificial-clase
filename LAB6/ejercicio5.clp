(deftemplate persona
(slot nombre  )
(slot ciudad  )
)

(deftemplate actividad
(slot nombre  )
(slot ciudad  )
(slot duracion (type INTEGER) )
)



(deffacts personas 
	(persona (nombre Juan) (ciudad Paris)) 
	(persona (nombre Ana) (ciudad Edimburgo))) 

(deffacts actividades 
	(actividad (nombre Torre_Eiffel) (ciudad Paris) (duracion 2)) 
	(actividad (nombre Castillo_de_Edimburgo) (ciudad Edimburgo) (duracion 5)) 
	(actividad (nombre Louvre) (ciudad Paris) (duracion 6)) 
	(actividad (nombre Montmartre) (ciudad Paris) (duracion 1)) 
	(actividad (nombre Royal_Mile) (ciudad Edimburgo) (duracion 3))) 


(defrule R1 
	(declare (salience 30)) 
	(persona
		(nombre ?n)
		
	)
	
=> 
	(assert (tiempo 0 ?n 0))) 	
	
(defrule R4 
	(declare (salience 29)) 
	?a <-(tiempo ?n ?u ?r) 
	(persona
		(nombre ?n)
		(ciudad ?m)
		
	)
		(actividad
		(ciudad ?m)
		(duracion ?v)
		
	)
=> 
	(assert (tiempo ?n (+ ?u ?v) ( + ?r 1) ) )
	(retract ?a)
	) 
	
(defrule R5 
	(declare (salience -29)) 
	(tiempo ?n ?u ?r) 
=> 
	(printout t "La duración media de las actividades de "?n" es de "(/ ?u ?r) crlf)) 