FF::Scn::BoidRules.add(
  FF::Sys.new('Follow', priority: 70) do
    FF::Cmp::Follow.each do |follow|
      boid = follow.entities[0].components[FF::Cmp::Boid][0]
      target_coords = [0.0, 0.0]
      case follow.target
      when FF::Cmp::Boid
        target_coords[0] = follow.target.x
        target_coords[1] = follow.target.y
      when Array
        target_coords[0] = follow.target[0]
        target_coords[1] = follow.target[1]
      when :mouse
        camera = FF::Cmp::SingletonCamera[0]
        angle = camera.angle * (Math::PI / 180)
        mouse = $gtk.args.inputs.mouse
        half_width = $gtk.args.grid.w * 0.5
        half_height = $gtk.args.grid.h * 0.5
        target_coords[0] = (((mouse.x - half_width) / camera.zoom) * Math.cos(-angle)) - (((mouse.y - half_height) / camera.zoom) * Math.sin(-angle)) + camera.x
        target_coords[1] = (((mouse.x - half_width) / camera.zoom) * Math.sin(-angle)) + (((mouse.y - half_height) / camera.zoom) * Math.cos(-angle)) + camera.y
      end

      boid.cx += (target_coords[0] - boid.x) / follow.strength.to_f
      boid.cy += (target_coords[1] - boid.y) / follow.strength.to_f
    end
  end
)
