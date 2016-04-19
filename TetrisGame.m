classdef (Sealed) TetrisGame < handle % Singleton game class
    properties (Access = public)
        pBoardHeight = 24;
        pBoardWidth  = 10;
        pBoardObj;              % Board object
        pBoardViewer;           % Board viewer object
        pKeyPressListener;      % A listener to BoardViewer's KeyPressEvent
        pGameStatus = 0;        % 0: not started
                                % 1: ongoing
        pActiveTetromino
    end % End of private properties
    
    
    methods(Static)
        function gameSingleton = createGame
            persistent localObj;
            if isempty(localObj) || ~isvalid(localObj)
                localObj = TetrisGame;
            end
            gameSingleton = localObj;
        end
    end % End of static methods
    
    
    methods (Access = public)
        function obj = startGame(obj)
            % Try instantiating one tetromino and let it fall
            aFactory = TetriminosFactory(obj.pBoardObj);
            obj.pActiveTetromino = aFactory.getTetromino(-1, [2, 4]);

            obj.pGameStatus = 1;
            obj.pBoardViewer.toFront;
            % Game loop
            while obj.pGameStatus == 1
                pause(0.3);
                obj.pActiveTetromino.moveDown;
                
                if ~obj.pActiveTetromino.positionChanged
                    obj.pActiveTetromino = aFactory.getTetromino(-1, [2, 4]);
                end
            end
%             for idx = 1 : 5 % Main loop
%                 pause(0.3);
%                 aTetromino.moveLeft;
%             end
%             
%             for idx = 1 : 5
%                 pause(0.3);
%                 aTetromino.moveRight;
%             end
        end % End of startGame
    end % End of public methods
    
    
    methods (Access = private)
        function gameObj = TetrisGame
            % Use default board height and width
            gameObj.pBoardObj = TetrisBoard.createBoard( ...
                gameObj.pBoardHeight, gameObj.pBoardWidth);
            gameObj.pBoardViewer = BoardViewer(gameObj.pBoardObj);
            gameObj.pKeyPressListener = addlistener( ...
                gameObj.pBoardViewer, 'KeyPressEvent', @gameObj.keyPressEventHandler);
        end % End of private ctor
        
        function keyPressEventHandler(obj, ~, eventdata)
            keypressData = eventdata.pKeyPressEventObj;
            
            if obj.pGameStatus == 1
                switch keypressData.Key
                    case 'escape'
                        obj.pGameStatus = 0;
                    case 'leftarrow'
                        obj.pActiveTetromino.moveLeft;
                    case 'rightarrow'
                        obj.pActiveTetromino.moveRight;
                    case 'downarrow'
                        obj.pActiveTetromino.moveDown;
                    case 'uparrow'
                        obj.pActiveTetromino.rotate;
                end
            end
        end % End of keyPressEventHandler
    end % End of private methods
    
end % End of classdef