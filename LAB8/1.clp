(deffacts hechos
	(jarras 0 0))

(defrule afsda
  (declare (salience 51))
	(initial-fact)
=>
  (set-strategy breadth)
)

(defrule Fin
  (declare (salience 50))
	(jarras 2 $?e)
=>
  (printout t "la jarra de 4 litros tiene dos litros. Camino: "(create$ 2 $?e) crlf)
  (halt)
)

(defrule hijos1
  (declare (salience 0))
  (jarras 0 ?b $?e)
=>
  (assert (jarras (create$ 4 ?b 0 ?b $?e)))
)

(defrule hijos2
  (declare (salience 0))
  (jarras ?b 0 $?e)
=>
  (assert (jarras (create$ ?b 3 ?b 0 $?e)))
)

(defrule hijos3
  (declare (salience 0))
  (jarras ?b ?a $?e)
  (test (not (= ?b 0)))
=>
  (assert (jarras (create$ 0 ?a ?b ?a $?e)))
)

(defrule hijos4
  (declare (salience 0))
  (jarras ?b ?a $?e)
  (test (not (= ?a 0)))
=>
  (assert (jarras (create$ ?b 0 ?b ?a $?e)))
)

(defrule hijos5
  (declare (salience 0))
  (jarras ?b ?a $?e)
  (test (not (= ?a 3)))
  (test (not (= ?b 0)))
=>
  (if (<= (+ ?a ?b) 3)
    then
      (assert (jarras (create$ 0 (+ ?a ?b) ?b ?a $?e)))
    else
      (assert (jarras (create$ (- (+ ?a ?b) 3) 3 ?b ?a $?e)))
  )

)

(defrule hijos6
  (declare (salience 0))
  (jarras ?b ?a $?e)
  (test (not (= ?b 4)))
  (test (not (= ?a 0)))
=>
  (if (<= (+ ?a ?b) 4)
    then
      (assert (jarras (create$ (+ ?a ?b) 0 ?b ?a $?e)))
    else
      (assert (jarras (create$ 4 (- (+ ?a ?b) 4) ?b ?a $?e)))
  )
)
