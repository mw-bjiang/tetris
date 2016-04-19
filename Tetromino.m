classdef (Abstract) Tetromino < handle
    properties (Access = protected)
        pBoardObj TetrisBoard
        pNumberOfRows
        pNumberOfCols
        pTiles              % 1-by-4 array which represents a tetromino's position on the board
                            % Linear indexing
        pRotationEnum = 1;  % Enumeration: 1, 2, 3, 4
        pPositionChanged    % A boolean indicating whether the position changed
    end % End of protected properties
    
    
    methods (Abstract)
        output = isValid(obj)
    end % End of abstract methods
    
    
    methods
        function obj = Tetromino(aBoard)
            obj.pBoardObj = aBoard;
            [obj.pNumberOfRows, obj.pNumberOfCols] = aBoard.getSize;
            obj.pPositionChanged = 1;
        end % End of abstract constructor
        
        function ischanged = positionChanged(obj)
            ischanged = obj.pPositionChanged;
        end % End of positionChanged
        
        function moveDown(obj)
            obj.pBoardObj.clearTiles(obj.pTiles);
            obj.verticalMove(1);
            obj.pBoardObj.setTiles(obj.pTiles);
        end % End of fall
        
        function moveLeft(obj)
            obj.pBoardObj.clearTiles(obj.pTiles);
            obj.horizontalMove(-1);
            obj.pBoardObj.setTiles(obj.pTiles);
        end
        
        function moveRight(obj) 
            obj.pBoardObj.clearTiles(obj.pTiles);
            obj.horizontalMove(1);      
            obj.pBoardObj.setTiles(obj.pTiles);
        end
        
        function rotate(obj, centerIdx)
            obj.pBoardObj.clearTiles(obj.pTiles);
            
            % Rotate the tetromino clockwise
            nrows = obj.pNumberOfRows;
            ncols = obj.pNumberOfCols;
            
            [rowIndices, colIndices] = ind2sub([nrows, ncols], obj.pTiles);
            relativeRows = rowIndices - rowIndices(centerIdx);
            relativeCols = colIndices - colIndices(centerIdx);
            
            % Rotation matrix: [0, 1; -1, 0]
            newIndices = [0, 1; -1, 0] * [relativeCols; relativeRows];
            newRowIndices = newIndices(2, :) + rowIndices(centerIdx);
            newColIndices = newIndices(1, :) + colIndices(centerIdx);
            
            obj.pPositionChanged = false;
            if ~obj.isTetrominoBlocked(newRowIndices, newColIndices)
                rowIndices = newRowIndices;
                colIndices = newColIndices;
                obj.pPositionChanged = true;
            end
            
            obj.pTiles = sub2ind([nrows, ncols], rowIndices, colIndices);
            obj.pBoardObj.setTiles(obj.pTiles);
        end
    end % End of public methods
    
    methods (Access = protected)
        function isblocked = isTetrominoBlocked(obj, rowIndices, colIndices)
            % This function is used to determine whether a tetromino can
            % move to a new place by checking if there is already a
            % filled tile in the new position.
            isblocked = false;
            
            nrows = obj.pNumberOfRows;
            ncols = obj.pNumberOfCols;
            
            % Check boundaries
            if min(colIndices) < 1
                isblocked = true;
                return;
            end
            
            if max(colIndices) > ncols
                isblocked = true;
                return;
            end
            
            if max(rowIndices) > nrows
                isblocked = true;
                return;
            end
            
            % Check collision
            tiles = sub2ind([nrows, ncols], rowIndices, colIndices);
            brdMatrix = obj.pBoardObj.getBoardMatrix;
            tileValue = brdMatrix(tiles);
            if any(tileValue)
                isblocked = true;
                return;
            end
        end % End of isTetrominoBlocked
        
        function horizontalMove(obj, dir)
            % Move the tetromino horizontally.
            % dir = -1: left
            % dir = 1 : right
            nrows = obj.pNumberOfRows;
            ncols = obj.pNumberOfCols;
            
            [rowIndices, colIndices] = ind2sub([nrows, ncols], obj.pTiles);
            colIndices = colIndices + dir;
            obj.pPositionChanged = true;
            
            if obj.isTetrominoBlocked(rowIndices, colIndices)
                colIndices = colIndices - dir;
                obj.pPositionChanged = false;
            end
            
            obj.pTiles = sub2ind([nrows, ncols], rowIndices, colIndices);
        end % End of horizontalMove
        
        function verticalMove(obj, dir)
            % Move the tetromino vertically.
            % dir = 1 : down
            % dir = -1: up
            nrows = obj.pNumberOfRows;
            ncols = obj.pNumberOfCols;
            
            [rowIndices, colIndices] = ind2sub([nrows, ncols], obj.pTiles);
            rowIndices = rowIndices + dir;
            obj.pPositionChanged = true;
            
            if obj.isTetrominoBlocked(rowIndices, colIndices)
                rowIndices = rowIndices - 1;
                obj.pPositionChanged = false;
            end
            
            obj.pTiles = sub2ind([nrows, ncols], rowIndices, colIndices);
        end % End of verticalMove
    end % End of private methods
end 