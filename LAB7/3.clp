(deffacts hechos
	(hecho1 5 9 4 7 ))

(defrule mayor
(declare (salience 20))
	?a <-(hecho2 ?n)
  ?b <-(hecho2 ?k & ~?n)
  (test (< ?k ?n))
=>
(retract ?a)
(retract ?b)
(assert (hecho2 ?n))
)

(defrule mayor
(declare (salience 20))
	?a <-(hecho2 ?n)
  ?b <-(hecho2 ?k & ~?n)
  (test (>= ?k ?n))
=>
(retract ?a)
(retract ?b)
(assert (hecho2 ?k))
)

(defrule Print
  (declare (salience 0))
	(hecho2 ?n)
=>
  (printout t "el mas grande es: "?n crlf)
)

(defrule Separar
  (declare (salience 50))
	(hecho1 $?n)
=>
  (progn$ (?i $?n)
    (assert (hecho2 ?i))
  )
)
