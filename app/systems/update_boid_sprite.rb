FF::Scn::Render.add(
  FF::Sys.new('UpdateBoidSprite', priority: 98) do
    FF::Cmp::Boid.each do |boid|
      boid.entities[0].components[FF::Cmp::Sprite][0].props[:x] = boid.x
      boid.entities[0].components[FF::Cmp::Sprite][0].props[:y] = boid.y
    end
  end
)
