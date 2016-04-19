Tetris game: a demo on object-oriented programming in MATLAB

Get started:
    Start by simply trying the game!

    In MATLAB, execute:
    >> aGame = TetrisGame.createGame;
    >> aGame.startGame

    (At the time this instruction is written, the game is not fully completed yet.
     You can use left/right arrows to control the tetromino, use the up arrow
     to rotate it, or use the down arrow to accelerate.
     However, I haven't implemented elimination mechanism and point system, but
     these features will be coming soon)


Class design:
    I roughly followed the MVC pattern.

    TetrisGame is the game class and serves as the Controller.
    BoardViewer is the View.
    TetrisBoard and Tetromino are both Model classes.

    Tetromino is an abstract class providing most of the APIs for a tetromino.
    A tetromino with a specific shape inherits from Tetromino and initialize its shape.

    TetriminosFactory is used for easy creation of different kinds of tetriminos.