FF::Scn::BoidRules.add(
  FF::Sys.new('BoidBounds', priority: 50) do
    FF::Cmp::BoidBounds.each do |boid_bounds|
      boid = boid_bounds.entities[0].components[FF::Cmp::Boid][0]

      if boid.x > boid_bounds.xmax
        boid.cx -= boid_bounds.strength
      elsif boid.x < boid_bounds.xmin
        boid.cx += boid_bounds.strength
      end

      if boid.y > boid_bounds.ymax
        boid.cy -= boid_bounds.strength
      elsif boid.y < boid_bounds.ymin
        boid.cy += boid_bounds.strength
      end
    end
  end
)

