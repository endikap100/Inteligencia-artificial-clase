



(deftemplate Persona
(multislot nombre (type STRING) )
(slot ColorPelo)
(slot ColorOjos)
(slot casado (type SYMBOL) (allowed-symbols si no)  )
)

(deffacts Persona "Meter gente"
	(Persona (nombre "Juan")(ColorPelo marron)(casado no)(ColorOjos azul))
	(Persona (nombre "Juana")(ColorPelo rojo)(casado no)(ColorOjos amarillo))
	(Persona (nombre "Juanan")(ColorPelo negro)(casado si)(ColorOjos verde))
)
	
	
	
; Hay que meter datos con deffacts 

(defrule mostrar "Mostrar la peñita de pelo marron o negro" 
	(and
	(or 
	(Persona
		(nombre ?n)
		(ColorOjos azul)
		(ColorOjos ?color)
		(ColorPelo ~negro)
		(ColorPelo ?pelo)
	)
	(Persona
		(nombre ?n)
		(ColorOjos verde)
		(ColorOjos ?color)
		(ColorPelo ~negro)
		(ColorPelo ?pelo)
	)
   )
	(Persona
		(nombre ~?n)
		(ColorOjos ~color)
		(ColorPelo rojo)
		(ColorPelo ?pelo)
		(nombre ?m)
	)	
)
=> 
	
	(printout t ?n crlf)
	(printout t ?m crlf)
) 