(deffacts hechos
	(hecho1 1 2 6 3 9))

(defrule ordenar
  (declare (salience 50))
  ?a <- (hecho1 $? ?x $?)
  (not (hecho1 $? ?y &:(< ?y ?x )$?))

  ;(not (hecho $? ?y &:(= ?y ?x )$?))
=>
    (assert (hecho2 ?x))
)
