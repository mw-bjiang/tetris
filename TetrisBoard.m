classdef (Sealed) TetrisBoard < handle % Singleton 
    properties (Access = public)
        pHeight
        pWidth
        pBoardMatrix
    end % End of private properties
    
    
    events
        boardUpdate
    end
    
    
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
            nrows = obj.pHeight;
            ncols = obj.pWidth;
        end
        
        function aMatrix = getBoardMatrix(obj)
            aMatrix = obj.pBoardMatrix;
        end
        
        function obj = setTiles(obj, indexList)
            % This function sets tiles specified in indexList to 1.
            % indexList is an array of linear indices for pBoardMatrix.
            % No boundary check. Tests should discover out-of-range
            % indices.
            obj.pBoardMatrix(indexList) = 1;
            notify(obj, 'boardUpdate');
        end % End of setTiles
        
        function obj = clearTiles(obj, indexList)
            % This function sets tiles specified in indexList to 0.
            % indexList is an array of linear indices for pBoardMatrix.
            obj.pBoardMatrix(indexList) = 0;
            notify(obj, 'boardUpdate');
        end % End of clearTiles
    end % End of public methods
    
    
    methods (Access = private)
        function boardObj = TetrisBoard(height, width)
            boardObj.pHeight = height;
            boardObj.pWidth  = width;
            boardObj.pBoardMatrix = zeros(height, width);
        end % End of private ctor
    end % End of private methods
end % End of classdef