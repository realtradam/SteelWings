FF::Scn::BoidRules.add(
  FF::Sys.new('ResetChangeVector', priority: 45) do
    FF::Cmp::Boid.each do |boid|
      boid.cx = 0
      boid.cy = 0
    end
  end
)
