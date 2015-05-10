
class Critter
  attr_accessor :attack, :evade, :health, :damage, :name, :alive

  def fight(other_critter)

    my_attack = Dice.roll + self.attack
    their_evade = Dice.roll + other_critter.evade

    if my_attack >= their_evade
      current_damage = self.damage
      if current_damage < 1 
        current_damage = 1
      end

      other_critter.temp_health -= current_damage 

      puts "#{self.name} hits #{other_critter.name} for #{current_damage}"
      puts "#{other_critter.name} is #{other_critter.status} @ #{other_critter.temp_health}"
    else
      puts "#{self.name} missed #{other_critter.name}"
    end

    if other_critter.temp_health < 1
      puts "----------------------------"
    end

  end

  def alive
    temp_health > 0
  end

  def status
    if self.alive
      "alive"
    else
      "dead"
    end
  end

  def temp_health
    if @temp_health.nil?
      @temp_health = self.health
    end
    @temp_health
  end

  def temp_health=(value)
    @temp_health = value
  end

  def reproduce
    offspring = Critter.new
    offspring.attack = up_or_down self.attack 
    offspring.evade =  up_or_down self.evade
    offspring.health = up_or_down self.health
    offspring.damage = up_or_down self.damage
    offspring.name = "#{self.name}_#{$total}"
    $total += 1

    puts "#{self.name} sired #{offspring.name}"
    puts "--------------------------------"

    offspring
  end

  def up_or_down(original)
    adjust = (rand * 7).to_i - 3    
    original + adjust
  end
end
