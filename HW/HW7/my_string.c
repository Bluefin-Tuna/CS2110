/**
 * @file my_string.c
 * @author Tanush Chopra
 * @collaborators N/A
 * @brief Your implementation of these famous 3 string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2023-03-xx
 */

#include <stddef.h>
#include "my_string.h"
/**
 * @brief Calculate the length of a string
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    size_t len = 0;
    while (*s++) { ++len; }
    return len;
}

/**
 * @brief Compare two strings
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    size_t c = 0;
    while (*s1 && *s2 && *s1 == *s2 && c < n) {
        s1++;
        s2++;
        c++;
    }
    return (*s1 - *s2);
}

/**
 * @brief Copy a string
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    char* p = dest;
    size_t i;
    for (i = 0; i < n; ++i) {
        if (*src == '\0') { break; }
        *p = *src;
        p++;
        src++;
    }
    for (; i < n; ++i) {
        *p = '\0';
        p++;
    }
    return dest;
}

/**
 * @brief Concatenates two strings and stores the result
 * in the destination string
 *
 * @param dest The destination string
 * @param src The source string
 * @param n The maximum number of bytes from src to concatenate
 * @return char* a pointer same as dest
 */
char *my_strncat(char *dest, const char *src, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
   char* p = dest;
   while (*p) { p++; }
   size_t i = 0;
   while (i < n && *(src + i)) {
       *(p + i) = *(src + i);
       i++;
   }
   *(p + i) = '\0';
   return dest;
}

/**
 * @brief Copies the character c into the first n
 * bytes of memory starting at *str
 *
 * @param str The pointer to the block of memory to fill
 * @param c The character to fill in memory
 * @param n The number of bytes of memory to fill
 * @return char* a pointer same as str
 */
void *my_memset(void *str, int c, size_t n)
{
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    char* p = str;
    while (n-- > 0) {
        *p = c;
        p++;
    }
    return str;
}

/**
 * @brief Finds the first instance of c in str
 * and removes it from str in place
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 */
void remove_first_instance(char *str, char c){
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    char* p = str;
    while (*p && *p != c) { p++; }
    while (*(p + 1)) {
        *p = *(p + 1);
        p++;
    }
    *(p) = '\0';
    return;
}

/**
 * @brief Finds the first instance of c in str
 * and replaces it with the contents of replaceStr
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 * @param replaceStr The pointer to the string we are replacing c with
 */
void replace_character_with_string(char *str, char c, char *replaceStr) {
    if(my_strlen(replaceStr) == 0) {
        remove_first_instance(str, c);
        return;
    }
    size_t sl = my_strlen(str);
    size_t n = my_strlen(replaceStr);
    char* sp = str;
    while (sp < (str + sl)) {
        if (*sp == c) {
            char* src = str + sl;
            char* dest = str + sl + n - 1;
            while (dest > sp) { *dest-- = *src--; }
            int i = 0;
            int nn = (int)(n);
            while (i < nn) { *(sp + i++) = *replaceStr++; }
            return;
        }
        sp++;
    }
    return;
}

/**
 * @brief Remove the first character of str (ie. str[0]) IN ONE LINE OF CODE.
 * No loops allowed. Assume non-empty string
 * @param str A pointer to a pointer of the string
 */
void remove_first_character(char **str) {
    /* Note about UNUSED_PARAM
    *
    * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
    * parameters prior to implementing the function. Once you begin implementing this
    * function, you can delete the UNUSED_PARAM lines.
    */
    *str = (*str + 1);
    return;
}