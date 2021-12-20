FF::Scn::BoidRules.add(
  FF::Sys.new('BoidMinimumSpeed', priority: 98) do
    FF::Cmp::BoidMinimumSpeed.each do |minspeed_component|
      boid = minspeed_component.entities[0].components[FF::Cmp::Boid][0]
      mag = Math.sqrt((boid.vx ** 2) + (boid.vy ** 2))
      if mag < minspeed_component.speed
        boid.vx = (boid.vx / mag) * minspeed_component.speed
        boid.vy = (boid.vy / mag) * minspeed_component.speed
      end
    end
  end
)

