;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - palindrome
;;=============================================================
;; Name: Tanush Chopra
;;=============================================================

;;  NOTE: Let's decide to represent "true" as a 1 in memory and "false" as a 0 in memory.
;;
;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String str = "aibohphobia";
;;  boolean isPalindrome = true
;;  int length = 0;
;;  while (str[length] != '\0') {
;;		length++;
;;	}
;; 	
;;	int left = 0
;;  int right = length - 1
;;  while(left < right) {
;;		if (str[left] != str[right]) {
;;			isPalindrome = false;
;;			break;
;;		}
;;		left++;
;;		right--;
;;	}
;;	mem[mem[ANSWERADDR]] = isPalindrome;

.orig x3000

LD R0, STRING

AND R1, R1, 0
ADD R1, R1, 1

AND R2, R2, 0

WHILE1

	ADD R3, R2, R0
	LDR R3, R3, 0

	BRz ENDWHILE1

	ADD R2, R2, 1

	BR WHILE1

ENDWHILE1

AND R3, R3, 0
AND R4, R4, 0
ADD R4, R2, -1

NOT R5, R4
ADD R5, R5, 1

WHILE2

	ADD R6, R3, R5

	BRzp END

	ADD R6, R3, R0
	ADD R7, R4, R0
	LDR R6, R6, 0
	LDR R7, R7, 0
	
	NOT R7, R7
	ADD R7, R7, 1
	
	ADD R6, R6, R7

	BRz ELSE

		AND R1, R1, 0
		BR END

	ELSE

	ADD R3, R3, 1
	ADD R4, R4, -1
	ADD R5, R5, 1
	
	BR WHILE2

END

	STI R1, ANSWERADDR
	HALT

;; Do not change these values!
STRING	.fill x4004
ANSWERADDR 	.fill x5005
.end

;; Do not change any of the .orig lines!
.orig x4004				   
	.stringz "wandcloilcdnaw" ;; Feel free to change this string for debugging.
.end

.orig x5005
	ANSWER  .blkw 1
.end