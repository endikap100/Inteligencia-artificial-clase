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

(deftemplate nivelMAXMIN
	(slot id)
	(slot idAnterior)
	(multislot tablero)
	(slot color)
	(slot nivel)
	(slot hijos)
	(slot heuristico)
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

(deffunction colorLetra (?a)
	(if (= 0 (str-compare ?a "Blanca"))
		then
			(return B)
		else
			(if (= 0 (str-compare ?a "Negra"))
				then
					(return N)
				else
					(return FALSE)
			)

	)
)

(deffunction HeuristicoTabla (?color $?tablero)
	(bind ?heuristico 0)
	(progn$ (?ficha $?tablero)
		(if (eq ?ficha ?color)
			then
				(bind ?heuristico (+ 1 ?heuristico))
			else
				(if (eq ?ficha (colorContrario ?color))
					then
						(bind ?heuristico (- ?heuristico 1))
				)
		)
	)
	(return ?heuristico)
)

(deffunction insertarFicha (?x ?y ?color $?tableroOriginal)
	(bind $?tablero $?tableroOriginal)
	(if (not (eq (getDeTablero ?x ?y $?tablero) 0))
		then
			(return FALSE)
		else
			;derecha x++
			;(printout t "derecha" crlf)
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
								;(printout t ?posx " " ?y crlf)
								(bind $?tablero (insertEnTablero ?posx ?y ?color $?tablero))
							)
					)
			)
			;izquierda x--
			;(printout t "izquierda" crlf)
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
								;(printout t ?posx " " ?y crlf)
								(bind $?tablero (insertEnTablero ?posx ?y ?color $?tablero))
							)
					)
			)
			;arriba y++
			;(printout t "arriba" crlf)
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
								;(printout t ?x " " ?posy crlf)
								(bind $?tablero (insertEnTablero ?x ?posy ?color $?tablero))
							)
					)
			)
			;abajo y--
			;(printout t "abajo" crlf)
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
								;(printout t ?x " " ?posy crlf)
								(bind $?tablero (insertEnTablero ?x ?posy ?color $?tablero))
							)
					)
			)
			;horizontal abajo derecha y++ x++
			;(printout t "abajo derecha" crlf)
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
								;(printout t ?posx " " ?posy crlf)
								(bind $?tablero (insertEnTablero ?posx ?posy ?color $?tablero))
							)
					)
			)
			;horizontal abajo izquierda y++ x--
			;(printout t "abajo izquierda" crlf)
			(if (and (>= ?x 1)(<= ?y 8)(eq (getDeTablero (- ?x 1) (+ ?y 1) $?tablero) (colorContrario ?color)))
				then
					(bind ?posx (- ?x 2))
					(bind ?posy (+ ?y 2))
					(while (and (>= ?posx 0)(<= ?posy 9)(eq (getDeTablero ?posx ?posy $?tablero) (colorContrario ?color)))
						(bind ?posx (- ?posx 1))
						(bind ?posy (+ 1 ?posy))
					)
					(if (eq (getDeTablero ?posx ?posy $?tablero) ?color)
						then
							;recorrido inverso cambiando color
							(while (not(= ?posx ?x ))
								(bind ?posx (+ ?posx 1))
								(bind ?posy (- ?posy 1))
								;(printout t ?posx " " ?posy crlf)
								(bind $?tablero (insertEnTablero ?posx ?posy ?color $?tablero))
							)
					)
			)
			;horizontal arriba derecha y-- x++
			;(printout t "arriba derecha" crlf)
			(if (and (<= ?x 8)(>= ?y 1)(eq (getDeTablero (+ ?x 1) (- ?y 1) $?tablero) (colorContrario ?color)))
				then
					(bind ?posx (+ ?x 2))
					(bind ?posy (- ?y 2))
					(while (and (<= ?posx 9)(>= ?posy 0)(eq (getDeTablero ?posx ?posy $?tablero) (colorContrario ?color)))
						(bind ?posx (+ ?posx 1))
						(bind ?posy (- 1 ?posy))
					)
					(if (eq (getDeTablero ?posx ?posy $?tablero) ?color)
						then
							;recorrido inverso cambiando color
							(while (not(= ?posx ?x ))
								(bind ?posx (- ?posx 1))
								(bind ?posy (+ ?posy 1))
								;(printout t ?posx " " ?posy crlf)
								(bind $?tablero (insertEnTablero ?posx ?posy ?color $?tablero))
							)
					)
			)
			;horizontal arriba izquierda y-- x--
			;(printout t "arriba izquierda" crlf)
			(if (and (>= ?x 1)(>= ?y 1)(eq (getDeTablero (- ?x 1) (- ?y 1) $?tablero) (colorContrario ?color)))
				then
					(bind ?posx (- ?x 2))
					(bind ?posy (- ?y 2))
					(while (and (>= ?posx 0)(>= ?posy 0)(eq (getDeTablero ?posx ?posy $?tablero) (colorContrario ?color)))
						(bind ?posx (- ?posx 1))
						(bind ?posy (- 1 ?posy))
					)
					(if (eq (getDeTablero ?posx ?posy $?tablero) ?color)
						then
							;recorrido inverso cambiando color
							(while (not(= ?posx ?x ))
								(bind ?posx (+ ?posx 1))
								(bind ?posy (+ ?posy 1))
								;(printout t ?posx " " ?posy crlf)
								(bind $?tablero (insertEnTablero ?posx ?posy ?color $?tablero))
							)
					)
			)
			(if (eq $?tableroOriginal $?tablero)
				then
					(return FALSE)
				else
					(return $?tablero)
			)
	)
)


(defrule iniciar
	(declare (salience 1000))
  (tablero $?tablero)
  =>
  (imprimirTablero $?tablero)
)

(defrule elegirTurno
  (declare (salience 100))
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
	(bind ?insertado FALSE)
	(while (eq ?insertado FALSE)
		(printout t "Cual es columna?" crlf)
		(bind ?x (leerInteger))
		(printout t "Cual es fila?" crlf)
		(bind ?y (leerInteger))
		(if (= 0 (str-compare "Negra" ?colorJugador))
			then
				(bind $?tableroNuevo (insertarFicha ?x ?y N $?tablero))
				(bind ?turno "Blanca")
			else
				(bind $?tableroNuevo (insertarFicha ?x ?y B $?tablero))
				(bind ?turno  "Negra")
		)
		(if (eq $?tableroNuevo FALSE)
			then
				(printout t "No es valido, esfuerzate un poco mas XD" crlf)
			else
				(assert (tablero $?tableroNuevo))
				(assert (turno ?turno))
				(bind ?insertado TRUE)
		)
	)

	(assert (fichasJugador (- ?nf 1)))
	(retract ?f)
  (retract ?a)
  (retract ?t)
)

(defrule turnoMaquina
  (fichaJugador ?colorJugador)
  ?t <- (turno ?turno)
  ?a <- (tablero $?tablero)
  (test (not(= 0 (str-compare ?colorJugador ?turno))))
	?f <- (fichasMaquina ?nf)
  =>
	;(printout t "no hace ni mierdas")
	(assert (nivelMAXMIN (id 1) (idAnterior 0)(tablero $?tablero)(color (colorContrario (colorLetra ?colorJugador))) (nivel 1)(hijos FALSE)(heuristico (HeuristicoTabla (colorContrario (colorLetra ?colorJugador)) $?tablero))))
	(assert (maxminidincremental 1))

	(assert (fichasJugador (- ?nf 1)))
	(retract ?f)
	(assert (nivelComp 20))
)

(defrule MAXMINGenArbol
	?maxmin <- (nivelMAXMIN (id ?id) (idAnterior ?idAnterior)(tablero $?tablero) (color ?color) (nivel ?nivel)(hijos FALSE)(heuristico ?heuristico))
	?ido <- (maxminidincremental ?idsiguiente)
	(test (< ?nivel 20))
	(fichaJugador ?colorJugador)
	=>
	(loop-for-count (?y 1 8) do
    (loop-for-count (?x 1 8) do
			(bind ?insertado (insertarFicha ?x ?y ?color $?tablero))
			(if (not (eq ?insertado FALSE))
				then
					(bind ?idsiguiente (+ 1 ?idsiguiente))
					(assert (nivelMAXMIN (id ?idsiguiente) (idAnterior ?id)(tablero ?insertado)(color (colorContrario ?color))(nivel (+ 1 ?nivel))(hijos FALSE)(heuristico (HeuristicoTabla (colorContrario (colorLetra ?colorJugador)) $?tablero))))
			)
		)
	)
	(assert (nivelMAXMIN (id ?id) (idAnterior ?idAnterior)(tablero $?tablero) (color ?color) (nivel ?nivel)(hijos TRUE)(heuristico ?heuristico)))
	(assert (maxminidincremental ?idsiguiente))
	(retract ?maxmin)
	(retract ?ido)
)

(defrule discriminacionPositivaNegativa
	?maxmin1 <- (nivelMAXMIN (id ?id) (idAnterior ?idAnterior)(tablero $?tablero1) (color ?color) (nivel ?nivel)(heuristico ?heuristico1))
	?maxmin2 <- (nivelMAXMIN (id ~ ?id) (idAnterior ?idAnterior)(tablero $?tablero2) (color ?color) (nivel ?nivel)(heuristico ?heuristico2))
	(nivelComp ?nivelComp)
	(test (= ?nivelComp ?nivel) )
	=>
	(if (= 0 (mod ?nivel 2))
		then ;discriminacionnegativa
			(if (< ?heuristico1 ?heuristico2)
				then
					(retract ?maxmin1)
				else
					(retract ?maxmin2)
			)
		else ;discriminacionpositiva
			(if (> ?heuristico1 ?heuristico2)
				then
					(retract ?maxmin1)
				else
					(retract ?maxmin2)
			)
	)
)
