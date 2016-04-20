Tetris game: a demo on object-oriented programming in MATLAB

Get started:
    Start by simply trying the game!

    In MATLAB, execute:
    >> aGame = TetrisGame.createGame;
    >> aGame.startGame

    
    You can use left/right arrows to control the tetromino, use the up arrow
    to rotate it, or use the down arrow to accelerate.
    Press the Esc key to stop the game.


Class design:
    I roughly followed the MVC pattern.

    TetrisGame is the game class and serves as the Controller.
    BoardViewer is the View.
    TetrisBoard and Tetromino are both Model classes.

    Tetromino is an abstract class providing most of the APIs for a tetromino.
    A tetromino with a specific shape inherits from Tetromino and initialize its shape.

    TetriminosFactory is used for easy creation of different kinds of tetriminos.

TODO:
    Add point system
    Add clean up logic
    Mark different Tetriminos with different colors