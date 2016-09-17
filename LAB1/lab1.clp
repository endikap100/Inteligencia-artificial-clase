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
      ;(printout t 1 crlf)

      (if (> ?b 0)
        then (printout t 1 crlf)
      else
        (printout t 0 crlf)
      )




  )
)

;3 minimoSimple

;4 maximoSimple

;5 iguales

;6 colores

;7 cierto

;8 cierto2
