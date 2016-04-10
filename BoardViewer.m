classdef BoardViewer < handle
    properties (Access = public)
        pBoard TetrisBoard  % Restrict property values
        pAxes               % Axes object
        pSquareMatrix       % A cell array of rectangle objects representing 
                            % the board
        
    end % End of private properties
    
    
    methods (Access = public)
        function viewerObj = BoardViewer(aBoard)
            viewerObj.pBoard = aBoard;
            viewerObj.pAxes = viewerObj.createBoard;
            viewerObj.pSquareMatrix = viewerObj.populateBoard;
        end % End of ctor
        
        function delete(obj)
            if ~isempty(obj.pAxes) && isvalid(obj.pAxes)
                delete(obj.pAxes.Parent);
            end
        end % End of dtor
        
        function viewBoard(obj)
            % Linear indexing to iterate through the board
            matrixData = obj.pBoard.getBoardMatrix;
            for idx = 1 : numel(obj.pSquareMatrix)
                visibilityStr = 'off';
                if matrixData(idx) == 1
                    visibilityStr = 'on';
                end
                obj.pSquareMatrix(idx).Visible = visibilityStr;
            end
        end
    end % End of public methods
    
    
    methods (Access = private)
        function axObj = createBoard(obj)
            % Here we take simplicity over flexibility, which is probably
            % not a good idea in real-world design
            % For example, we assume an underlying axes and use the unit
            % length as the width of the square below.
            [nrows, ncols] = obj.pBoard.getSize;
            axObj = axes;
            axis equal;
            axObj.XLim = [0, ncols];
            axObj.YLim = [0, nrows];
            axObj.XTick = [];
            axObj.YTick = [];
            axObj.Box = 'on';
        end % End of createBoardView
        
        function squareMatrix = populateBoard(obj)
            [nrows, ncols] = obj.pBoard.getSize;
            squareMatrix = gobjects(nrows, ncols);
            
            for rowIdx = 1 : nrows
                for colIdx = 1 : ncols
                    squarePosition = [colIdx-1, nrows-rowIdx, 1, 1];
                    squareMatrix(rowIdx, colIdx) = ...
                        rectangle(obj.pAxes, ...
                            'Position', squarePosition, ...
                            'FaceColor', [105, 105, 105]/255);
                end
            end
        end % End of populateBoard
    end % End of private methods
end % End of classdef