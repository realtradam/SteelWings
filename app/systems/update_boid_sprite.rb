FF::Scn::Render.add(
  FF::Sys.new('UpdateBoidSprite', priority: 98) do
    FF::Cmp::Boid.each do |boid|
      sprite = boid.entities[0].components[FF::Cmp::Sprite][0]
      sprite.props[:x] = boid.x - sprite.props[:w] / 2
      sprite.props[:y] = boid.y - sprite.props[:h] / 2

      diff_angle = (((Math.atan2(boid.vy, boid.vx) * 180.0) / Math::PI).round(3) - 90) - sprite.props[:angle]
      diff_angle = (diff_angle + 180) % 360 - 180
      sprite.props[:angle] += diff_angle
    end
  end
)
