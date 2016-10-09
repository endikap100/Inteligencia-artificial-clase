(defglobal ?*ESTADOINICIAL* = (create$ "H1SAH2S "))
(defglobal ?*LISTA* = (create$ "H1SAH2S "))
(defglobal ?*VISTOS* = (create$ "H1SAH2S "))
(defglobal ?*PASOS-LIMITE* = 100)
(defglobal ?*PASOS* = 0)

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

)
