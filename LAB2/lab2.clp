;1 cuentaAtras
(deffunction cuentaAtras (?a)
  (while (> ?a 0)
    (printout t ?a crlf)
    (bind ?a (- ?a 1))
  )
  (return )
)

;2 hasta
(deffunction hasta (?a)
  (loop-for-count (?i 0 (- ?a 1))
    (printout t ?i crlf)
  )
  (return )
)
;3.1 sumatorioNormal
(deffunction sumatorioNormal (?a)
  (bind ?r 0)
  (loop-for-count (?i 0 ?a)
    (bind ?r (+ ?r ?i))
  )
  (printout t ?r crlf)
)

;3.1 sumatorioRecursivo
(deffunction sumatorioRecursivo (?a)
  (if (= ?a 1)
    then
      (return 1)
    else
      (return (+ ?a (sumatorioRecursivo (- ?a 1))))
  )
)

;4 minimoMulti
(deffunction minimoMulti ($?a)
  (bind ?min (nth$ 1 $?a))
  (bind $?a (rest$ $?a))
  (progn$ (?e $?a)
    (if(> ?min ?e)
      then
        (bind ?min ?e)
    )
  )
  (printout t ?min crlf)
)

;5 maximoMulti
(deffunction maximoMulti ($?a)
  (bind ?min (nth$ 1 $?a))
  (bind $?a (rest$ $?a))
  (progn$ (?e $?a)
    (if(< ?min ?e)
      then
        (bind ?min ?e)
    )
  )
  (printout t ?min crlf)
)

;6 sumaMulti
(deffunction sumaMulti ($?a)
  (bind ?sum 0)
  (progn$ (?e $?a)
    (bind ?sum (+ ?sum ?e))
  )
  (printout t ?sum crlf)
)

;7 mediaMulti
(deffunction mediaMulti ($?a)
  (bind ?sum 0)
  (progn$ (?e $?a)
    (bind ?sum (+ ?sum ?e))
  )
  (printout t (/ ?sum (length $?a)) crlf)
)

;8 switchin
(deffunction switchin (?i $?a)
  (if (= ?i 1)
    then
      (return (minimoMulti $?a))
    else
      (return (maximoMulti $?a))
  )
)

;9 multiplicarElemento

;10.1 factorialNormal
(deffunction factorialNormal (?a)
  (bind ?b 1)
  (while (> ?a 0)
    (bind ?b (* ?a ?b))
    (bind ?a (- ?a 1))
  )
  (printout t ?b crlf)
  (return )
)

;10.2 factorialRecursividad
(deffunction factorialRecursividad (?a)
  (if (= ?a 1)
    then
      (return 1)
    else
      (return (* ?a (factorialRecursividad (- ?a 1))))
    )
)
;11 fibonacci
(deffunction fibonacci (?a)
  (if (or (= 0 ?a) (= 1 ?a))
    then
     (return ?a)
    else
      (return (+(fibonacci (- ?a 1))(fibonacci (- ?a 2))))
  )
)
