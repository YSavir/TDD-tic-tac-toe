# Tic Tac Tobject Oriented O

## How to play

Run the `play.rb` file and follow instructions.

### Players

The game can support any number of players (within reason).

A player can be either human or a computer player.

Human players will be asked to choose their own symbol, which can be anything.

**Note:** The grid display isn't set up to properly show symbols longer
than 5 characters, so any such symbol will lead to wonky displays.

### Grid

The grid can be any size and configuration, from 1x1 through 2x4 to 1000x1000.

**Note:** Large grids will not display well.... Yet.

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

