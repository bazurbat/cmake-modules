(use module)
(require-library mmodule1)
; (require-library mmodule2)
; (import module1 module2)
(use module1)
(use module2)

(: a number)
(define a #f)

(print "usemodule")
(set! a (main "arg"))

(main1)
; (main2)

'(list (sublist (subsublist sstest) stest) test)
