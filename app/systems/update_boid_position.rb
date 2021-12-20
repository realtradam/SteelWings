FF::Scn::BoidRules.add(
  FF::Sys.new('UpdateBoidPosition', priority: 97) do
    FF::Cmp::Boid.each do |boid|
      boid.vx += boid.cx
      boid.vy += boid.cy
      boid.x += boid.vx
      boid.y += boid.vy

    end
  end
)
