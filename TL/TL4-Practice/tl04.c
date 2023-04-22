// READ THE HEADER FILE FOR MORE DOCUMENTATION
#include "tl04.h"


/**
 * \brief Pointers to the ends of the list
 *
 * These pointers keep track of where the singly-linked list is in memory. The
 * [queue_head] pointer points to the first node of the list, and [queue_tail]
 * likewise points to the last.
 *
 * Initially, both of these pointers are `NULL`. The list is initially empty, so
 * there is no first or last node.
 *
 * \property extern queue_node_t *queue_head
 * \property extern queue_node_t *queue_tail
 */
struct queue_node_t *queue_head = NULL;
struct queue_node_t *queue_tail = NULL;

/**
 * \brief Encrypt a name with XOR encryption
 *
 * This function will be called by client code to encrypt a student's name for
 * the purpose of anonymity.
 *
 * Each character in the provided [plainName] string will be XORed by the [xor_key] 
 * and stored into the [cipherName] int array. NOTE: You do not need to encrypt the 
 * null terminator.
 *
 * This function should return `SUCCESS` if the encryption was successful. Return
 * `FAILURE` only when 
 * * the [cipherName] is `NULL`, or
 * * the [plainName] is `NULL`
 *
 * \param[in] cipherName The int array that stores the encrypted name
 * \param[in] plainName The null-terminated string of the name to be encrypted
 * \param[in] xor_key The xor_key to apply the encryption
 * \return Whether the name was successfully encrypted
 */
int encryptName(uint8_t *cipherName, char *plainName, uint8_t xor_key) {
    if (!cipherName || !plainName) return FAILURE;
    int n = strlen(plainName);
    for (int i = 0; i < n; ++i) *(cipherName + i) = *(plainName + i) ^ xor_key;
    return SUCCESS;
}

/**
 * \brief Decrypt a name with XOR decryption
 *
 * This function will be called by client code to decrypt a encrypted name for
 * the purpose of anonymity.
 *
 * Each number in the provided [cipherName] array will be XORed by the [xor_key] 
 * and stored into the [plainName] string. Remember that strings are null-terminated! 
 *
 * This function should return `SUCCESS` if the decryption was successful. Return
 * `FAILURE` only when 
 * * the [cipherName] is `NULL`, or
 * * the [plainName] is `NULL`
 *
 * \param[in] plainName The string to store the decrypted name
 * \param[in] cipherName The int array that stores the encrypted name
 * \param[in] plainNameLength The length that the plainName should be
 * \param[in] xor_key The xor_key to apply the decryption
 * \return Whether the name was successfully decrypted
 */
int decryptName(char *plainName, uint8_t *cipherName, int plainNameLength, uint8_t xor_key) {
    if (!cipherName || !plainName) return FAILURE;
    for (int i = 0; i < plainNameLength; ++i) *(plainName + i) = *(cipherName + i) ^ xor_key;
    return SUCCESS;
}

/**
 * \brief Add students to the queue
 *
 * This function will be called by client code to add a student to the end of
 * the queue. The caller will supply the data of the student to add.
 *
 * This function should allocate a [queue_node_t] on the heap, and deep-copy
 * all the other data. In particular, any pointers in the [queue_node_t] will
 * require their own dedicated memory allocation. Below are the declarations
 * of the [queue_node_t] and [student_t] structs:
 *
 * struct queue_node_t {
 *  struct student_t data;     ///< The student held by this node
 *  struct queue_node_t *next; ///< Pointer to next node of list (or `NULL`)
 * };
 *
 * struct student_t {
 *  char *name;  
 *  enum assignment_t assignment;
 * };
 * 
 * Note: Make sure that all members of the [queue_node_t] are set!
 * 
 * Finally, insert the student into the queue with the help of the [queue_head]
 * and/or [queue_tail] pointers.
 * 
 * Refer back to the PDF/diagram for specific details about how to link the
 * nodes, and consider any edge cases.
 *
 * This function should return `SUCCESS` if the student was added successfully.
 * If it fails, it should return `FAILURE` and leave the list unchanged. It
 * should fail if and only if:
 * * `malloc` fails,
 * * the student's name is `NULL`, or
 * * the student's name is an empty string.
 *
 * \param[in] data Data of the student to enqueue
 * \return Whether the student was successfully added
 */
int queue_add(struct student_t data) {
    if (!data.name || strlen(data.name) == 0) return FAILURE;
    struct student_t * s = malloc(sizeof(struct student_t));
    if (!s) return FAILURE;
    s->name = malloc(strlen(data.name) + 1);
    if (!s->name) { free(s); return FAILURE; }
    strcpy(s->name, data.name);
    s->assignment = data.assignment;
    struct queue_node_t * q = malloc(sizeof(struct queue_node_t));
    if (!q) { free(s->name); free(s); return FAILURE; }
    q->data = *s;
    if (!queue_head) {
        queue_head = q;
        queue_tail = q;
        free(q);
        return SUCCESS;
    }
    queue_tail->next = q;
    queue_tail = q;
    free(q);
    return SUCCESS;
}

/**
 * \brief Remove students from the queue
 *
 * This function will be called by client code to remove a student from the
 * front the queue. It will return whether a student was removed successfully,
 * and the data removed in that case.
 *
 * The way this function returns the student data using the data out technique.
 * This is to get around the limitation that functions may only have one return
 * value. As such, the caller will pass in a pointer where the student's data
 * should be stored. Then this function will store the returned data at that
 * pointer. Independently, it returns whether it succeeded via the normal path.
 * 
 * Finally, remove the student into the queue with the help of the [queue_head]
 * and/or [queue_tail] pointers.
 * 
 * Refer back to the PDF/diagram for specific details about how to link the
 * nodes, and consider any edge cases.
 * 
 * Remember to free the node when you're done. A copy of the data is being
 * returned, the node containing the data is not. The node will no longer be
 * accessible when the function returns, so it should be freed.
 *
 * If this function succeeds, it should return `SUCCESS` and modify `*data` to
 * be the data of the student removed. If it fails, it should return `FAILURE`
 * and leave both the list and `*data` unchanged. It should fail if and only if:
 * * [data] is `NULL`, or
 * * the list is empty.
 *
 * \param[out] data Where to put the data of the removed student
 * \return Whether a student was successfully removed
 */
int queue_remove(struct student_t *data) {
    if (!data || (!queue_head && !queue_tail)) return FAILURE;
    struct queue_node_t * q = queue_head;
    if (!queue_head->next) {
        queue_head = NULL;
        queue_tail = NULL;
    } else {
        queue_head = queue_head->next;
    }
    struct student_t * d = malloc(sizeof(struct student_t));
    if (!d) return NULL;
    d->name = malloc(strlen(q->data.name) + 1);
    if (!d->name) { free(d); return NULL; }
    strcpy(d->name, q->data.name);
    d->assignment = q->data.assignment;
    *data = *d;
    free(d->name);
    free(d);
    free(q->data.name);
    free(&(q->data));
    free(q);
    return SUCCESS;
}

/**
 * \brief Appends the last name to the student data of a queue node
 *
 * This function will be called by client code to append the [last_name] of 
 * the student data in the [queue_node_t] parameter. You CANNOT assume that
 * the original name string buffer has enough space for the [last_name].
 *
 * NOTE: the provided [queue_node_t] will always have only the first name for the 
 * student's name, so you must append the space before append the [last_name]. For 
 * example, if the node's student name is "Avaneesh" and the last name we wish to 
 * append is "Stuhr", the node's updated student name should be "Avaneesh Stuhr". 
 * Notice the added space between the first name and last name. Also note, the queue node
 * parameter will NOT be null.
 *
 * This function should return `SUCCESS` if appending the last_name was successful. 
 * Return `FAILURE` only when 
 * * `malloc` or `realloc` fails,
 * * [last_name] is `NULL`, or
 * * [last_name] is an empty string.
 *
 * \param[out] node The node whose student's name should be appended by [last_name]
 * \param[in] last_name The last name null-terminated string to append
 * \return Whether the last name was successfully appended
 */
int add_last_name(struct queue_node_t *node, char *last_name) {
    
    return FAILURE;
}
