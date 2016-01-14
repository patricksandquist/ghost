class Player
  def initialize(name)
    @name = name
  end

  def get_play
    system("clear")
    puts "#{@name}, what is your guess?"
    gets.chomp
  end

  def alert_invalid_guess
    system("clear")
    puts "#{@name}, that is an invalid guess!"
  end
end
