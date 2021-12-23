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
        mouse_x = mouse.x
        mouse_y = mouse.y
        half_width = $gtk.args.grid.w * 0.5
        half_height = $gtk.args.grid.h * 0.5

        mag = Helpers::Vectors.magnitude(mouse_x,
                                         mouse_y,
                                         half_width,
                                         half_height) / camera.zoom
        if mag > half_height
          mouse_x = (((mouse_x - half_width) / mag) * half_height) + half_width
          mouse_y = (((mouse_y - half_height) / mag) * half_height) + half_height
        end
        #puts "x: #{mouse_x}"
        #puts "y: #{mouse_y}"
        #puts "x mag: #{mouse_x / mag}"
        #puts "y mag: #{mouse_y / mag}"
        $gtk.args.outputs.solids << [mouse_x, mouse_y, 250, 250, 255, 0, 0, 255]

        target_coords[0] = (((mouse_x - half_width) / camera.zoom) * Math.cos(-angle)) - (((mouse_y - half_height) / camera.zoom) * Math.sin(-angle)) + camera.x
        target_coords[1] = (((mouse_x - half_width) / camera.zoom) * Math.sin(-angle)) + (((mouse_y - half_height) / camera.zoom) * Math.cos(-angle)) + camera.y

      end

      boid.cx += (target_coords[0] - boid.x) * follow.strength.to_f
      boid.cy += (target_coords[1] - boid.y) * follow.strength.to_f
    end
  end
)
