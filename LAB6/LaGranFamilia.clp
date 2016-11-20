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

(deffacts La-Gran-Familia-Espanola
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
	(or
		(padre-de
			(padre ?p)
			(hijo ?h)
		)
		(madre-de
			(madre ?p)
			(hijo ?h)
		)
	)
	(or
		(padre-de
			(padre ?h)
			(hijo ?h1)
		)
		(madre-de
			(madre ?h)
			(hijo ?h1)
		)
	)

	(or
		(padre-de
			(padre ?p)
			(hijo  ?k & ~?h)
		)
		(madre-de
			(madre ?p)
			(hijo  ?k & ~?h)
		)
	)
	(or(hombre-de (esposo ?q)(esposa ?k ))(hombre-de (esposo ?k)(esposa ?q )))

=>
	(printout t ?k" es un tio-tia de "?h1 crlf)
	(printout t ?q" es un tio-tia de "?h1 crlf)
)
(defrule Hermano-Hermana
	(declare (salience 40))
		(padre-de
			(padre ?p)
			(hijo ?h)
		)
		(padre-de
			(padre ?p)
			(hijo ?q & ~?h)
		)

=>
	(printout t ?h" es un Hermano-Hermana de "?q crlf)
)

(defrule Primo-Prima
	(declare (salience 40))
	(or
		(padre-de
			(padre ?p)
			(hijo ?h)
		)
		(madre-de
			(madre ?p)
			(hijo ?h)
		)
	)
	(or
		(padre-de
			(padre ?h)
			(hijo ?h1)
		)
		(madre-de
			(madre ?h)
			(hijo ?h1)
		)
	)
	(or
		(padre-de
			(padre ?p)
			(hijo  ?k & ~?h)
		)
		(madre-de
			(madre ?p)
			(hijo  ?k & ~?h)
		)
	)
	(or
		(padre-de
			(padre ?k)
			(hijo  ?z)
		)
		(madre-de
			(madre ?k)
			(hijo  ?z)
		)
	)


=>
	(printout t ?z" es un Primo-Prima de "?h1 crlf)
)


(defrule Abuelo-Abuela
	(declare (salience 30))
	(or
		(padre-de
			(padre ?p)
			(hijo ?h)
		)
		(madre-de
			(madre ?p)
			(hijo ?h)
		)
	)
	(or
		(padre-de
			(padre ?h)
			(hijo ?h1)
		)
		(madre-de
			(madre ?h)
			(hijo ?h1)
		)
	)

=>
	(printout t ?p" es un Abuelo-Abuela de "?h1 crlf)
)


(defrule Abuelo-Abuela-pareja
	(declare (salience 30))
	(or
		(padre-de
			(padre ?p)
			(hijo ?h)
		)
		(madre-de
			(madre ?p)
			(hijo ?h)
		)
	)
	(or
		(padre-de
			(padre ?h)
			(hijo ?h1)
		)
		(madre-de
			(madre ?h)
			(hijo ?h1)
		)
	)

	(or
		(padre-de
			(padre ?p)
			(hijo  ?k & ~?h)
		)
		(madre-de
			(madre ?p)
			(hijo  ?k & ~?h)
		)
	)
	(or(hombre-de (esposo ?q)(esposa ?p ))(hombre-de (esposo ?p)(esposa ?q )))

=>
	(printout t ?p" es un Abuelo-Abuela y pareja de "?q crlf)
	
)
