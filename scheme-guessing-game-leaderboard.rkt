(#%require (lib "27.ss" "srfi"))
(random-source-randomize! default-random-source)

(define results '()) ; list of (userName & guessCount) pairs


(define (promptOptions)
  (display "Enter q to quit or any other key to continue: ")
  (define userInput (read-char))
  (read-char) ; consumes new line left from pressing enter
  (if (char=? userInput #\q)
      (begin
        (display "Goodbye!")
        (print-results))
      (begin
        (playGuess)
        (read-char)
        (promptOptions)))) ; ask again after game ends


(define (getName)
  (display "Please enter your name: ")
  (let ((userName (read))) ; read 
    (display (string-append "Good Game, " (symbol->string userName) "! "))
    userName)) ; return name


(define (playGuess)
  (define guessCount 0)
  (define randNum (+ 1 (random-integer 100))) ; new number every round

  (define (getGuess)
    (display "Guess a number from 1 to 100: ")
    (let ((userNum (read)))
      (set! guessCount (+ guessCount 1))
      (cond
        ((= userNum randNum)
         (let ((userName (getName)))
           (newline)
           (display (string-append "Correct! " (number->string guessCount) " guesses... "))
           (set! results (cons (cons userName guessCount) results))))
        ((< userNum randNum)
         (display "Go Higher...")
         (getGuess))
        ((> userNum randNum)
         (display "Go Lower...")
         (getGuess)))))

  (getGuess)) ; begin the game


(define (print-results)
  (display " Game Results: ")
  (for-each
   (lambda (pair)
     (newline)
     (display (string-append (symbol->string (car pair))
                               " took "
                               (number->string (cdr pair))
                               " guesses.")))
   (reverse results)))


(promptOptions) 
