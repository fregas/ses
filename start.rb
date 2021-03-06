#!/usr/bin/env ruby

require_relative './critter'
require_relative './dice'

puts "starting..."

$total = 0
@population = []

def fight_to_death(critter1,critter2)
  puts "----------------"
  puts "#{critter1.name} fights #{critter2.name}"
  puts
  rounds = 0
  while (critter1.alive && critter2.alive) && rounds < 50
    critter1.fight critter2
    critter2.fight critter1
    rounds += 1
  end
end


def winner_takes_all(critter)
  if critter.alive
    @population << critter.reproduce
    critter.heal
  else
    @population.delete(critter)
  end
end

critter = Critter.new
critter.attack = 5
critter.evade = 5
critter.health = 1
critter.damage = 1
critter.name = "critter"


for i in 1..20
  @population << critter.reproduce
end

for i in 1..15
  puts "Season #{i}"
  @population.each_with_index do |critter1,index|
    critter2 = @population[index + 1]
    if !critter2.nil?
      fight_to_death(critter1,critter2)
      puts "fight complete"
      winner_takes_all(critter1) if critter2.dead
      winner_takes_all(critter2) if critter1.dead
    end
  end
  @population.shuffle
end


puts "-------------------------"
puts "Season done:"
@population.each do |critter|
  puts critter.inspect
end




