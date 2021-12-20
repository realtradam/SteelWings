FF::Scn::BoidRules.add(
  FF::Sys.new('BoidsSeparation', priority: 50) do
    FF::Cmp::BoidsSeparation.each do |separation|
      newvec = [0.0, 0.0]
      boid_update = separation.entities[0].components[FF::Cmp::Boid][0]

      FF::Cmp::Boid.each do |boid_check|
        next if boid_check == boid_update

        if Math.sqrt(((-boid_check.x + boid_update.x)**2) + ((-boid_check.y + boid_update.y)**2)).abs < separation.distance
          #if (boid_check.x - boid_update.x).abs < separation.distance and (boid_check.y - boid_update.y).abs < separation.distance
          newvec[0] -= boid_check.x - boid_update.x
          newvec[1] -= boid_check.y - boid_update.y
        end
      end

      #unless separation.entities[0].components[FF::Cmp::SingletonDebugVectorArrow].nil?
      #  puts "newvec: #{newvec}"
      #  puts "cx: #{boid_update.cx} cy: #{boid_update.cy}"
      #  puts "vx: #{boid_update.vx} vy: #{boid_update.vy}"
      #end
      boid_update.cx += (newvec[0].to_f * separation.strength.to_f)
      boid_update.cy += (newvec[1].to_f * separation.strength.to_f)
    end
  end
)
