;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - modulus
;;=============================================================
;; Name: Tanush Chopra
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  int x = 17;
;;  int mod = 5;
;;  while (x >= mod) {
;;      x -= mod;
;;  }
;;  mem[ANSWER] = x;

.orig x3000

LD R0, X
LD R1, MOD

WHILE BRn END

    ;; YOUR CODE HERE
    HALT

    ;; Feel free to change the below values for debugging. We will vary these values when testing your code.
    X      .fill 17
    MOD    .fill 5     
    ANSWER .blkw 1
.end