(deffacts hechos
	(tablero  0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 B N 0 0 0
            0 0 0 N B 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0
            0 0 0 0 0 0 0 0)
  (fichasMaquina 32)
  (fichasJugador 32)
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
	(if (or (< ?x 1)(< ?y 1)(> ?x 8)(> ?y 8))
		then
			(return FALSE)
		else
			(return (nth$ (+(*(- ?y 1) 8) ?x) $?tablero ))
	)
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

(deffunction colorContrario (?a)
	(if (eq ?a N)
		then
			(return B)
		else
			(if (eq ?a B)
				then
					(return N)
				else
					(return FALSE)
			)

	)
)

(deffunction insertarFicha (?x ?y ?color $?tablero)
	(if (not (eq (getDeTablero ?x ?y $?tablero) 0))
		then
			(return FALSE)
		else
			;derecha x++
			(printout t "derecha" crlf)
			(if (and (<= ?x 8)(eq (getDeTablero (+ ?x 1) ?y $?tablero) (colorContrario ?color)))
				then
					(bind ?posx (+ 2 ?x))
					(while (and (<= ?posx 9)(eq (getDeTablero ?posx ?y $?tablero) (colorContrario ?color)))
						(bind ?posx (+ 1 ?posx))
					)
					(if (eq (getDeTablero ?posx ?y $?tablero) ?color)
						then
							;recorrido inverso cambiando color
							(while (not(= ?posx ?x ))
								(bind ?posx (- ?posx 1))
								(printout t ?posx " " ?y crlf)
								(bind $?tablero (insertEnTablero ?posx ?y ?color $?tablero))
							)
					)
			)
			;izquierda x--
			(printout t "izquierda" crlf)
			(if (and (>= ?x 1)(eq (getDeTablero (- ?x 1) ?y $?tablero) (colorContrario ?color)))
				then
					(bind ?posx (- ?x 2))
					(while (and (>= ?posx 1)(eq (getDeTablero ?posx ?y $?tablero) (colorContrario ?color)))
						(bind ?posx (- ?posx 1))
					)
					(if (eq (getDeTablero ?posx ?y $?tablero) ?color)
						then
							;recorrido inverso cambiando color
							(while (not(= ?posx ?x ))
								(bind ?posx (+ ?posx 1))
								(printout t ?posx " " ?y crlf)
								(bind $?tablero (insertEnTablero ?posx ?y ?color $?tablero))
							)
					)
			)
			;arriba y++
			(printout t "arriba" crlf)
			(if (and (<= ?y 8)(eq (getDeTablero ?x (+ ?y 1) $?tablero) (colorContrario ?color)))
				then
					(bind ?posy (+ 2 ?y))
					(while (and (<= ?posy 9)(eq (getDeTablero ?x ?posy $?tablero) (colorContrario ?color)))
						(bind ?posy (+ 1 ?posy))
					)
					(if (eq (getDeTablero ?x ?posy $?tablero) ?color)
						then
							;recorrido inverso cambiando color
							(while (not(= ?posy ?y ))
								(bind ?posy (- ?posy 1))
								(printout t ?x " " ?posy crlf)
								(bind $?tablero (insertEnTablero ?x ?posy ?color $?tablero))
							)
					)
			)
			;abajo y--
			(printout t "abajo" crlf)
			(if (and (>= ?y 1)(eq (getDeTablero ?x (- ?y 1) $?tablero) (colorContrario ?color)))
				then
					(bind ?posy (- ?y 2))
					(while (and (>= ?posy 1)(eq (getDeTablero ?x ?posy $?tablero) (colorContrario ?color)))
						(bind ?posy (- ?posy 1))
					)
					(if (eq (getDeTablero ?x ?posy $?tablero) ?color)
						then
							;recorrido inverso cambiando color
							(while (not(= ?posy ?y ))
								(bind ?posy (+ ?posy 1))
								(printout t ?x " " ?posy crlf)
								(bind $?tablero (insertEnTablero ?x ?posy ?color $?tablero))
							)
					)
			)
			;horizontal arri derecha y++ x++
			(printout t "arriba derecha" crlf)
			(if (and (<= ?x 8)(<= ?y 8)(eq (getDeTablero (+ ?x 1) (+ ?y 1) $?tablero) (colorContrario ?color)))
				then
					(bind ?posx (+ 2 ?x))
					(bind ?posy (+ 2 ?y))
					(while (and (<= ?posx 9)(<= ?posy 9)(eq (getDeTablero ?posx ?posy $?tablero) (colorContrario ?color)))
						(bind ?posx (+ 1 ?posx))
						(bind ?posy (+ 1 ?posy))
					)
					(if (eq (getDeTablero ?posx ?posy $?tablero) ?color)
						then
							;recorrido inverso cambiando color
							(while (not(= ?posx ?x ))
								(bind ?posx (- ?posx 1))
								(bind ?posy (- ?posy 1))
								(printout t ?posx " " ?posy crlf)
								(bind $?tablero (insertEnTablero ?posx ?posy ?color $?tablero))
							)
					)
			)
			;horizontal arri iz y++ x--
			;horizontal aba derecha y-- x++
			;horizontal aba iz y-- x--


			(return $?tablero)
	)

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
	?f <- (fichasJugador ?nf)
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
	(assert (fichasJugador (- ?nf 1)))
	(retract ?f)
  (retract ?a)
  (retract ?t)
)
