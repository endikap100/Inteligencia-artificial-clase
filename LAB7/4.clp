(deffacts hechos
	(hecho1 5)
  (suma 0))

(defrule Sumar
  (declare (salience 30))
	?b <-(hecho1 ?n)
  ?a <-(suma ?s)
  (test (< 1 ?n))
=>
  (retract ?a)
  (retract ?b)
  (assert (hecho1 (- ?n 1)))
  (assert (suma (+ ?s (- ?n 1))))
)

(defrule Print
  (declare (salience 0))
	(suma ?n)
=>
  (printout t "->"?n crlf)
)
