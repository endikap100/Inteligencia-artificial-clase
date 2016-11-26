(deffacts hechos
	(hecho1 a b c d e)
  (hecho1 g f c b a)
  (union ))

(defrule Separar
  (declare (salience 50))
	?a <-(hecho1 $?n)
=>
  (progn$ (?i $?n)
    (assert (hecho2 ?i))
  )
  (retract ?a)
)

(defrule Juntar
  (declare (salience 10))
	?a <-(hecho2 ?n)
  ?b <-(union $?t)
=>
  (assert (union (insert$ $?t 1 ?n)))
  (retract ?a)
  (retract ?b)
)

(defrule Print
  (declare (salience 0))
	(union $?n)
=>
  (printout t "->"$?n crlf)
)
