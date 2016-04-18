classdef TetriminosFactory < handle
    properties (Access = public)
        pBoardObj TetrisBoard
        pNumberOfRows       % Factory doesn't need to know about the board,
        pNumberOfCols       % but it needs the number of rows and cols
        pTypeList
    end % End of private properties
    
    methods
        function obj = TetriminosFactory(aBoard)
            obj.pBoardObj = aBoard;
            [obj.pNumberOfRows, obj.pNumberOfCols] = aBoard.getSize;
            
            % Hard-code type list
            obj.pTypeList = {'Tetromino_T'}; % The string is just for doc purpose
        end
        
        function aTetromino = getTetromino(obj, index, initPosition)
            % Return a tetromino object based on index.
            % If index == -1, return a random type
            switch nargin
                case 1
                    index = -1;
                    initPosition = [2, 1];
                case 2
                    initPosition = [2, 1];
                case 3
                    % do nothing
                otherwise
                    ME = MException('TetriminosFactory:WrongInput', ...
                        'Wrong input for TetriminosFactory::getTetromino');
                    throw(ME);
            end
            
            nTypes = numel(obj.pTypeList);
            if index == -1
                index = randi(nTypes);
            end
            
            switch index
                case 1
                    aTetromino = Tetromino_T(obj.pBoardObj, initPosition);
            end
        end
    end % End of public methods
end % End of classdef