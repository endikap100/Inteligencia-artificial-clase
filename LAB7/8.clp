(deffacts hechos
	(hecho1 a b c d e)
  (hecho1 g f c b a)
  (inter))

(defrule Separar
  (declare (salience 50))
  ?a <- (hecho1 $? ?x $?)
  ?b <- (hecho1 $? ?y $?)
  (test (= 0 (str-compare ?x ?y)))
  (test (not (eq ?a ?b)))

  ;(not (hecho $? ?y &:(= ?y ?x )$?))
=>
    (assert (hecho2 ?x))
)

(defrule Juntar
  (declare (salience 10))
	?a <-(hecho2 ?n)
  ?b <-(inter $?t)
=>
  (assert (inter (insert$ $?t 1 ?n)))
  (retract ?a)
  (retract ?b)
)

(defrule Print
  (declare (salience 0))
	(inter $?n)
=>
  (printout t "->"$?n crlf)
)
