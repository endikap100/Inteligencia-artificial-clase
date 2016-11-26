(deffacts hechos
	(hecho1 5)
  (hecho1 9))

(defrule mayor
(declare (salience 20))
	?a <-(hecho1 ?n)
  ?b <-(hecho1 ?k & ~?n)
  (test (< ?k ?n))
=>
(retract ?a)
(retract ?b)
(assert (hecho1 ?n))
)

(defrule mayor
(declare (salience 20))
	?a <-(hecho1 ?n)
  ?b <-(hecho1 ?k & ~?n)
  (test (>= ?k ?n))
=>
(retract ?a)
(retract ?b)
(assert (hecho1 ?k))
)

(defrule Print
  (declare (salience 0))
	(hecho1 ?n)
=>
  (printout t "el mas grande es: "?n crlf)
)
