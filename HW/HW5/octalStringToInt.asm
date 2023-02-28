;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - octalStringToInt
;;=============================================================
;; Name: Tanush Chopra
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String octalString = "2110";
;;  int length = 4;
;;  int value = 0;
;;  int i = 0;
;;  while (i < length) {
;;      int leftShifts = 3;
;;      while (leftShifts > 0) {
;;          value += value;
;;          leftShifts--;
;;      }
;;      int digit = octalString[i] - 48;
;;      value += digit;
;;      i++;
;;  }
;;  mem[mem[RESULTADDR]] = value;

.orig x3000

LD R0, OCTALSTRING ; os = octalString
LD R1, LENGTH      ; l = length
LD R2, RESULTADDR  ; ds = ""
AND R3, R3, 0      ; i = 0
AND R4, R4, 0
AND R5, R5, 0      ; v = 0
LD R7, ASCII

; l = -length
NOT R1, R1
ADD R1, R1, 1

WHILE1

    ADD R4, R3, R1

    BRzp END ; if i < length

    AND R4, R4, 0 ; leftShifts = 3
    ADD R4, R4, 3

    WHILE2

        BRnz ENDWHILE2 ; if leftShifts > 0
        ADD R5, R5, R5
        ADD R4, R4, -1
        BR WHILE2

    ENDWHILE2

    AND R6, R6, 0
    ADD R6, R0, R3
    LDR R6, R6, 0
    ADD R6, R6, R7
    ADD R5, R5, R6
    ADD R3, R3, 1

    BR WHILE1

END
    STI R5, RESULTADDR
    HALT
    
;; Do not change these values! 
;; Notice we wrote some values in hex this time. Maybe those values should be treated as addresses?
ASCII           .fill -48
OCTALSTRING     .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x5000                    ;;  Don't change the .orig statement
    .stringz "2110"            ;;  You can change this string for debugging!
.end
