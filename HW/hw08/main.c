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
  LOSE,
};

char arr[20];

int main(void) {
  
  REG_DISPCNT = MODE3 | BG2_ENABLE;

  // Save current and previous state of button input.
  u32 previousButtons = BUTTONS;
  u32 currentButtons = BUTTONS;

  // Load initial application state
  enum gba_state state = START;

  while (1) {
    currentButtons = BUTTONS; // Load the current state of the buttons

    /* TODO: */
    // Manipulate the state machine below as needed //
    // NOTE: Call waitForVBlank() before you draw

    waitForVBlank();


    switch (state) {
      case START:
        // drawImageDMA(0, 0, START_WIDTH, START_HEIGHT, start);
        drawImageDMA(0, 0, VSCODE_WIDTH, VSCODE_HEIGHT, vscode);
        // drawCenteredString()
        break;
      case PLAY:
        
        // state = ?
        break;
      case WIN:

        // state = ?
        break;
      case LOSE:

        // state = ?
        break;
    }

    previousButtons = currentButtons; // Store the current state of the buttons
  }

  UNUSED(previousButtons); // You can remove this once previousButtons is used

  return 0;
}