;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Preorder Traversal
;;=============================================================
;;  Name: Tanush Chopra
;;============================================================

;;  In this file, you must implement the 'PREORDER_TRAVERSAL' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'PREORDER_TRAVERSAL' label
;;      * Add the [root (addr), arr (addr), index] params separated by a comma (,) 
;;        (e.g. x4000, x4020, 0)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * Remember R6 should point at the return value after a subroutine
;;        returns. So if you run the program and then go to 
;;        'View' -> 'Goto Address' -> 'R6 Value', you should find your result
;;        from the subroutine there (e.g. Node 8 is found at x4008)

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  PREORDER_TRAVERSAL Pseudocode (see PDF for explanation and examples)
;;  - Nodes are blocks of size 3 in memory:
;;      * The data is located in the 1st memory location (offset 0 from the node itself)
;;      * The node's left child address is located in the 2nd memory location (offset 1 from the node itself)
;;      * The node's right child address is located in the 3rd memory location (offset 2 from the node itself)

;;  PREORDER_TRAVERSAL(Node root (addr), int[] arr (addr), int index) {
;;      if (root == 0) {
;;          return index;
;;      }
;;
;;      arr[index] = root.data;
;;      index++;
;;
;;      index = PREORDER_TRAVERSAL(root.left, arr, index);
;;      return PREORDER_TRAVERSAL(root.right, arr, index);
;;  }


PREORDER_TRAVERSAL ;; Do not change this label! Treat this as like the name of the function in a function header
    
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

    LDR R1, R5, 5  ;; Loading arr address into R1
    LDR R2, R5, 6  ;; Loading index into R2    
    LDR R0, R5, 4  ;; Loading node address into R0

    BRz BASECASE   ;; If root == 0

    LDR R3, R0, 0  ;; Load root.data into R3

    ADD R4, R1, R2 ;; Setting R4 to address of arr[i] 
    STR R3, R4, 0  ;; arr[index] = root.data

    ADD R2, R2, 1  ;; Incrementing index


    ADD R0, R0, 1
    LDR R3, R0, 0  ;; Loading address of root.left into R3

    ADD R6, R6, -3 ;; Making space for 3 args for recursive call
    STR R2, R6, 2  ;; Storing incremented index
    STR R1, R6, 1  ;; Storing arr address
    STR R3, R6, 0  ;; Storing address of root.left

    JSR PREORDER_TRAVERSAL

    LDR R2, R6, 0  ;; Loading R2 = RV = PREORDER_TRAVERSAL(root.left, arr, index);
    ADD R6, R6, 4  ;; "Clearing" stack of 3 args and RV


    ADD R0, R0, 1
    LDR R3, R0, 0  ;; Loading address of root.right into R3

    ADD R6, R6, -3 ;; Making space for 3 args for recursive call
    STR R2, R6, 2  ;; Storing incremented index
    STR R1, R6, 1  ;; Storing arr address
    STR R3, R6, 0  ;; Storing address of root.right

    JSR PREORDER_TRAVERSAL

    LDR R2, R6, 0  ;; Loading R2 = RV = PREORDER_TRAVERSAL(root.right, arr, index);
    ADD R6, R6, 4  ;; "Clearing" stack of 3 args and RV

    BR BASECASE


BASECASE

    STR R2, R5, 3
    
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

; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end

;;  Assuming the tree starts at address x4000, here's how the tree (see below and in the PDF) is represented in memory
;;
;;              4
;;            /   \
;;           2     8 
;;         /   \
;;        1     3 

.orig x4000 ;; 4    ;; node itself lives here at x4000
    .fill 4         ;; node.data (4)
    .fill x4004     ;; node.left lives at address x4004
    .fill x4008     ;; node.right lives at address x4008
.end

.orig x4004	;; 2    ;; node itself lives here at x4004
    .fill 2         ;; node.data (2)
    .fill x400C     ;; node.left lives at address x400C
    .fill x4010     ;; node.right lives at address x4010
.end

.orig x4008	;; 8    ;; node itself lives here at x4008
    .fill 8         ;; node.data (8)
    .fill 0         ;; node does not have a left child
    .fill 0         ;; node does not have a right child
.end

.orig x400C	;; 1    ;; node itself lives here at x400C
    .fill 1         ;; node.data (1)
    .fill 0         ;; node does not have a left child
    .fill 0         ;; node does not have a right child
.end

.orig x4010	;; 3    ;; node itself lives here at x4010
    .fill 3         ;; node.data (3)
    .fill 0         ;; node does not have a left child
    .fill 0         ;; node does not have a right child
.end

;;  Another way of looking at how this all looks like in memory
;;              4
;;            /   \
;;           2     8 
;;         /   \
;;        1     3 
;;  Memory Address           Data
;;  x4000                    4          (data)
;;  x4001                    x4004      (4.left's address)
;;  x4002                    x4008      (4.right's address)
;;  x4003                    Don't Know
;;  x4004                    2          (data)
;;  x4005                    x400C      (2.left's address)
;;  x4006                    x4010      (2.right's address)
;;  x4007                    Don't Know
;;  x4008                    8          (data)
;;  x4009                    0(NULL)
;;  x400A                    0(NULL)
;;  x400B                    Don't Know
;;  x400C                    1          (data)
;;  x400D                    0(NULL)
;;  x400E                    0(NULL)
;;  x400F                    Dont't Know
;;  x4010                    3          (data)
;;  x4011                    0(NULL)
;;  x4012                    0(NULL)
;;  x4013                    Don't Know
;;  
;;  *Note: 0 is equivalent to NULL in assembly

.orig x4020 ;; Result Array : You can change the block size for debugging!
    .blkw 5
.end