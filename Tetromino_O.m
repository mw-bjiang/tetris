classdef Tetromino_O < Tetromino
% Initial shape of the tetromino:
%   * * 
%   * *
%   Order in pTiles:
%   1 2 
%   3 4    
%   No rotation
% Initial position is specified by the leftmost tile
    methods
        function obj = Tetromino_O(aBoard, initPosition)
            if nargin == 1
                initPosition = [1, 1];
            end
            
            if ~isequal([1, 2], size(initPosition))
                ME = MException('Tetromino:InvalidPosition', ...
                    'Initial position of the tetromino invalid');
                throw(ME);
            end
            
            obj@Tetromino(aBoard)
            
            initRow = initPosition(1);
            initCol = initPosition(2);
            
            % Too lazy to do boundary checking
            tilesRows = [initRow, initRow, initRow+1, initRow+1];
            tilesCols = [initCol, initCol+1, initCol, initCol+1];
            
            obj.pTiles = sub2ind([obj.pNumberOfRows, obj.pNumberOfCols], ...
                tilesRows, tilesCols);
        end
        
        function isTileValid = isValid(obj)
            isTileValid = true;
        end
        
        function rotate(obj)
            % Do nothing
        end
        
    end % End of public methods
end % End of classdef