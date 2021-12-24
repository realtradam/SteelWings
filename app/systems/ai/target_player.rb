FF::Sys.new("TargetPlayer", priority: 40) do
  FF::Cmp::BoidsSeparation.each do |sep|
    #puts 'target player'.upcase
    sep.distance = 200
    follow_mgr = sep.entities[0].components[FF::Cmp::Follow]
    player_boid = FF::Cmp::SingletonPlayer[0].entities[0].components[FF::Cmp::Boid][0]
    if follow_mgr.nil? || follow_mgr.empty?
      sep.entities[0].add FF::Cmp::Follow.new(target: player_boid, strength: 1.2)
    end
  end
end
