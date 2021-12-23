FF::Sys.new("Rejoin", priority: 40) do
  FF::Cmp::BoidsSeparation.each do |sep|
    #puts 'add align/cohesion'.upcase
    sep.distance = 150 
    alignment_mgr = sep.entities[0].components[FF::Cmp::BoidsAlignment]
    cohesion_mgr = sep.entities[0].components[FF::Cmp::BoidsCohesion]
    if alignment_mgr.nil? || alignment_mgr.empty?
      sep.entities[0].add FF::Cmp::BoidsAlignment.new(strength: 10)
    end
    if cohesion_mgr.nil? || cohesion_mgr.empty?
      sep.entities[0].add FF::Cmp::BoidsCohesion.new(strength: 1000)
    end
  end
end
