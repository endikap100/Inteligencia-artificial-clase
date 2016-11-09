

(deftemplate Persona
(multislot nombre (type STRING) )
(slot ColorPelo)
(slot casado (type SYMBOL) (allowed-symbols si no)  )
)

(deffacts Persona "Meter gente"
	(Persona (nombre "Juan")(ColorPelo marron)(casado no))
	(Persona (nombre "Juana")(ColorPelo rojo)(casado no))
	(Persona (nombre "Juanan")(ColorPelo negro)(casado si))
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