(deffacts hechos
	(hecho1 5))

(defrule Restar
	(hecho1 ?n)
  (test (< 0 ?n))
=>

  (printout t ?n crlf)
  (assert (hecho1 (- ?n 1)))
)
