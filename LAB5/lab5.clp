;granjero, lechuga, cabra, puma
(defglobal ?*ESTADOINICIAL* = (create$ "A1111B0000"))
(defglobal ?*LISTA* = ?*ESTADOINICIAL*)
(defglobal ?*VISTOS* = ?*ESTADOINICIAL*)
(defglobal ?*CAMINO* = ?*ESTADOINICIAL*)

(deffunction ladogranjero (?a)
  (if (= 0 (str-compare "1" (sub-string 2 2 ?a)))
    then
      (return 1)
    else
      (return 2)
  )
)

(deffunction ladolechuga (?a)
  (if (= 0 (str-compare "1" (sub-string 3 3 ?a)))
    then
      (return 1)
    else
      (return 2)
  )
)
(deffunction ladocabra (?a)
  (if (= 0 (str-compare "1" (sub-string 4 4 ?a)))
    then
      (return 1)
    else
      (return 2)
  )
)
(deffunction ladopuma (?a)
  (if (= 0 (str-compare "1" (sub-string 5 5 ?a)))
    then
      (return 1)
    else
      (return 2)
  )
)


(deffunction hijos (?a)
  (bind $?posibles (create$))
  (if (= 1 (ladogranjero ?a))
    then
      (bind ?movgranjero (str-cat (sub-string 1 1 ?a) "0" (sub-string 3 6 ?a) "1" (sub-string 8 10 ?a)))
      (if (= 1 (ladolechuga ?a))
        then
          (bind $?posibles (insert$ $?posibles 1 (str-cat (sub-string 1 2 ?movgranjero) "0" (sub-string 4 7 ?movgranjero) "1" (sub-string 9 10 ?movgranjero))))
      )
      (if (= 1 (ladocabra ?a))
        then
          (bind $?posibles (insert$ $?posibles 1 (str-cat (sub-string 1 3 ?movgranjero) "0" (sub-string 5 8 ?movgranjero) "1" (sub-string 10 10 ?movgranjero))))
      )
      (if (= 1 (ladopuma ?a))
        then
          (bind $?posibles (insert$ $?posibles 1 (str-cat (sub-string 1 4 ?movgranjero) "0" (sub-string 6 9 ?movgranjero) "1")))
      )
    else
      (bind ?movgranjero (str-cat (sub-string 1 1 ?a) "1" (sub-string 3 6 ?a) "0" (sub-string 8 10 ?a)))
      (bind $?posibles (insert$ $?posibles 1 ?movgranjero))
      (if (= 2 (ladolechuga ?a))
        then
          (bind $?posibles (insert$ $?posibles 1 (str-cat (sub-string 1 2 ?movgranjero) "1" (sub-string 4 7 ?movgranjero) "0" (sub-string 9 10 ?movgranjero))))
      )
      (if (= 2 (ladocabra ?a))
        then
          (bind $?posibles (insert$ $?posibles 1 (str-cat (sub-string 1 3 ?movgranjero) "1" (sub-string 5 8 ?movgranjero) "0" (sub-string 10 10 ?movgranjero))))
      )
      (if (= 2 (ladopuma ?a))
        then
          (bind $?posibles (insert$ $?posibles 1 (str-cat (sub-string 1 4 ?movgranjero) "1" (sub-string 6 9 ?movgranjero) "0")))
      )
  )
  (return $?posibles)
)

(deffunction hijos_posibles (?a)
  (bind $?hijos (hijos ?a))
  (bind $?posibles (create$))
  (progn$ (?e $?hijos)
    (if (not (and (= (ladopuma ?e) (ladocabra ?e)) (not (= (ladopuma ?e) (ladogranjero ?e)))))
      then
        ;(bind $?posibles (insert$ $?posibles 1 ?e))
        (if (not (and (= (ladolechuga ?e) (ladocabra ?e)) (not (= (ladolechuga ?e) (ladogranjero ?e)))))
          then
            (bind $?posibles (insert$ $?posibles 1 ?e))
        )
    )
    ;(if (not (and (= (ladolechuga ?e) (ladocabra ?e)) (not (= (ladolechuga ?e) (ladogranjero ?e)))))
      ;then
        ;(bind $?posibles (insert$ $?posibles 1 ?e))
    ;)
  )
  (return $?posibles)
)


(deffunction main ()
  (while (not (= 0 (length$ ?*LISTA*)))
    (bind ?first (nth$ 1 ?*LISTA*))
    ;add camino
    (bind ?caminoActual (nth$ 1 ?*CAMINO*))
    (bind ?*CAMINO* (rest$ ?*CAMINO*))

    (if (= 0 (str-compare ?first "A0000B1111"))
      then
        (return ?caminoActual)
    )
    (bind ?*LISTA* (rest$ ?*LISTA*))
    (bind $?hi (hijos_posibles ?first))

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
