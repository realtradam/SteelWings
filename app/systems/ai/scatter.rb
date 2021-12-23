FF::Sys.new("Scatter", priority: 40) do
  FF::Cmp::BoidsSeparation.each do |sep|
    sep.distance = 200
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
