(import foreign)

(define-external foreign_var int)
(foreign-declare "int foreign_function(int);")

(let ((ret ((foreign-lambda int foreign_function int) foreign_var)))
  (print ", ret: " ret))
