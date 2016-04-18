classdef (Abstract) Tetromino < handle
    properties (Access = protected)
        pBoard TetrisBoard
        pTiles          % 1-by-4 array which represents a tetromino's position on the board
                        % Linear indexing        
    end % End of protected properties
    
    
    methods (Abstract)
        output = isValid(obj)
        rotate(obj, direction)
    end % End of abstract methods
    
    
    methods
        function obj = fall(obj)
            obj.pBoard.clearTiles(obj.pTiles);
            obj.pTiles = obj.pTiles + 1; 
            obj.pBoard.setTiles(obj.pTiles);
        end % End of fall
    end % End of public methods
end 