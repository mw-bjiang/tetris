classdef BoardViewer < handle
    properties (Access = public)
        pBoard TetrisBoard  % Restrict property values
        pFig                % Figure object
        pAxes               % Axes object
        pSquareMatrix       % A cell array of rectangle objects representing 
                            % the board
        pBoardListener      % A listener to boardUpdate event for TetrisBoard
        
    end % End of private properties
    
    events
        KeyPressEvent       % Key press event can only be associated with a
                            % figure. View would not handle this event. It
                            % simply notifies the controller
    end
    
    
    methods (Access = public)
        function viewerObj = BoardViewer(aBoard)
            viewerObj.pBoard = aBoard;
            [viewerObj.pFig, viewerObj.pAxes] = viewerObj.createBoard;
            viewerObj.pBoardListener = ...
                addlistener(viewerObj.pBoard, 'boardUpdate', @viewerObj.boardUpdateHandler);
            viewerObj.pSquareMatrix = viewerObj.populateBoard;
            viewerObj.viewBoard;
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
        end % End of viewBoard
        
        function setVisibility(obj, isVisible)
            if isVisible == true || strcmp(isVisible, 'on')
                visibilityStr = 'on';
            elseif isVisible == false || strcmp(isVisible, 'off')
                visibilityStr = 'off';
            else
                visibilityStr = 'off'; % default off
            end
            obj.pFig.Visible = visibilityStr;
        end
        
        function toFront(obj)
            % Bring the figure to front
            obj.pFig.Visible = 'on';
            figure(obj.pFig);
        end % End of toFront
    end % End of public methods
    
    
    methods (Access = private)
        function [figObj, axObj] = createBoard(obj)
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
            
            figObj = axObj.Parent;
            figObj.KeyPressFcn = @obj.broadcastKeyPressEvent;
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
        
        function boardUpdateHandler(obj, ~, ~)
            obj.viewBoard;
        end % boardUpdateHandler
        
        function broadcastKeyPressEvent(obj, ~, eventdata)
            % ~ (src): the figure object that triggers the event
            % eventdata: an object with properties:
            %   Character
            %   Modifier
            %   Key
            %   Source
            %   EventName
            keypressEventDataObj = KeyPressEventData(eventdata);
            notify(obj, 'KeyPressEvent', keypressEventDataObj);
        end % End of broadcastKeyPressEvent
    end % End of private methods
end % End of classdef