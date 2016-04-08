classdef BoardViewer < handle
    properties (Access = public)
        pBoard TetrisBoard  % Restrict property values
        pFigure             % Figure object
        pPanel              % Panel object to represent the board
        pUnitWidth = 0.04;  % Normalized width for each block in board.
        % For simplicity, use a predefined value.
    end % End of private properties
    
    
    methods (Access = public)
        function viewerObj = BoardViewer(aBoard)
            viewerObj.pBoard = aBoard;
            [viewerObj.pFigure, viewerObj.pPanel] = ...
                viewerObj.createBoardView;
        end % End of ctor
        
        function delete(obj)
            close(obj.pFigure);
        end % End of dtor
    end % End of public methods
    
    
    methods (Access = private)
        function [figObj, panelObj] = createBoardView(obj)
            figObj = figure;
            [nrows, ncols] = obj.pBoard.getSize;
            
            % Place the board in the middle of the figure
            tetrominoWidth = obj.pUnitWidth;
            boardWidth  = ncols * tetrominoWidth;
            boardHeight = nrows * tetrominoWidth;
            boardX = 0.5 - boardWidth / 2;
            boardY = 0.5 - boardHeight / 2;
            
            panelObj = uipanel('Parent', figObj, ...
                'Title', 'Tetris', ...
                'TitlePosition', 'centertop', ...
                'Position', [boardX, boardY, boardWidth, boardHeight]);
        end % End of createBoardView
    end % End of private methods
end % End of classdef