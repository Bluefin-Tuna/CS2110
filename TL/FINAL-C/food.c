/**
 * CS 2110 - Spring 2023
 * Final Exam - Kirby Food Queue
 *
 * Name:
 */

/**
 * 
 * IMPORTANT: string.h has been included so you are encouraged to use any string functions (strlen, strncpy, etc.) that you may need.
 */

// DO NOT MODIFY THE INCLUDE(s) LIST
#include "food.h"

// Global variables
struct wrapper *head = NULL; // Head of the food list (a linked list)

/** makeWrapper
 *
 * Creates a new wrapper at the head which will hold either a apple or tomato.
 * If the wrapper is created properly, set its foodType to the provided foodType.
 * If the provided type is an apple, the new wrapper should hold given info on the apple.
 * If the provided type is a tomato, the new wrapper should hold given info on the tomato.
 * If everything was allocated and copied without problems, then push this wrapper to the front of the food linked list.
 * The head of the food linked list is stored in the global variable 'head' (listed on top).
 * 
 * NOTE: Check out the 'food.h' file for more info on the structs
 * ------------------------------------------------
 * Here is the struct definition of a wrapper.
 * struct wrapper {
 *  struct data data;
 *  struct wrapper *next;
 * };
 * ------------------------------------------------
 * 
 * 
 * NOTE: You should create deep copies of the elements if needed.
 * 
 * NOTE: If this function succeeds, it should return SUCCESS and add the newly created
 *       wrapper to the front of the list. If it fails, it should return FAILURE.
 * 
 * @param foodType An enum that specifies the type of food contained in the wrapper
 * @param damage The amount of damage done if the food in the wrapper is an apple
 * @param appleVariety The type of apple if the food in the wrapper is an apple
 * @param health The amount of health restored if the food in the wrapper is a tomato
 * @return FAILURE if any of the following are true:
 *         (1) appleVariety is NULL if foodType is APPLE
 *         (2) dynamic memory allocation failure occurs
 *         Otherwise, return SUCCESS
 */
int makeWrapper(foodType foodType, int damage, const char *appleVariety, int health) {
    if (foodType == APPLE && !appleVariety) { return FAILURE; }
    struct data * d = malloc(sizeof(struct data));
    if (!d) return FAILURE;
    union food * f = malloc(sizeof(union food));
    if (!f) { free(d); return FAILURE; }
    switch (foodType) {
      case (APPLE):;
        d->foodType = foodType;
        f->apple.appleVariety = malloc(strlen(appleVariety) + 1);
        if (!f->apple.appleVariety) { free(f); free(d); return FAILURE; }
        strcpy(f->apple.appleVariety, appleVariety);
        f->apple.damage = damage;
        d->food = *f;
        free(f);
        break;
      case (TOMATO):;
        d->foodType = foodType;
        f->tomato.health = health;
        d->food = *f;
        free(f);
        break;
    }
    struct wrapper * w = malloc(sizeof(struct wrapper));
    if (!w) { free(d); return FAILURE; }
    w->data = *d;
    free(d);
    if (!head) {
      head = w;
      head->next = NULL;
    } else {
      w->next = head;
      head = w;
    }
    return SUCCESS;
}

/** replaceAppleVariety
 * 
 * Iterate through the list of food and find the first wrapper with an apple that
 * has an appleVariety in it that is the same as the targetVariety. For that apple, 
 * replace its appleVariety with the replacementVariety. Only reassign the appleVariety
 * given that dynamic memory allocation succeeds.
 * 
 * Leave any other struct fields unchanged. If dynamic memory allocation fails at any
 * point, leave any previously existing fields unchanged.
 * 
 * Remember that you have access to the head global variable.
 * 
 * You should make deep copies anytime you change an appleVariety.
 * 
 * IMPORTANT: 'replacementVariety' is the given parameter
 * IMPORTANT: 'replaceAppleVariety' is the function name
 * 
 * @param replacementVariety a string containing the new appleVariety
 * @param targetVariety a string containing the old appleVariety to find in the list
 * @return FAILURE if any of the following are true:
 *         (1) replacementVariety is NULL
 *         (2) targetVariety is NULL
 *         (3) targetVariety was not found in the list
 *         (4) dynamic memory allocation failure occurs
 *         Otherwise, return SUCCESS
 */
int replaceAppleVariety(const char *replacementVariety, const char *targetVariety) {
  if (!replacementVariety || !targetVariety || !head) return FAILURE;
  struct wrapper * c = head;
  while (!c) {
    if (c->data.foodType == APPLE && strcmp(c->data.food.apple.appleVariety, targetVariety) == 0) {
      char * s = malloc(strlen(replacementVariety) + 1);
      if (!s) return FAILURE;
      free(c->data.food.apple.appleVariety);
      c->data.food.apple.appleVariety = s;
      strcpy(c->data.food.apple.appleVariety, replacementVariety);
      return SUCCESS;
    }
    c = c->next;
  }
  return FAILURE;
}
