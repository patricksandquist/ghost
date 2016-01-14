require_relative 'player.rb'

class Game
  ALPHABET = ("a".."z").to_a

  def initialize(*players)
    @players = players
    @losses = {}
    @players.each { |player| @losses[player] = 0 }
    populate_dictionary
  end

  def run
    until @losses.values.any? { |losses| losses >= 5 }
      play_round
    end

    losing_hash = @losses.select do |player, losses|
      losses >= 5
    end

    puts "The game is over, #{losing_hash.keys[0].name} has GHOST!"
  end

  private

  def play_round
    @fragment = ""

    until round_over?
      take_turn(current_player)

      if round_over?
        puts "#{current_player.name} just spelled #{@fragment}!"
        @losses[current_player] += 1

        unless @losses[current_player] == 5
          ghost_frag = current_player.ghost(@losses[current_player])
          puts "#{current_player.name} now has #{ghost_frag}"
        end
      end

      next_player!
    end
  end

  def current_player
    @players.first
  end

  def take_turn(player)
    # Get valid play from player
    valid_play = false
    until valid_play
      puts "fragment: #{@fragment}"
      letter = player.get_play
      puts "letter: #{letter}"

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
    @players.rotate!
  end

  def valid_play?(letter)
    return false unless ALPHABET.include?(letter)

    new_fragment = @fragment + letter
    puts "new_fragment: #{new_fragment}"
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

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Player.new("Patrick"), Player.new("Other"))
  game.run
end
