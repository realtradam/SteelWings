FF::Sys.new("Rejoin", priority: 40) do
  FF::Cmp::SingletonRandomAIPick[0].entities.each do |entity|
    sep = entity.components[FF::Cmp::BoidsSeparation][0]
    sep.distance = Factory::SampleEnemy.defaults[:boids_seperation_distance]
    sep.strength = Factory::SampleEnemy.defaults[:boids_seperation_strength]
    alignment_mgr = entity.components[FF::Cmp::BoidsAlignment]
    cohesion_mgr = entity.components[FF::Cmp::BoidsCohesion]
    if alignment_mgr.nil? || alignment_mgr.empty?
      entity.add FF::Cmp::BoidsAlignment.new(strength: Factory::SampleEnemy.defaults[:boids_alignment_strength])
    end
    if cohesion_mgr.nil? || cohesion_mgr.empty?
      entity.add FF::Cmp::BoidsCohesion.new(strength: Factory::SampleEnemy.defaults[:boids_cohesion_strength])
    end
  end
end
