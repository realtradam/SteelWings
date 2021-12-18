FF::Scn::Render.add(
  FF::Sys.new('UpdateBoidSprite', priority: 98) do
    FF::Cmp::Boid.each do |boid|
      sprite = boid.entities[0].components[FF::Cmp::Sprite][0]
      sprite.props[:x] = boid.x - sprite.props[:w] / 2
      sprite.props[:y] = boid.y - sprite.props[:h] / 2
    end
  end
)
