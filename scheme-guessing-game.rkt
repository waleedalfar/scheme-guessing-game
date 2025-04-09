(#%require (lib "27.ss" "srfi"))
(random-source-randomize! default-random-source)

(define randNum (+ 1 (random-integer 100))) ; generate random number between 0-100 and set to variable randNum

(define (getName)
  (display "Please enter your name: ")
  (let ((userName (read))) ; read user input and store into variable userName
    (display (string-append "Good Game, " (symbol->string userName))))) ; output Good Game and 

(define (playGuess)
  (define guessCount 0) ; initialize guessCount
  
  (define (getGuess)
    (display " Guess a number from 1 to 100: ")
    (let ((userNum (read))) ; get output and set to userNum
      (set! guessCount (+ guessCount 1)) ; adds 1 to guessCount everytime a new guess is read
      (cond
        ((= userNum randNum)
         (display (string-append "Correct! " (number->string guessCount) " guesses...")) ; if correct display # of guesses it took
         (getName)) ; calls function to get and display name of winner
        ((< userNum randNum)
         (display "Go Higher...") 
        (getGuess)) ; since answer is wrong get a new guess
        ((> userNum randNum)
         (display "Go Lower...")
        (getGuess))))) ; since answer is wrong get a new guess
  (getGuess)) ; 

(playGuess) 



