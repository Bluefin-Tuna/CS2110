;; Timed Lab 3
;; Student Name:

;; Please read the PDF for full directions.
;; The pseudocode for the program you must implement is listed below; it is also listed in the PDF.
;; If there are any discrepancies between the PDF's pseudocode and the pseudocode below, notify a TA immediately.
;; However, in the end, the pseudocode is just an example of a program that would fulfill the requirements specified in the PDF.

;; Pseudocode:
;; // (checkpoint 1)
;; int MAX(int a, int b) {
;;   if (a > b) {
;;       return 0;
;;   } else {
;;       return 1;
;;   }
;; }
;;
;;
;;
;;
;; DIV(x, y) {
;;	   // (checkpoint 2) - Base Case
;;     if (y > x) {
;;         return 0;
;;     // (checkpoint 3) - Recursion
;;     } else {
;;         return 1 + DIV(x - y, y);
;;     }
;; }
;;
;;
;;
;; // (checkpoint 4)
;; void MAP(array, length) {
;;   int i = 0;
;;   while (i < length) {
;;      int firstElem = arr[i];
;;      int secondElem = arr[i + 1];
;;      int div = DIV(firstElem, secondElem);
;;      int offset = MAX(firstElem, secondElem);
;;      arr[i + offset] = div;
;;      i += 2;
;;   }
;; }


.orig x3000
HALT

STACK .fill xF000

; DO NOT MODIFY ABOVE


; START MAX SUBROUTINE
MAX

    ADD R6, R6, -4 ;; Making room for header information (RV, RA, OFP, and 1 local var.)
    STR R7, R6, 2  ;; Save RA
    STR R5, R6, 1  ;; Save OFP
    ADD R5, R6, 0  ;; Setting R5 to the frame pointer
    
    ADD R6, R6, -5 ;; Making room for saving registers
    STR R0, R6, 0  ;; Storing old R0
    STR R1, R6, 1  ;; Storing old R1
    STR R2, R6, 2  ;; Storing old R2
    STR R3, R6, 3  ;; Storing old R3
    STR R4, R6, 4  ;; Storing old R4

    LDR R0, R5, 4

    LDR R1, R5, 5

    LDR R0, R6, 0  ;; Restore old R0
    LDR R1, R6, 1  ;; Restore old R1
    LDR R2, R6, 2  ;; Restore old R2
    LDR R3, R6, 3  ;; Restore old R3
    LDR R4, R6, 4  ;; Restore old R4

    ADD R6, R5, 0  ;; Pop off restored registers and any local variables (LV)
    LDR R5, R6, 1  ;; Restore old frame pointer (FP)
    LDR R7, R6, 2  ;; Restore return address (RA)
    ADD R6, R6, 3  ;; Pop off LV1, old FP, and RA

    RET
; END MAX SUBROUTINE




; START DIV SUBROUTINE
DIV



; !!!!! WRITE YOUR CODE HERE !!!!!



RET
; END DIV SUBROUTINE



; START MAP SUBROUTINE
MAP



; !!!!! WRITE YOUR CODE HERE !!!!!



RET
; END MAP SUBROUTINE


; LENGTH FOR TESTING

LENGTH .fill x12

; ARRAY FOR TESTING
ARRAY .fill x4000

.end

.orig x4000
.fill 12
.fill 3
.fill 5
.fill 7
.fill 16
.fill 2
.fill 5
.fill 5
.fill 25
.fill 7
.fill 48
.fill 60
.end
