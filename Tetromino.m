classdef (Abstract) Tetromino < handle
    properties (Access = protected)
        pBoard TetrisBoard
        pTiles          % 1-by-4 array which represents a tetromino's position on the board
                        % Linear indexing        
    end % End of protected properties
    
end 