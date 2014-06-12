(module module (main)
(import scheme chicken)

(: main (string -> number))
(define (main s)
  (print "main")
  (+ 1 (proc1 2))
)

(: proc1 (number -> number))
(define (proc1 n)
  (print n)
  n)

)
