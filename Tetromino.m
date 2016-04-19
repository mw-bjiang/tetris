classdef (Abstract) Tetromino < handle
    properties (Access = protected)
        pBoardObj TetrisBoard
        pNumberOfRows
        pNumberOfCols
        pTiles          % 1-by-4 array which represents a tetromino's position on the board
                        % Linear indexing        
    end % End of protected properties
    
    
    methods (Abstract)
        output = isValid(obj)
        rotate(obj, direction)
    end % End of abstract methods
    
    
    methods
        function obj = Tetromino(aBoard)
            obj.pBoardObj = aBoard;
            [obj.pNumberOfRows, obj.pNumberOfCols] = aBoard.getSize;
        end % End of abstract constructor
        
        function moveDown(obj)
            obj.pBoardObj.clearTiles(obj.pTiles);
            
            nrows = obj.pNumberOfRows;
            ncols = obj.pNumberOfCols;
            
            [rowIndices, colIndices] = ind2sub([nrows, ncols], obj.pTiles);
            rowIndices = rowIndices + 1;
            if max(rowIndices) > nrows
                rowIndices = rowIndices - 1;
            end
            
            obj.pTiles = sub2ind([nrows, ncols], rowIndices, colIndices);
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
    end % End of public methods
    
    methods (Access = private)
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
            % dir = 1: right
            nrows = obj.pNumberOfRows;
            ncols = obj.pNumberOfCols;
            
            [rowIndices, colIndices] = ind2sub([nrows, ncols], obj.pTiles);
            colIndices = colIndices + dir;
            
            if obj.isTetrominoBlocked(rowIndices, colIndices)
                colIndices = colIndices - dir;
            end
            
            obj.pTiles = sub2ind([nrows, ncols], rowIndices, colIndices);
        end % End of horizontalMove
    end % End of private methods
end 