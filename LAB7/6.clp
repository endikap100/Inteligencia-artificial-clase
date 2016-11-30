(deffacts hechos
	(hecho1 1 2 6 3 9))

(defrule ordenar
  (declare (salience 50))
  ?a <- (hecho1 $?b ?x $?c ?y $?d)
	(test (> ?x ?y))
=>
	(retract ?a)
	(assert (hecho1 (create$ $?b ?y $?c ?x $?d)))

)

(defrule Print
  (declare (salience 0))
	(hecho1 $?n)
=>
  (printout t "->"$?n crlf)
)
