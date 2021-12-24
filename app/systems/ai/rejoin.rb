FF::Sys.new("Rejoin", priority: 40) do
  FF::Cmp::BoidsSeparation.each do |sep|
    #puts 'add align/cohesion'.upcase
    sep.distance = Factory::SampleEnemy.defaults[:boids_seperation_distance]
    alignment_mgr = sep.entities[0].components[FF::Cmp::BoidsAlignment]
    cohesion_mgr = sep.entities[0].components[FF::Cmp::BoidsCohesion]
    if alignment_mgr.nil? || alignment_mgr.empty?
      sep.entities[0].add FF::Cmp::BoidsAlignment.new(strength: Factory::SampleEnemy.defaults[:boids_alignment_strength])
    end
    if cohesion_mgr.nil? || cohesion_mgr.empty?
      sep.entities[0].add FF::Cmp::BoidsCohesion.new(strength: Factory::SampleEnemy.defaults[:boids_cohesion_strength])
    end
  end
end
