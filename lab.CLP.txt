



(deftemplate Habitacion
(slot clase (type SYMBOL) (allowed-symbols simple doble triple cuadruple)  )
)

(deftemplate Estudiante
(multislot nombre (type STRING) )
(slot sexo (type SYMBOL) (allowed-symbols varon hembra)  )
(slot television (type SYMBOL) (allowed-symbols si no)  )
)

(deffacts Persona "Meter habitaciones"
	(Habitacion (clase simple))
	(Habitacion (clase doble))
	(Habitacion (clase triple))
	(Habitacion (clase cuadruple))
	(Estudiante (nombre "Juan")(sexo varon)(televesion si))
	(Estudiante (nombre "Juana")(sexo hembra)(televesion si))
	(Estudiante (nombre "Juanan")(sexo varon)(televesion si))
	(Estudiante (nombre "Jon")(sexo varon)(televesion si))
	(Estudiante (nombre "Jone")(sexo hembra)(televesion si))	
	(Estudiante (nombre "Mikelatz")(sexo varon)(televesion no))
)
	
	
	
; Hay que meter datos con deffacts 

(defrule mostrar "Mostrar la peñita de pelo marron" 
	(Persona
	(nombre ?n)
	(ColorPelo ~marron)
	(casado  no)
)
=> 
	
	(printout t ?n crlf)
) 

;Ejercicio 2
(defrule mostrar "Mostrar la peñita de pelo marron o negro" 
	(or 
	(Persona
	(nombre ?n)
	(ColorPelo marron)
)(Persona
	(nombre ?n)
	(ColorPelo negro)
))
=> 
	
	(printout t ?n crlf)
) 


;Ejercicio 3

; Hay que meter datos con deffacts 

(defrule mostrar "Mostrar la peñita de pelo marron o negro" 
	(and 
	(Persona
	(nombre ?n)
	(ColorPelo ~marron)
)(Persona
	(nombre ?n)
	(ColorPelo ~negro)
))
=> 
	
	(printout t ?n crlf)
) 