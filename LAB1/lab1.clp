;1 suma
(deffunction suma (?a ?b)
(printout t (+ ?a ?b) crlf)
)

;2 signo
(deffunction signo (?b)
  (if (< ?b 0)
    then
      (printout t -1 crlf)
    else
      (if (> ?b 0)
        then (printout t 1 crlf)
      else
        (printout t 0 crlf)
      )
  )
)

;3 minimoSimple
(deffunction minimoSimple (?a ?b)
  (if (< ?b ?a)
    then
      (printout t ?b crlf)
    else
      (printout t ?a crlf)
  )
)

;4 maximoSimple
(deffunction maximoSimple (?a ?b)
  (if (> ?b ?a)
    then
      (printout t ?b crlf)
    else
      (printout t ?a crlf)
  )
)

;5 iguales
(deffunction iguales (?a ?b)
  (if (= ?b ?a)
    then
      (printout t TRUE crlf)
    else
      (printout t FALSE crlf)
  )
)

;6 colores
(deffunction colores (?a)
  (switch ?a
    (case "verde" then
      (printout t "Puedes Pasar" crlf)
    )
    (case "rojo" then
      (printout t "No puedes cruzar" crlf)
    )
    (case "amarillo" then
      (printout t "Parate por seguridad" crlf)
    )
  )
)

;7 cierto

;8 cierto2
