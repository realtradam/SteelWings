FF::Scn::Camera.add(
  FF::Sys.new('MoveCamera', priority: 100) do
    unless FF::Cmp::SingletonPlayer[0].entities[0].nil?
      camera = FF::Cmp::SingletonCamera[0]
      player_boid = FF::Cmp::SingletonPlayer[0].entities[0].components[FF::Cmp::Boid][0]
      camera.x = player_boid.x
      camera.y = player_boid.y
    end
    #mouse = $gtk.args.inputs.mouse
    #camera_pos = [0,0]
    #
    #angle = camera.angle * (Math::PI / 180)
    #half_width = $gtk.args.grid.w * 0.5
    #half_height = $gtk.args.grid.h * 0.5
    #camera_pos[0] = (((((mouse.x - half_width) / camera.zoom) * Math.cos(-angle)) - (((mouse.y - half_height) / camera.zoom) * Math.sin(-angle)) + camera.x)-player_boid.x)/2
    #camera_pos[1] = (((((mouse.x - half_width) / camera.zoom) * Math.sin(-angle)) + (((mouse.y - half_height) / camera.zoom) * Math.cos(-angle)) + camera.y)-player_boid.y)/2

    #camera.x = camera_pos[0]
    #camera.y = camera_pos[1]
  end
)
