classdef Tetromino_I < Tetromino
% Initial shape of the tetromino:
%   * * * *
%
%   Order in pTiles:
%   1 2 3 4
%       
% Use tile 3 as the rotation center
% Initial position is specified by the leftmost tile
    methods
        function obj = Tetromino_I(aBoard, initPosition)
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
            tilesRows = [initRow, initRow, initRow, initRow];
            tilesCols = [initCol, initCol+1, initCol+2, initCol+3];
            
            obj.pTiles = sub2ind([obj.pNumberOfRows, obj.pNumberOfCols], ...
                tilesRows, tilesCols);
        end
        
        function isTileValid = isValid(obj)
            isTileValid = true;
        end
        
        function rotate(obj)
            centerIdx = 3;
            rotate@Tetromino(obj, centerIdx);
        end
        
    end % End of public methods
end % End of classdef