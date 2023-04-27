;;=======================================
;; CS 2110 - Spring 2023
;; Final Exam - GCD
;;=======================================
;; Name:
;;=======================================
;; For the LC-3 Assembly part, you must implement the GCD subroutine.
;; We've pre-implemented a helper subroutine MOD for you to use.
;; See the PDF for more detailed instructions.

;; GCD
;; Arguments
;;     a - Integer
;;     b - Integer
;; Returns
;;     GCD of a and b - Integer
;; Pseudocode
;; 
;;     gcd(a, b) {
;;         if (b == 0) {
;;             return a;
;;         }
;;         c = mod(a, b); // MOD subroutine has already been provided
;;         return gcd(b, c);
;;     }
;;
;; TODO - Complete the GCD subroutine!
.orig x3010

GCD

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

    LDR R0, R5, 4  ;; R0 = A

    LDR R1, R5, 5  ;; R1 = B

    ADD R1, R1, 0  ;; Setting CC for checking if B == 0

    BRnp EARLYRET

    STR R0, R5, 3  ;; Storing sum at RA
    BR TEARDOWN    ;; Teardown stack

    EARLYRET

    ADD R6, R6, -2 ;; Make space for 2 arguements
    STR R1, R6, 1  ;; Storing R1 = b
    STR R0, R6, 0  ;; Storing R0 = a

    JSR MOD

    LDR R2, R6, 0  ;; Storing R2 = mod(a, b)
    ADD R6, R6, 3  ;; "Clearing" stack of 2 args and RV

    ADD R6, R6, -2 ;; Make space for 2 arguements
    STR R2, R6, 1  ;; Storing R2 = c
    STR R1, R6, 0  ;; Storing R1 = b

    JSR GCD

    LDR R3, R6, 0  ;; Storing R2 = gcd(b, c)
    ADD R6, R6, 3  ;; "Clearing" stack of 2 args and RV

    STR R3, R5, 3  ;; Storing sum at RA

    BR TEARDOWN


TEARDOWN

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

.end


;; PRE-IMPLEMENTED HELPER SUBROUTINE
;; MOD
;; Arguments
;;     a       - Integer
;;     modulus - Nonzero Integer
;; Returns
;;     a % modulus - Integer
;;
;; DO NOT MODIFY THIS SUBROUTINE
.orig x3100
    MOD
        ;; These are still LC-3 Assembly instructions! They are just encoded in hex. 
        ;; Treat this subroutine as a black box that you can use to help you code GCD.
        .fill x1DBC
        .fill x7F82
        .fill x7B81
        .fill x1BA0
        .fill x1DBB
        .fill x7180
        .fill x7381
        .fill x7582
        .fill x7783
        .fill x7984
        .fill x6345
        .fill x0602
        .fill x927F
        .fill x1261
        .fill x947F
        .fill x14A1
        .fill x6144
        .fill x0804
        .fill x1002
        .fill x07FE
        .fill x1001
        .fill x0E02
        .fill x1001
        .fill x09FE
        .fill x7143
        .fill x6180
        .fill x6381
        .fill x6582
        .fill x6783
        .fill x6984
        .fill x1D60
        .fill x6B81
        .fill x6F82
        .fill x1DA3
        .fill xC1C0
    RET
.end

;; We've preloaded the PDF's test case for you!
;; After pressing run in Complx, the RESULT label will contain your GCD subroutine's return value on inputs A and B.
;; To test other cases, feel free to change A and B to your liking.
;; You can also use Debug -> Simulate Subroutine Call and select the GCD label as usual. 
.orig x3000
    LD R6, STACK
    ADD R6, R6, #-2
    LD R0, A
    STR R0, R6, #0
    LD R0, B
    STR R0, R6, #1
    JSR GCD
    LDR R0, R6, #0
    ADD R6, R6, #3
    ST R0, RESULT
    HALT
    A .fill 56
    B .fill 36
    RESULT .blkw 1
    STACK .fill xF000
.end