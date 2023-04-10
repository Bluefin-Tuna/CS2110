#include <stdio.h>
#include <stdlib.h>

#define BOARD_WIDTH 50
#define BOARD_HEIGHT 50

struct Tile {
  int is_bomb;
  int is_flag;
  int is_visible;
  int num_surronding_bombs;
};

struct Board {
  struct Tile board[BOARD_HEIGHT][BOARD_WIDTH];
};

void initialize_board(struct Board* board) {
    for (int r = 0; r < BOARD_WIDTH; ++r) {
        for (int c = 0; c < BOARD_HEIGHT; ++c) {
            board->board[r][c].is_visible = 0;
            board->board[r][c].is_bomb = 0;
            board->board[r][c].is_visible = 0;
            board->board[r][c].num_surronding_bombs = 0;
        }
    }
}
void generate_bombs(struct Board* board, int num_bombs) {
    while (num_bombs > 0) {
        
    }
}
void calc_num_surrounding_bombs(struct Board* board);
void reveal_tile(struct Board* board, int r, int c);
void flag_tile(struct Board* board, int r, int c);

