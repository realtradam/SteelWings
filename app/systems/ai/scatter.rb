FF::Sys.new("Scatter", priority: 40) do
  FF::Cmp::BoidsSeparation.each do |sep|
    # I did times 3 becase then it will always be greater then
    # what it was before and that means it will force a
    # seperation to happen even if the default value is
    # changed and you forget to update this number here
    sep.distance = Factory::SampleEnemy.defaults[:boids_seperation_distance] * 3
    #puts 'remove align/cohesion/follow'.upcase
    alignment_mgr = sep.entities[0].components[FF::Cmp::BoidsAlignment]
    cohesion_mgr = sep.entities[0].components[FF::Cmp::BoidsCohesion]
    follow_mgr = sep.entities[0].components[FF::Cmp::Follow]
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
