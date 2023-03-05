;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Factorial
;;=============================================================
;;  Name: Tanush Chopra
;;============================================================

;;  In this file, you must implement the 'MULTIPLY' and 'FACTORIAL' subroutines.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'MULTIPLY' or 'FACTORIAL' labels
;;      * Add the [a, b] or [n] params separated by a comma (,) 
;;        (e.g. 3, 5 for 'MULTIPLY' or 6 for 'FACTORIAL')
;;      * Proceed to run, step, add breakpoints, etc.
;;      * Remember R6 should point at the return value after a subroutine
;;        returns. So if you run the program and then go to 
;;        'View' -> 'Goto Address' -> 'R6 Value', you should find your result
;;        from the subroutine there (e.g. 3 * 5 = 15 or 6! = 720)

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  MULTIPLY Pseudocode (see PDF for explanation and examples)   
;;  
;;  MULTIPLY(int a, int b) {
;;      int ret = 0;
;;      while (b > 0) {
;;          ret += a;
;;          b--;
;;      }
;;      return ret;
;;  }

MULTIPLY ;; Do not change this label! Treat this as like the name of the function in a function header

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
    
    LDR R0, R5, 4  ;; Setting R0 = a
    
    LDR R1, R5, 5  ;; Setting R1 = b
    
    AND R2, R2, 0  ;; Setting R2 = ret = 0

    WHILE_MULTIPLY

        ADD R1, R1, 0   ;; Setting CC to break when R1 = b <= 0

        BRnz END_WHILE_MULTIPLY

        ADD R2, R2, R0  ;; Setting ret += a
        ADD R1, R1, -1  ;; Decrementing b

        BR WHILE_MULTIPLY

    END_WHILE_MULTIPLY

    STR R2, R5, 3  ;; Storing MULTIPLY(a, b) at RV 

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

;;  FACTORIAL Pseudocode (see PDF for explanation and examples)
;;
;;  FACTORIAL(int n) {
;;      int ret = 1;
;;      for (int x = 2; x <= n; x++) {
;;          ret = MULTIPLY(ret, x);
;;      }
;;      x = n
;;      while (x)
;;      return ret;
;;  }

FACTORIAL ;; Do not change this label! Treat this as like the name of the function in a function header

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

    LDR R0, R5, 4  ;; Popping n from stack and loading into R0

    NOT R0, R0
    ADD R0, R0, 1  ;; Setting R0 = -n

    AND R1, R1, 0
    ADD R1, R1, 1  ;; Setting R1 = ret = 1

    AND R2, R2, 0
    ADD R2, R2, 2  ;; Setting R2 = x = 2

    WHILE_FACTORIAL

        ADD R3, R2, R0 ;; Setting CC for checking when to break out of loop

        BRp END_WHILE_FACTORIAL

        ADD R6, R6, -2 ;; Making room for 2 additional args
        STR R2, R6, 1  ;; Storing R2 = b
        STR R1, R6, 0  ;; Storing R1 = a

        JSR MULTIPLY

        LDR R1, R6, 0  ;; Loading R1 = RV = MULTIPLY(ret, x)
        ADD R6, R6, 3  ;; "Clearing" stack of 2 args and RV

        ADD R2, R2, 1  ;; Increment x
        
        BR WHILE_FACTORIAL
    
    END_WHILE_FACTORIAL

    STR R1, R5, 3

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

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end