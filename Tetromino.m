classdef (Abstract) Tetromino < handle
    properties (Access = protected)
        pBoardObj TetrisBoard
        pTiles          % 1-by-4 array which represents a tetromino's position on the board
                        % Linear indexing        
    end % End of protected properties
    
    
    methods (Abstract)
        output = isValid(obj)
        obj = rotate(obj, direction)
    end % End of abstract methods
    
    
    methods
        function obj = moveDown(obj)
            obj.pBoardObj.clearTiles(obj.pTiles);
            
            [nrows, ncols] = obj.pBoardObj.getSize;
            [rowIndices, colIndices] = ind2sub([nrows, ncols], obj.pTiles);
            rowIndices = rowIndices + 1;
            if max(rowIndices) > nrows
                rowIndices = rowIndices - 1;
            end
            
            obj.pTiles = sub2ind([nrows, ncols], rowIndices, colIndices);
            obj.pBoardObj.setTiles(obj.pTiles);
        end % End of fall
        
        function obj = moveLeft(obj)
            obj.pBoardObj.clearTiles(obj.pTiles);
            
            [nrows, ncols] = obj.pBoardObj.getSize;
            [rowIndices, colIndices] = ind2sub([nrows, ncols], obj.pTiles);
            colIndices = colIndices - 1;
            
            if min(colIndices) < 1 % Primary out of range check
                colIndices = colIndices + 1;
            end
            
            obj.pTiles = sub2ind([nrows, ncols], rowIndices, colIndices);
            obj.pBoardObj.setTiles(obj.pTiles);
        end
        
        function obj = moveRight(obj) 
            obj.pBoardObj.clearTiles(obj.pTiles);
            
            [nrows, ncols] = obj.pBoardObj.getSize;
            [rowIndices, colIndices] = ind2sub([nrows, ncols], obj.pTiles);
            colIndices = colIndices + 1;
            
            if max(colIndices) > ncols % Primary out of range check
                colIndices = colIndices - 1;
            end
            
            obj.pTiles = sub2ind([nrows, ncols], rowIndices, colIndices);
            obj.pBoardObj.setTiles(obj.pTiles);
        end
    end % End of public methods
end 