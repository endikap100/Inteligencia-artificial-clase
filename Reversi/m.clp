(deffacts hechos
	(tablero  0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 B N 0 0 0
            0 0 0 N B 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0)
  (fichasBlancas 32)
  (fichasNegras 32)
  (turno "Negra")
)

(deffunction leerInteger ()
  (bind ?i (read))
  (while (and (not(integerp ?i)) (<= ?i 8))
    (printout t "No es un numero, introduzca un numero" crlf)
    (bind ?i (read))
  )
  (return ?i)
)

(deffunction getDeTablero (?x ?y $?tablero)
  (return (nth$ (+(*(- ?y 1) 8) ?x) $?tablero ))
)

(deffunction insertEnTablero (?x ?y ?ficha $?tablero)
  (return (replace$ $?tablero (+(*(- ?y 1) 8) ?x)(+(*(- ?y 1) 8) ?x) ?ficha ))
)

(deffunction imprimirTablero ($?tablero)
  (loop-for-count (?y 1 8) do
    (loop-for-count (?x 1 8) do
      (printout t " "(getDeTablero ?x ?y $?tablero)" |" )
    )
    (printout t crlf "-------------------------------" crlf)
  )
  ;(return)
)

(defrule iniciar
  (tablero $?tablero)
  =>
  (imprimirTablero $?tablero)
)

(defrule elegirTurno
  (declare (salience 1000))
  (initial-fact)
  =>
  (bind ?lee "0")
  (while (not(or (= 0 (str-compare "Blanca" ?lee ))(= 0 (str-compare "Negra" ?lee ))))
    (printout t "Cual es el color de ficha que desea (Blanca/Negra)?" crlf)
    (bind ?lee (read))
  )
  (assert (fichaJugador ?lee))
)

(defrule turnoPersona
  (fichaJugador ?colorJugador)
  ?t <- (turno ?turno)
  ?a <- (tablero $?tablero)
  (test (= 0 (str-compare ?colorJugador ?turno)))
  =>
  (printout t "Cual es columna?" crlf)
  (bind ?x (leerInteger))
  (printout t "Cual es fila?" crlf)
  (bind ?y (leerInteger))
  (if (= 0 (str-compare "Negra" ?colorJugador))
    then
      (assert (tablero (insertEnTablero ?x ?y N $?tablero)))
      (assert (turno "Blanca"))
    else
      (assert (tablero (insertEnTablero ?x ?y B $?tablero)))
      (assert (turno "Negra"))
  )
  (retract ?a)
  (retract ?t)
)
