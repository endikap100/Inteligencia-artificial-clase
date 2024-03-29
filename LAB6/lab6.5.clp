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
	(actividad
		(ciudad ?n)
		(duracion ?u)
		
	)
	
	
	
=> 
	(assert (tiempo ?u ?n))

) 
(defrule R3 
	(declare (salience 30)) 
	(persona
		(nombre ?n)
		(ciudad ?k)
		
	)
	
	
	
=> 
	(assert (media 0 ?n 0 ?k))

) 

(defrule R2
	(declare (salience 20)) 
	
	 ?a <-(tiempo ?m ?n)
	 ?d <-(media ?o ?j ?p  ?n)  	
=> 
	(assert (media (+ ?o ?m) ?j (+ 1 ?p) ?n))
	(retract ?a)
	(retract ?d)
	
) 		
	
(defrule R5 
	(declare (salience 10)) 
	(media ?n ?u ?r ?k) 
=> 

(printout t "La duraci�n media de las actividades de "?u" es de "(/ ?n ?r) crlf)
	) 
