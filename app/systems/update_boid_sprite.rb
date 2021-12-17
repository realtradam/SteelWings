FF::Scn::Render.add(
  FF::Sys.new('UpdateBoidSprite', priority: 98) do
    FF::Cmp::Boid.each do |boid|
      boid.vx += boid.cx
      boid.vy += boid.cy
      boid.x += boid.vx
      boid.y += boid.vy
      boid.entities[0].components[FF::Cmp::Sprite][0].props[:x] = boid.x
      boid.entities[0].components[FF::Cmp::Sprite][0].props[:y] = boid.y
      # based on direction of the vector, needs to update the rotation of sprite too
      boid.cx = 0
      boid.cy = 0
    end
  end
)
