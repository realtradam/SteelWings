FF::Scn::Render.add(
  # Update the position of the sprite according
  # to camera values before the sprite is rendered
  FF::Sys.new('Camera', priority: 97) do
    camera = FF::Cmp::SingletonCamera[0]
    camera.entities.each do |ent|
      sprite = ent.components[FF::Cmp::Sprite][0].props

      angle = camera.angle * (Math::PI / 180)
      half_width = $gtk.args.grid.w * 0.5
      half_height = $gtk.args.grid.h * 0.5
      offset_x = sprite[:x] + (sprite[:w] / 2)
      offset_y = sprite[:y] + (sprite[:h] / 2)
      temp_x = (((offset_x - camera.x) * Math.cos(angle)) - ((offset_y - camera.y) * Math.sin(angle))) \
        * camera.zoom + half_width - (sprite[:w] * camera.zoom / 2)
      temp_y = (((offset_x - camera.x) * Math.sin(angle)) + ((offset_y - camera.y) * Math.cos(angle))) \
        * camera.zoom + half_height - (sprite[:h] * camera.zoom / 2)
      temp_rotate = sprite[:angle] + camera.angle
      temp_width = sprite[:w] * camera.zoom
      temp_height = sprite[:h] * camera.zoom

      sprite[:x] = temp_x
      sprite[:y] = temp_y
      sprite[:w] = temp_width
      sprite[:h] = temp_height
      sprite[:angle] = temp_rotate
    end
  end
)
