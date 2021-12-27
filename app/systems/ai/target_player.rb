FF::Sys.new("TargetPlayer", priority: 40) do
  FF::Cmp::SingletonRandomAIPick[0].entities.each do |entity|
    sep = entity.components[FF::Cmp::BoidsSeparation][0]
    sep.distance = Factory::SampleEnemy.defaults[:boids_seperation_distance]
    sep.strength = Factory::SampleEnemy.defaults[:boids_seperation_strength]
    follow_mgr = entity.components[FF::Cmp::Follow]
    player_boid = FF::Cmp::SingletonPlayer[0].entities[0].components[FF::Cmp::Boid][0]
    if follow_mgr.nil? || follow_mgr.empty?
      entity.add FF::Cmp::Follow.new(target: player_boid, strength: 0.6)
    end
  end
end
