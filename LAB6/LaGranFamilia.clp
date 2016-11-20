(deftemplate padre-de
	(slot padre )
	(slot hijo)
)	
(deftemplate madre-de
	(slot madre )
	(slot hijo)
)	

(deftemplate mujer-de
	(slot esposa )
	(slot esposo)
)	
(deftemplate hombre-de
	(slot esposa )
	(slot esposo)
)	

(deffacts La-Gran-Familia-Espa�ola
	( padre-de (padre Alberto) (hijo Diana)) 
	( padre-de (padre Alberto) (hijo Enroque)) 
	( madre-de (madre Belinda) (hijo Diana)) 
	( madre-de (madre Belinda) (hijo Enroque)) 
	(mujer-de (esposo Alberto)(esposa Belinda))
	(hombre-de (esposo Alberto)(esposa Belinda))
	
	(mujer-de (esposo Carlos)(esposa Diana))
	(hombre-de (esposo Carlos)(esposa Diana))
	( padre-de (padre Carlos) (hijo Gabriel)) 	
	( madre-de (madre Diana) (hijo Gabriel)) 
	
	(mujer-de (esposo Enroque)(esposa Fiorina))
	(hombre-de (esposo Enroque)(esposa Fiorina))
	( padre-de (padre Enroque) (hijo Hilario)) 	
	( madre-de (madre Fiorina) (hijo Hilario)) 
	
	(hombre Alberto)
	(hombre Enroque)
	(hombre Carlos)
	(hombre Gabriel)
	(hombre Hilario)
	(mujer Belinda)
	(mujer Diana)
	(mujer Fiorina)
	) 



(defrule Tio-Tia
	(declare (salience 40)) 
	(padre-de 
		(padre ?p)
		(hijo ?h)
		)
	(padre-de 
		(padre ?h)
		(hijo ?h1)
		)
		
	(padre-de 
		(padre ?p)
		(hijo  ?k & ~?h)
		)	
	
	
=> 
	(printout t ?k" es un tio-tia de "?h1 crlf)) 