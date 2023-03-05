;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Insertion Sort
;;=============================================================
;;  Name: Tanush Chopra
;;============================================================

;;  In this file, you must implement the 'INSERTION_SORT' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'INSERTION_SORT' label
;;      * Add the [arr (addr), length] params separated by a comma (,) 
;;        (e.g. x4000, 5)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * INSERTION_SORT is an in-place algorithm, so if you go to the address
;;        of the array by going to 'View' -> 'Goto Address' -> 'Address of
;;        the Array', you should see the array (at x4000) successfully 
;;        sorted after running the program (e.g [2,3,1,1,6] -> [1,1,2,3,6])

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  INSERTION_SORT **RESURSIVE** Pseudocode (see PDF for explanation and examples)
;; 
;;  INSERTION_SORT(int[] arr (addr), int length) {
;;      if (length <= 1) {
;;        return;
;;      }
;;  
;;      INSERTION_SORT(arr, length - 1);
;;  
;;      int last_element = arr[length - 1];
;;      int n = length - 2;
;;  
;;      while (n >= 0 && arr[n] > last_element) {
;;          arr[n + 1] = arr[n];
;;          n--;
;;      }
;;  
;;      arr[n + 1] = last_element;
;;  }

INSERTION_SORT ;; Do not change this label! Treat this as like the name of the function in a function header

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

    LDR R0, R5, 4  ;; Load arr address into R0

    LDR R1, R5, 5  ;; Load length into R1

    ADD R2, R1, -1 ;; Setting CC to check if R1 = length <= 1
    
    BRnz TEARDOWN  ;; If length <= 1: return;

    ADD R6, R6, -2 ;; Making room for 2 args
    STR R2, R6, 1  ;; Storing R2 = length - 1 for recursive call
    STR R0, R6, 0  ;; Storing arr address for recursive call

    JSR INSERTION_SORT

    ADD R6, R6, 3  ;; "Clearing" 2 args and RV from stack

    AND R3, R3, 0  ;; Clearing R3
    ADD R3, R0, R2 ;; Getting address of last element
    LDR R3, R3, 0  ;; Loading address of last element into R3

    NOT R3, R3
    ADD R3, R3, 1  ;; Setting R3 = -arr[length - 1]

    ADD R2, R2, -1 ;; Setting R2 = n = length - 2

    WHILE_INSSORT

        ADD R2, R2, 0

        BRn END_WHILE_INSSORT  ;; If n < 0: break

        AND R4, R4, 0          ;; Clearing R4
        ADD R4, R0, R2         ;; Getting address of n-th element of arr
        LDR R4, R4, 0          ;; Loading address of n-th element into R4

        ADD R1, R4, R3         ;; Setting CC to check if arr[n] > last_element

        BRnz END_WHILE_INSSORT ;; If arr[n] <= last_element: break

        ADD R1, R0, R2         ;; Getting address of arr[n + 1]
        STR R4, R1, 1          ;; Setting arr[n + 1] = arr[n]
        ADD R2, R2, -1         ;; Decrementing n

        BR WHILE_INSSORT

    END_WHILE_INSSORT

    NOT R3, R3
    ADD R3, R3, 1  ;; Setting R3 = arr[length - 1]
    
    ADD R1, R0, R2
    STR R3, R1, 1  ;; Setting arr[n + 1] = last_element

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

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end

.orig x4000	;; Array : You can change these values for debugging!
    .fill 2
    .fill 3
    .fill 1
    .fill 1
    .fill 6
.end