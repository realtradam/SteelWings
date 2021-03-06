FF::Scn::BoidRules.add(
  FF::Sys.new('DecaySpeed', priority: 50) do
    FF::Cmp::DecaySpeed.each do |decay|
      boid = decay.entities[0].components[FF::Cmp::Boid][0]
      #boid.vx *= decay.strength
      #boid.vy *= decay.strength
      boid.cx += (boid.vx * decay.strength) - boid.vx
      boid.cy += (boid.vy * decay.strength) - boid.vy
    end
  end
)
