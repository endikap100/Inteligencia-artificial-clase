;1 dentroDelRango
(deffunction leerInteger ()
  (printout t "Introduce un numero" crlf)
  (bind ?i (read))
  (while (not(integerp ?i))
    (printout t "No es un numero, introduzca un numero" crlf)
    (bind ?i (read))
  )
  (return ?i)
)

(deffunction dentroDelRango (?a ?b)
  (bind ?i (leerInteger))
  (while (or (> ?a ?i) (< ?b ?i))
    (printout t "El numero no es valido" crlf)
    (bind ?i (leerInteger))
  )
  (return ?i)
)

;2 acertijo
(deffunction acertijo (?a ?b)
  (bind ?numAcertar (random ?a ?b))
  (bind ?i (leerInteger))
  (while (not(= ?numAcertar ?i))
    (printout t "Sigue jugando" crlf)
    (bind ?i (leerInteger))
  )
  (printout t "Has acertado" crlf)
  (return ?i)
)

;3 mcd
(deffunction mcd (?a ?b)
  (if (= ?a ?b)
    then
      (return ?a)
    else
      (if (> ?a ?b)
        then
          (mcd (- ?a ?b) ?b)
        else
          (mcd ?a (- ?b ?a))
      )
  )
)

;4 mcm
(deffunction mcm (?a ?b)
  (printout t (integer(/(* ?a ?b)(mcd ?a ?b))) crlf)
)

;5 mes
(deffunction mes (?a)
  (if (or (or (or (or (or (or (= 1 ?a)(= 3 ?a))(= 5 ?a))(= 7 ?a))(= 8 ?a))(= 10 ?a))(= 12 ?a))
    then
      (printout t "31" crlf)
    else
      (if (or (or (or (= 4 ?a)(= 9 ?a))(= 11 ?a))(= 6 ?a))
        then
          (printout t "30" crlf)
        else
          (if (= 2 ?a)
            then
              (printout t "28" crlf)
            else
              (printout t "No es un numero valido" crlf)
          )
      )
  )
)

;6 diferencia
(deffunction diferencia (?a $?b)
  (bind $?r (create$ ))
  (progn$ (?e $?a)
    (if (and(not(member$ ?e $?b))(not(member$ ?e $?r)))
      then
        (bind $?r (insert$ $?r 1 ?e))
    )
  )
  (progn$ (?e $?b)
    (if (and(not(member$ ?e ?a))(not(member$ ?e $?r)))
      then
        (bind $?r (insert$ $?r 1 ?e))
    )
  )
  (printout t $?r crlf)
)

;7 concatenacion
(deffunction concatenacion (?a $?b)
  (progn$ (?e $?a)
        (bind $?b (insert$ $?b 1 ?e))
  )
  (printout t $?b crlf)
)

;8 sustituir
(deffunction sustituir (?a ?b $?c)
  (bind ?i (member$ ?a $?c))
  (while (integerp ?i); (eq ?i TRUE)
    (bind $?c (replace$ $?c  ?i ?i ?b))
    (bind ?i (member$ ?a $?c))
  )
  (return $?c)
)

;9 cartesiano
(deffunction cartesiano (?a $?b)
  (bind $?r (create$ ))
  (progn$ (?e $?a)
    (progn$ (?t $?b)
      (bind $?r (insert$ $?r (+ (length$ $?r) 1) ?e))
      (bind $?r (insert$ $?r (+ (length$ $?r) 1) ?t))
    )
  )
  (return $?r)
)

;10 escalar
(deffunction escalar (?a $?b)
  (if (= (length$ $?a) (length$ $?b))
    then
      (bind ?r 0)
      (while (< 0 (length$ $?a))
        (bind ?r (+ ?r (*(nth$ 1 $?a) (nth$ 1 $?b))))
        (bind $?a(rest$ $?a))(bind $?b(rest$ $?b))
      )
      (return ?r)
    else
      (printout t "la longitud de los multicampos no coincide" crlf)
  )
)

;11 unico
(deffunction unico ($?a)
  (bind $?r (create$))
  (progn$ (?e $?a)
    (if (or (member$ ?e $?r) (<  (length$ $?a) ?e))
      then
        (return False)
      else
        (bind $?r (insert$ $?r 1 ?e ))
    )
  )
  (return True)
)

;12.1 num_primos
(deffunction num_primos (?i)
  (if (= 2 ?i)
    then
      (return True)
  )
  (bind ?c (/ ?i 2))
  (bind ?it 2)
  (while (and (not (= 0(mod ?i ?it))) (< ?it ?c))
    (bind ?it (+ ?it 1))
  )
  (if (not (= 0(mod ?i ?it)))
    then
      (return True)
    else
      (return  False)
  )
)

;12.2 num_capicua
(deffunction num_to_multiCamp (?t)
  (bind $?num (create$))
  (while (< 0 ?t)
    (bind $?num (insert$ $?num 1 (mod ?t 10)))
    (bind ?t (integer(/ ?t 10)))
  )
  (return $?num)
)

(deffunction num_capicua (?t)
  (bind $?num (num_to_multiCamp ?t))
  (bind ?a 1)
  (bind ?b (length$ $?num))
  (while (> (/ ?b 2) (- ?a 1))
    (if  (= (nth$ ?a $?num) (nth$ (+(- ?b ?a)1) $?num))
      then
        (bind ?a (+ ?a 1))
      else
        (return False)
    )
  )
  (return True)

)

;12.3 primeros_primos_y_capicua
(deffunction primeros_primos_y_capicua (?a)
  (bind ?i 0)
  (while (< ?i ?a)
    (if (num_primos ?i)
      then (bind ?i (+ 1 ?i))
    )
  )
)
