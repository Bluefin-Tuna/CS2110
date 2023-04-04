#include "main.h"

#include <stdio.h>
#include <stdlib.h>

#include "gba.h"
#include "images/csmajor.h"
#include "images/shower.h"
#include "images/start.h"
#include "images/vscode.h"
#include "images/end.h"

enum gba_state {
  START,
  PLAY,
  WIN,
};

int main(void) {
  
  REG_DISPCNT = MODE3 | BG2_ENABLE;

  // Save current and previous state of button input.
  u32 previousButtons = BUTTONS;
  u32 currentButtons = BUTTONS;

  // Load initial application state
  enum gba_state state = START;

  struct position csm;
  struct position vsc;

  int t = 0;
  char arr[20];

  while (1) {
    currentButtons = BUTTONS; // Load the current state of the buttons
    waitForVBlank();
    switch (state) {
      case START:
        drawImageDMA(0, 0, START_WIDTH, START_HEIGHT, start);
        if (KEY_JUST_PRESSED(BUTTON_START, currentButtons, previousButtons)) {
          fillScreenDMA(BLACK);
          vBlankCounter = 0;
          csm.r = randint(20, HEIGHT - CSMAJOR_HEIGHT);
          csm.c = randint(20, WIDTH - CSMAJOR_WIDTH);
          vsc.r = randint(20, HEIGHT - VSCODE_HEIGHT);
          vsc.c = randint(20, WIDTH - VSCODE_WIDTH);
          state = PLAY;
        }
        break;
      case PLAY:
        drawRectDMA(0, 0, WIDTH, 10, BLACK);
        t = vBlankCounter / 60;
        snprintf(arr, 20, "Time: %d", t);
        drawString(3, 95, arr, WHITE);
        drawRectDMA(csm.c, csm.r, CSMAJOR_WIDTH, CSMAJOR_HEIGHT, BLACK);
        if (KEY_DOWN(BUTTON_RIGHT, currentButtons) && csm.r < WIDTH - CSMAJOR_WIDTH) {
          csm.r++;
        } else if (KEY_DOWN(BUTTON_LEFT, currentButtons) && csm.r > 0) {
          csm.r--;
        } else if (KEY_DOWN(BUTTON_UP, currentButtons) && csm.c > 15) {
          csm.c--;
        } else if (KEY_DOWN(BUTTON_DOWN, currentButtons) && csm.c < HEIGHT - CSMAJOR_HEIGHT) {
          csm.c++;
        }
        if (KEY_JUST_PRESSED(BUTTON_SELECT, currentButtons, previousButtons)) {
          vBlankCounter = 0;
          state = START;
        }
        if ((csm.r + CSMAJOR_HEIGHT >= vsc.r && csm.r <= vsc.r + VSCODE_HEIGHT) && (csm.c + CSMAJOR_WIDTH >= vsc.c && csm.c <= vsc.c + VSCODE_WIDTH)) {
           state = WIN;
           break;
        }
        /*if ((csm.r + VSCODE_WIDTH == vsc.r || csm.r - VSCODE_WIDTH == vsc.r) && (csm.c + CSMAJOR_HEIGHT == vsc.c || csm.c - VSCODE_HEIGHT == vsc.c)) {
           state = WIN;
        }*/
        drawImageDMA(csm.c, csm.r, CSMAJOR_WIDTH, CSMAJOR_HEIGHT, csmajor);
        drawImageDMA(vsc.c, vsc.r, VSCODE_WIDTH, VSCODE_HEIGHT, vscode);
        if (KEY_JUST_PRESSED(BUTTON_SELECT, currentButtons, previousButtons)) {
          vBlankCounter = 0;
          state = START;
        }
        break;
      case WIN:
        drawFullScreenImageDMA(end);
        snprintf(arr, 20, "Time: %d", t);
        drawCenteredString(0, 0, WIDTH, HEIGHT, arr, WHITE);
        if (KEY_JUST_PRESSED(BUTTON_SELECT, currentButtons, previousButtons)) {
          vBlankCounter = 0;
          state = START;
        }
        break;
    }

    previousButtons = currentButtons; // Store the current state of the buttons
  }

  UNUSED(previousButtons); // You can remove this once previousButtons is used

  return 0;
}