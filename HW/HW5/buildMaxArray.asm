;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - buildMaxArray
;;=============================================================
;; Name: Tanush Chopra
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;	int A[] = {-2, 2, 1};
;;	int B[] = {1, 0, 3};
;;	int C[3];
;;	int length = 3;
;;
;;	int i = 0;
;;	while (i < length) {
;;		if (A[i] >= B[length - i - 1]) {
;;			C[i] = 1;
;;		}
;;		else {
;;			C[i] = 0;
;;		}
;;		i++;
;;	}

.orig x3000

LD R0, A ; a = A = 3200
LD R1, B ; b = B = 3300
ADD R1, R1, 2 ; b += 2 = 3302
LD R2, C ; c = C = 3400
LD R3, LENGTH ; l = LENGTH
ADD R1, R1, R3 ; j

WHILE
	
	ADD R3, R3, -1 ; l -= 1
	
	BRn END

	LD R4, R0
	LD R5, R1
	
	NOT R5, R5
	ADD R5, R5, 1
	ADD R4, R4, R5

	BRn ELSE ; if s + t >= 0
		ST 1, R2
	BR ENDIF
	ELSE
		ST 0, R2
	ENDIF

	ADD R0, R0, 1
	ADD R1, R1, -1
	ADD R2, R2, 1
	
	BR WHILE

END
	;; YOUR CODE HERE
	HALT

;; Do not change these addresses! 
;; We populate A and B and reserve space for C at these specific addressses in the orig statements below.
A 		.fill x3200		
B 		.fill x3300		
C 		.fill x3400		
LENGTH 	.fill 3			;; Change this value if you decide to increase the size of the arrays below.
.end

;; Do not change any of the .orig lines!
;; If you decide to add more values for debugging, make sure to adjust LENGTH and .blkw 3 accordingly.
.orig x3200				;; Array A : Feel free to change or add values for debugging.
	.fill -2
	.fill 2
	.fill 1
.end

.orig x3300				;; Array B : Feel free change or add values for debugging.
	.fill 1
	.fill 0
	.fill 3
.end

.orig x3400
	.blkw 3				;; Array C: Make sure to increase block size if you've added more values to Arrays A and B!
.end