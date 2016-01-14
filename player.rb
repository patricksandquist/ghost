class Player
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

  def get_play
    puts "#{@name}, what is your guess?"
    gets.chomp
  end

  def alert_invalid_guess
    # system("clear")
    puts "#{@name}, that is an invalid guess!"
  end

  def ghost(losses)
    "GHOST"[0...losses]
  end
end
