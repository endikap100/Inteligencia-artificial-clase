;cada estado esta compuesto por las dos habitaciones "H1" y "H2",
;despues de cada uno de estos se representa si esta habitación esta sucia o limpia con "S" y " " respectivamente
;a continuación se representa la ubicación de la aspiradora con una "A"
;esta todo unido en un STRING
;ejemplo "H1SAH2S ":
;habitación 1 sucia y contiene la aspiradora
;habitacion 2 sucia y no contiene aspiradora

(defglobal ?*ESTADOINICIAL* = (create$ "H1SAH2S "))
(defglobal ?*LISTA* = ?*ESTADOINICIAL*)
(defglobal ?*VISTOS* = ?*ESTADOINICIAL*)
(defglobal ?*CAMINO* = ?*ESTADOINICIAL*)

(deffunction get-aspiradora (?a)
  (bind ?pos (str-index "A" ?a))
  (if (= ?pos 4)
    then
      (return 1)
    else
      (return 2)
  )
)

(deffunction extrae-sucia (?a ?b)
  (if (= ?a 1)
    then
      (if (= 0 (str-compare (sub-string 3 3 ?b) "S"))
        then
          (return "sucia")
        else
          (return "limpia")
      )
    else
      (if (= 0 (str-compare (sub-string 7 7 ?b) "S"))
        then
          (return "sucia")
        else
          (return "limpia")
      )
  )
)

(deffunction aspirar (?a)
  (bind ?pos (get-aspiradora ?a))
  (if (= ?pos 1)
    then
      (return (str-cat (sub-string 1 2 ?a) " " (sub-string 4 8 ?a)))
    else
      (return (str-cat (sub-string 1 6 ?a) " " (sub-string 8 8 ?a)))
  )
)

(deffunction hijos (?a)
  (bind $?hijos (create$ ))
  ;aspirar
  (bind $?hijos (insert$ $?hijos 1 (aspirar ?a)))
  ;mover derecha
  (bind $?hijos (insert$ $?hijos 1 (str-cat (sub-string 1 3 ?a) " " (sub-string 5 7 ?a) "A")))
  ;mover izquierda
  (bind $?hijos (insert$ $?hijos 1 (str-cat (sub-string 1 3 ?a) "A" (sub-string 5 7 ?a) " ")))

  (return $?hijos)
)

(deffunction main ()
  (while (not (= 0 (length$ ?*LISTA*)))
    (bind ?first (nth$ 1 ?*LISTA*))
    ;add camino
    (bind ?caminoActual (nth$ 1 ?*CAMINO*))
    (bind ?*CAMINO* (rest$ ?*CAMINO*))

    ;(printout t ?first crlf)
    (if (or (= 0 (str-compare ?first "H1 AH2  ")) (= 0 (str-compare ?first "H1  H2 A")))
      then
        (return ?caminoActual)
    )
    (bind ?*LISTA* (rest$ ?*LISTA*))
    (bind $?hi (hijos ?first))
    (progn$ (?e $?hi)


      (if (eq FALSE (member$ ?e ?*VISTOS*))
        then
          (bind ?*LISTA* (insert$ ?*LISTA* 1 ?e))
          (bind ?*VISTOS* (insert$ ?*VISTOS* 1 ?e))
          (bind ?*CAMINO* (insert$ ?*CAMINO* 1 (str-cat ?caminoActual ", " ?e)))
      )
    )

  )
  (return FALSE)
)
