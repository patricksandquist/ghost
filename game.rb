class Game
  def initialize(player1)
    # Add player2 later
    @player1 = player1
    @losses = {@player1 => 0}
    populate_dictionary
    run
  end

  private

  def run
    @current_player = @player1

    until @losses.values.any? { |losses| losses >= 5 }
      play_round
    end

    @losses.each do |player, losses|
      loser = player if losses >= 5
    end

    puts "The game is over, #{loser.name} has GHOST!"
  end

  def play_round
    @fragment = ""

    until round_over?
      take_turn()
      @losses[@current_player] += 1 if round_over?
      next_player!
    end
  end

  def take_turn(player)
    # Get valid play from player
    valid_play = false
    until valid_play
      letter = player.get_play

      if valid_play?(letter)
        # Change the flag to exit loop
        valid_play = true
      else
        # Let the player know that it was a bad guess
        player.alert_invalid_guess
      end
    end

    @fragment += letter
  end

  def next_player!
    # do nothing now
  end

  def valid_play?(letter)
    return false unless letter.length == 1 && letter.downcase! =~ /[a-z]/

    new_fragment = @fragment + letter
    @dictionary.any? { |word, _| word.start_with?(new_fragment) }
  end

  def round_over?
    @dictionary.include?(@fragment)
  end

  def populate_dictionary
    # Create and populate our dictionary hash
    @dictionary = {}
    File.read("dictionary.txt").split("\n").each do |word|
      @dictionary[word] = true
    end
  end
end
