classdef (Sealed) TetrisGame < handle % Singleton game class
    properties (Access = public)
        pBoardHeight = 24;
        pBoardWidth  = 10;
        pBoardObj;              % Board object
        pBoardViewer;           % Board viewer object
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
            aTetromino = aFactory.getTetromino(-1, [2, 4]);
            
            for idx = 1 : 26 % Main loop
                pause(0.3);
                aTetromino.moveDown;
            end
        end % End of startGame
    end % End of public methods
    
    
    methods (Access = private)
        function gameObj = TetrisGame
            % Use default board height and width
            gameObj.pBoardObj = TetrisBoard.createBoard( ...
                gameObj.pBoardHeight, gameObj.pBoardWidth);
            gameObj.pBoardViewer = BoardViewer(gameObj.pBoardObj);
        end % End of private ctor
    end % End of private methods
    
end % End of classdef