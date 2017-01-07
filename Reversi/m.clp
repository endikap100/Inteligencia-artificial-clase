;se define una variable gobal para facilitar el cambio de la catidad de niveles
(defglobal ?*NIVELES* = 3)
;
;Deffacts para crear los hechos iniciales y estos den paso a las primeras reglas y empiece el juego.

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
;Plantilla del fact con el que se calcula maxmin
(deftemplate nivelMAXMIN
	(slot id)
	(slot idAnterior)
	(multislot tablero)
	(slot color)
	(slot nivel)
	(slot hijos)
	(slot heuristico)
)
;Funcioón para leer del teclado y comprobar que lo introducido es un Integer
(deffunction leerInteger ()
  (bind ?i (read))
  (while (and (not(integerp ?i)) (<= ?i 8))
    (printout t "No es un numero, introduzca un numero" crlf)
    (bind ?i (read))
  )
  (return ?i)
)
;Funcion para coger una ficha del tablero dandole la fila, columna y tablero.
(deffunction getDeTablero (?x ?y $?tablero)
	(if (or (< ?x 1)(< ?y 1)(> ?x 8)(> ?y 8))
		then
			(return FALSE)
		else
			(return (nth$ (+(*(- ?y 1) 8) ?x) $?tablero ))
	)
)

;Funcioón para insertar una ficha del color indicado en ?ficha en las posiciones dadas previamente en el ?tablero
(deffunction insertEnTablero (?x ?y ?ficha $?tablero)
  (return (replace$ $?tablero (+(*(- ?y 1) 8) ?x)(+(*(- ?y 1) 8) ?x) ?ficha ))
)
;Cogiendo un tablero como elemento lo imprime en la pantalla de forma que se pueda jugar al reversi
(deffunction imprimirTablero ($?tablero)
	(printout t crlf "Tablero:" crlf crlf)
  (loop-for-count (?y 1 8) do
    (loop-for-count (?x 1 8) do
      (printout t " "(getDeTablero ?x ?y $?tablero)" |" )
    )
    (printout t crlf "-------------------------------" crlf)
  )
	(printout t crlf)
	(printout t crlf $?tablero crlf)
  ;(return)
)
;Devuelve la inicial del color contrario pasado en ?a
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
;?a sienso "Blanca" o "Negra", devuelve su inicial
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
;Función que calcula el heuristico
;Dando un color y un tablero calcula el numero de fichas de ese color y le resta las del color contrario.
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

;Devuelve un tablero modificado, añadiendo la ficha en las posiciones ?y ?x en el ?tableroOriginal
(deffunction insertarFicha (?x ?y ?color $?tableroOriginal)
	(bind $?tablero $?tableroOriginal)

	(if (not (eq (getDeTablero ?x ?y $?tablero) 0)) ;Primero comprueba que en las coordenadas hay un espacio en blanco
		then
			(return FALSE)
		else	;En caso de que el espacio este vacio, la función mirara las 8 posiciones que rodean ?x ?y
			;para comprobar si es posible colocar la ficha, y en caso de que lo sea y se requiera, cambiar las fichas para poder ejecutar la jugada.
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
						(bind ?posy (- ?posy 1))
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
						(bind ?posy (- ?posy 1))
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
;Funcion que comprueba que el ?color puede jugar
(deffunction puedeMeter (?color $?tablero)
	(loop-for-count (?y 1 8) do
		(loop-for-count (?x 1 8) do
			(bind ?insertado (insertarFicha ?x ?y (colorLetra ?color) $?tablero))
			(if (not (eq ?insertado FALSE))
				then
					(return TRUE)
			)
		)
	)
	(return FALSE)
)

;Regla inicial que inicializa el juego
(defrule iniciar
	(declare (salience 10000))
  (tablero $?tablero)
  =>
  (imprimirTablero $?tablero)
)
;Funcion que se usa al inicio de la ejecución y elige el color de los jugadores
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
;Regla que define el turno del jugador humano
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

;Regla que establece el turno de la maquina
(defrule turnoMaquina
  (fichaJugador ?colorJugador)
  ?a <- (tablero $?tablero)
	?t <- (turno ?turno)
  (test (not(= 0 (str-compare ?colorJugador ?turno))))
	?f <- (fichasMaquina ?nf)
  =>

	(assert (nivelMAXMIN (id 1) (idAnterior 0)(tablero $?tablero)(color (colorContrario (colorLetra ?colorJugador))) (nivel 1)(hijos FALSE)(heuristico (HeuristicoTabla (colorContrario (colorLetra ?colorJugador)) $?tablero))))
	(assert (maxminidincremental 1))

	(assert (fichasMaquina (- ?nf 1)))
	(retract ?f)
	(assert (nivelComp ?*NIVELES*)) ; En este apartado se puede elegir la profundidad del arbol
)
;Regla con la que se genera el arbol maxmin
;Teniendo un fact nivelMAXMIN crea sus hijos (Jugadas posibles)
(defrule MAXMINGenArbol
	(declare (salience 4))
	?maxmin <- (nivelMAXMIN (id ?id) (idAnterior ?idAnterior)(tablero $?tablero) (color ?color) (nivel ?nivel)(hijos FALSE)(heuristico ?heuristico))
	?ido <- (maxminidincremental ?idsiguiente)
	(test (< ?nivel ?*NIVELES*)) ; En este apartado se puede elegir la profundidad del arbol
	(fichaJugador ?colorJugador)
	?t <- (turno ?turno)
  (test (not(= 0 (str-compare ?colorJugador ?turno))))
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

;Regla que se ejecuta cuando el arbol esta creado y elige el minimo o el maximo dependiendo de el nivel de los facts
(defrule discriminacionPositivaNegativa
	(declare (salience 3))
	?maxmin1 <- (nivelMAXMIN (id ?id) (idAnterior ?idAnterior)(tablero $?tablero1) (color ?color) (nivel ?nivel)(hijos ?hijos1)(heuristico ?heuristico1))
	?maxmin2 <- (nivelMAXMIN (id ~ ?id) (idAnterior ?idAnterior)(tablero $?tablero2) (color ?color) (nivel ?nivel)(hijos ?hijos2)(heuristico ?heuristico2))
	(nivelComp ?nivelComp)
	(test (= ?nivelComp ?nivel) )
	(fichaJugador ?colorJugador)
	?t <- (turno ?turno)
  (test (not(= 0 (str-compare ?colorJugador ?turno))))
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

;Una vez terminado de discriminar los facts de un nivel se sube de nivel para ir acotando la jugada que se busca
(defrule subirHeuristicoUnNivel
	(declare (salience 2))
	?maxminPadre <- (nivelMAXMIN (id ?id) (idAnterior ?idAnterior1)(tablero $?tablero1) (color ?color1) (nivel ?nivelPadre)(hijos ?hijos1)(heuristico ?heuristico1))
	?maxminHijo <- (nivelMAXMIN (id ~ ?id & ?idAnterior1) (idAnterior ?idAnterior2)(tablero $?tablero2) (color ?color2) (nivel ?nivelHijo)(hijos ?hijos2)(heuristico ?heuristico2 & ~?heuristico1))
	?nivel <- (nivelComp ?nivelHijo)
	(test (= ?nivelHijo (+ ?nivelPadre 1)))
	(fichaJugador ?colorJugador)
	?t <- (turno ?turno)
  (test (not(= 0 (str-compare ?colorJugador ?turno))))
	=>
	(retract ?maxminPadre)
	(assert (nivelMAXMIN (id ?id) (idAnterior ?idAnterior1)(tablero $?tablero1) (color ?color1) (nivel ?nivelPadre)(hijos ?hijos1)(heuristico ?heuristico2)))
	(printout t "subirHeu: " ?id crlf)
)

(defrule subirNivel
	(declare (salience 1))
	?nivel <- (nivelComp ?nivelHijo)
	(test (not (= 1 ?nivelHijo)))
	(fichaJugador ?colorJugador)
	?t <- (turno ?turno)
  (test (not(= 0 (str-compare ?colorJugador ?turno))))
	=>
	(retract ?nivel)
	(assert (nivelComp (- ?nivelHijo 1)))
	(printout t ?nivelHijo)
)
;Aplica la jugada indicada
(defrule aplicarJugada
	(declare (salience 5))
	?nivel <- (nivelComp 1)
	?t <- (turno ?turno)
  ?a <- (tablero $?tablero)
	(fichaJugador ?colorJugador)
  (test (not(= 0 (str-compare ?colorJugador ?turno))))
	?maxmin <- (nivelMAXMIN (id ?id) (idAnterior ?idAnterior)(tablero $?tablero1) (color ?color) (nivel 2)(heuristico ?heuristico1))
	=>
	(assert (turno ?colorJugador))
	(assert (tablero $?tablero1))
	(retract ?t)
	(retract ?a)
	(retract ?nivel)
	(assert (borrar TRUE))
)
;Regla que borra todos los facts restantes del arbol maxmin una vez hecha la jugada
(defrule borrarBasuramaxmin
	(declare (salience 10000))
	?maxmin <- (nivelMAXMIN (id ?id) )
	(borrar TRUE)
	=>
	(retract ?maxmin)
)
;Regla que borra todos los facts restantes del arbol maxmin una vez hecha la jugada
(defrule borrarBasuramaxminMaxminidincremental
	(declare (salience 9999))
	?maxmin <- (maxminidincremental ?i)
	?b <- (borrar TRUE)
	=>
	(retract ?maxmin)
	(retract ?b)
)
;Regla que comprueba si el jugador que tiene el turno puede jugar
;En caso de que ninguno de los dos pueda, se termina la partida.
(defrule comprobarSiPuedeJugar
	(declare (salience 10000))
	?t <- (turno ?turno)
	(tablero $?tablero)
	=>
	(if (eq FALSE (puedeMeter ?turno $?tablero))
		then
			(if (= 0 (str-compare "Negra" ?turno))
				then
					(bind ?turno "Blanca")
				else
					(bind ?turno  "Negra")
			)
			(retract ?t)
			(assert (turno ?turno))
			(if (eq FALSE (puedeMeter ?turno $?tablero))
				then
					(assert (finalDeLaPartida TRUE))
			)
	)
)
;Regla que comprueba que el numero de fichas es superior a 0 en caso contrario se termina el juego
(defrule sinFichas
	(declare (salience 10000))
	(fichasMaquina 0)
	(fichasJugador 0)
	=>
	(assert (finalDeLaPartida TRUE))
)
;Regla que define el final del juego.
;Solo se ejecutara si los jugadores estan sin fichas o ninguno puede mover
(defrule finalDeLaPartida
	(declare (salience 10000))
	(finalDeLaPartida TRUE)
	(tablero $?tablero)
	(fichaJugador ?color)
	=>
	(if (< 0 (HeuristicoTabla (colorLetra ?color) $?tablero))
		then
			(printout t crlf "El jugador gana!")
		else
			(printout t crlf "La maquina gana!")
	)
	(halt)
)
