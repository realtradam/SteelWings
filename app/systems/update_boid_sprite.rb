FF::Scn::Render.add(
  # Update the position of the boid sprite before
  # the camera and before its rendered
  FF::Sys.new('UpdateBoidSprite', priority: 95) do
    FF::Cmp::Boid.each do |boid|
      sprite = boid.entities[0].components[FF::Cmp::Sprite][0]
      sprite.props[:x] = boid.x - boid.h / 2
      sprite.props[:y] = boid.y - boid.w / 2

      diff_angle = (((Math.atan2(boid.vy, boid.vx) * 180.0) / Math::PI).round(3) - 90) - sprite.props[:angle]
      diff_angle = (diff_angle + 180) % 360 - 180
      sprite.props[:angle] += diff_angle
      sprite.props[:w] = boid.w
      sprite.props[:h] = boid.h
    end
  end
)
