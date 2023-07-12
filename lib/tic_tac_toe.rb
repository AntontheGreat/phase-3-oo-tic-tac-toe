class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    # HELPER METHODS

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(num_str)
        num_str.to_i - 1
    end
    # Converts the user's input (a number from 1 to 9) into an array index (0 to 8).

    def move(index, token = "X")
        @board[index] = token
    end
    # Updates the game board with the player's move by placing their token (either "X" or "O") at the specified index.

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        index.between?(0, 8) && !position_taken?(index)
    end
    # checks if move is valid by ensuring that the index is within the valid range (0 to 8) and the position is not already taken.

    def turn_count
        @board.count{|square| square != " "} 
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please enter a number (1-9):"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
            token = current_player
            move(index, token)
        else
            turn
        end
        display_board
    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
                return combo
            end
        end
    end

    def full?
        @board.all? {|square| square != " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        if combo = won?
            @board[combo[0]]
        end
    end

    # GAME METHODS

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end