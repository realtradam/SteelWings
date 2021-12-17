FF::Scn::Render.add(
  FF::Sys.new('UpdateBoidSprite', priority: 98) do
    FF::Cmp::Boid.each do |boid|
      boid.entities[0].components[FF::Cmp::Sprite][0].props[:x] = boid.x
      boid.entities[0].components[FF::Cmp::Sprite][0].props[:y] = boid.y
      # based on direction of the vector, needs to update the rotation of sprite too
    end
  end
)
