(deffacts hechos
	(hecho1 6)
  (suma 1))

(defrule Multiplicar
  (declare (salience 30))
	?b <-(hecho1 ?n)
  ?a <-(suma ?s)
  (test (< 1 ?n))
=>
  (retract ?a)
  (retract ?b)
  (assert (hecho1 (- ?n 1)))
  (assert (suma (* ?s  ?n)))
)

(defrule Print
  (declare (salience 0))
	(suma ?n)
=>
  (printout t "->"?n crlf)
)
