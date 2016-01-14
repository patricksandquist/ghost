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
      switch_players!
    end
  end

  def take_turn(player)
    # Get valid play from player
  end

  def switch_players!
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
