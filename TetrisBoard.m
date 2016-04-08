classdef (Sealed) TetrisBoard < handle % Singleton 
    properties (Access = public)
        pHeight;
        pWidth;
        pBoardMatrix;
    end % End of private properties
    
    
    methods(Static)
        function boardSingleton = createBoard(height, width)
            persistent localObj;
            if isempty(localObj) || ~isvalid(localObj)
                localObj = TetrisBoard(height, width);
            end
            boardSingleton = localObj;
        end 
    end % End of static methods
    
    
    methods (Access = public)
        function [nrows, ncols] = getSize(obj)
            [nrows, ncols] = size(obj.pBoardMatrix);
        end
    end % End of public methods
    
    
    methods (Access = private)
        function boardObj = TetrisBoard(height, width)
            boardObj.pHeight = height;
            boardObj.pWidth  = width;
            boardObj.pBoardMatrix = zeros(height, width);
        end % End of private ctor
    end % End of private methods
end % End of classdef