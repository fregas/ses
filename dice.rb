
class Dice
  def self.roll(die: 20)
    (rand * die) + 1
  end
end
