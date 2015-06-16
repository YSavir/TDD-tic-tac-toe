# Tic Tac Tobject Oriented O
*(Sorry for the horrible name)*

## How to play

Run the `play.rb` file and follow instructions.

### Players

The game can support any number of players. The game trusts the users to keep
player number within a reasonable range.

A player can be either human or a computer player.

Human players will be asked to choose their own symbol, which can be anything.

**Note:** The grid display isn't set up to properly show symbols longer
than 5 characters, so any such symbol will lead to wonky displays.

### Grid

The grid can be any size and configuration, from 1x1 through 2x4 to 1000x1000.

The game trusts the users to creates reasonably sized grids.

**Note:** Large grids will not display well.... Yet.

**Note:** 2x2 and smaller grids cannot be won at the moment (a win is programmed
to require 3 cells in a row)
### Choosing Cells

When asked to choose a cell, you must input the cell coordinates as "<row>,
<column>".

## Technical Info

### Win Detection

The game checks for a win every time a cell is chosen. It does this by finding
any of that cell's neighbors that have the same symbol, and finding any possible
sequences using those two cells (ie when it finds that [1, 1]'s neighbor [2, 2]
has the same symbol as [1, 1], it will complete the sequence by adding cell [3,
3].

Once it has a list of all possible winning sequences, it checks if any of those
sequences is a valid winning sequence (all of its cells share the same symbol).
Once a sequence turns up as a winning sequence, the game ends and the winner is
declared.

### Tie Detection

The game is declared a tie when there are no moves left and there aren't any
winners.

### IO Testing

Since much of the program is about inputting/outputting data, I created a small
toolset to help capture and set input for tests. *(See the `spec/support/iodize`
file)*
### Modularity

I tried to keep the game as modular as possible. In theory, converting this to a
game of Connect 4 should not be too much work. *(Easier said than done, of
course)*

## What More I Would Do

There's a lot more I could and would do, given the time...

- Although most of the features are tested, there are some that still need test
coverage.
- There are several parts of the code that could be DRYed up.
- Some code (especially among the interfaces) could be extracted to a
    module and included in each interface as necessary.
- Some pieces of code should be moved to a different class, or abstracted to its own
    class.
- The game could do with a `TicTacToe::Program` class and interface to handle
    starting/ending the program rather than immediately starting by create a
    `TicTacToe::Game` instance.
- `Iodize` could be improved/built on.
- Abstract `rows` and `columns` into their own class to simplify language and
    clean up some files.
- Allow configuration of options, such as whether or not to shuffle players and
    how many cells in a row are required for a win.
- Other things too. It's hard to remember everything.

