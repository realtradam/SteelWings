FF::Sys.new("Scatter", priority: 40) do
  FF::Cmp::SingletonRandomAIPick[0].entities.each do |entity|
    sep = entity.components[FF::Cmp::BoidsSeparation][0]
    # I did times 3 becase then it will always be greater then
    # what it was before and that means it will force a
    # seperation to happen even if the default value is
    # changed and you forget to update this number here
    sep.distance = Factory::SampleEnemy.defaults[:boids_seperation_distance] * 10
    sep.strength = Factory::SampleEnemy.defaults[:boids_seperation_strength]
    #puts 'remove align/cohesion/follow'.upcase
    alignment_mgr = entity.components[FF::Cmp::BoidsAlignment]
    cohesion_mgr = entity.components[FF::Cmp::BoidsCohesion]
    follow_mgr = entity.components[FF::Cmp::Follow]
    unless follow_mgr.nil? || follow_mgr.empty?
      follow_mgr[0].delete
    end
    unless alignment_mgr.nil? || alignment_mgr.empty?
      alignment_mgr[0].delete
    end
    unless cohesion_mgr.nil? || cohesion_mgr.empty?
      cohesion_mgr[0].delete
    end
  end
end
