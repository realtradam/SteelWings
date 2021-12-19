FF::Sys.new('DebugRenderVectorArrow', priority: 100) do
  FF::Cmp::DebugVectorArrow[0].entities.each do |entity|
    boid = entity.components[FF::Cmp::Boid][0]
    sprite = entity.components[FF::Cmp::Sprite][0]
    length = FF::Cmp::DebugVectorArrow[0].length
    #puts "vx: #{boid.vx}"
    #puts "cx: #{boid.cx}"
    boid_x = 0
    boid_y = 0
    boid_cx = 0
    boid_cy = 0
    boid_vx = 0
    boid_vy = 0
    vxtip = 0
    vytip = 0
    small_square = 15
    big_square = 25
    if !entity.components[FF::Cmp::SingletonCamera].nil? && !entity.components[FF::Cmp::SingletonCamera][0].nil?
      camera = FF::Cmp::SingletonCamera[0]
      vxtip = boid_x = sprite.props[:x]
      vytip = boid_y = sprite.props[:y]
      boid_vx = boid.vx * camera.zoom
      boid_vy = boid.vy * camera.zoom
      vxtip += ((Math.cos(camera.angle * (Math::PI / 180.0)) * boid_vx) * length) - ((Math.sin(camera.angle * (Math::PI / 180.0)) * boid_vy) * length)
      vytip += ((Math.sin(camera.angle * (Math::PI / 180.0)) * boid_vx) * length) + ((Math.cos(camera.angle * (Math::PI / 180.0)) * boid_vy) * length)
      boid_cx = (((Math.cos(camera.angle * (Math::PI / 180.0)) * boid.cx)) - ((Math.sin(camera.angle * (Math::PI / 180.0)) * boid.cy))) * camera.zoom
      boid_cy = (((Math.sin(camera.angle * (Math::PI / 180.0)) * boid.cx)) + ((Math.cos(camera.angle * (Math::PI / 180.0)) * boid.cy))) * camera.zoom
      half_height = sprite.props[:h] * 0.5
      half_width = sprite.props[:w] * 0.5
      vxtip += half_width
      vytip += half_height
      #boid_cx += half_width
      #boid_cy += half_height
      boid_x += half_width
      boid_y += half_height
      boid_vx += half_width
      boid_vy += half_height
      small_square *= camera.zoom
      big_square *= camera.zoom
    else
      vxtip = boid_x = boid.x
      vytip = boid_y = boid.y
      boid_cx = boid.cx
      boid_cy = boid.cy
      vxtip += (boid.vx * length)
      vytip += (boid.vy * length)
    end

    # Velocity
    $gtk.args.outputs.lines << [boid_x, boid_y, vxtip, vytip, 0, 255, 255, 255]
    $gtk.args.outputs.lines << [boid_x+1, boid_y, vxtip+1, vytip, 0, 255, 255, 255]
    $gtk.args.outputs.lines << [boid_x-1, boid_y, vxtip-1, vytip, 0, 255, 255, 255]
    $gtk.args.outputs.lines << [boid_x, boid_y+1, vxtip, vytip+1, 0, 255, 255, 255]
    $gtk.args.outputs.lines << [boid_x, boid_y-1, vxtip, vytip-1, 0, 255, 255, 255]
    #$gtk.args.outputs.lines << [boid.x, boid.y, boid.x + (boid.cx * length * 10), boid.y + (boid.cy * length), 0, 255, 0, 255]

    # Change in Velocity
    $gtk.args.outputs.lines << [vxtip, vytip, vxtip + (boid_cx * length * 10), vytip + (boid_cy * length * 10), 255, 0, 255, 255]
    $gtk.args.outputs.lines << [vxtip+1, vytip, vxtip+1 + (boid_cx * length * 10), vytip + (boid_cy * length * 10), 255, 0, 255, 255]
    $gtk.args.outputs.lines << [vxtip-1, vytip, vxtip-1 + (boid_cx * length * 10), vytip + (boid_cy * length * 10), 255, 0, 255, 255]
    $gtk.args.outputs.lines << [vxtip, vytip+1, vxtip + (boid_cx * length * 10), vytip+1 + (boid_cy * length * 10), 255, 0, 255, 255]
    $gtk.args.outputs.lines << [vxtip, vytip-1, vxtip + (boid_cx * length * 10), vytip-1 + (boid_cy * length * 10), 255, 0, 255, 255]

    # Square Velocity
    $gtk.args.outputs.borders << [vxtip - (big_square - 1), vytip - (big_square - 1), (big_square - 1) * 2, (big_square - 1) * 2, 0, 255, 255]
    $gtk.args.outputs.borders << [vxtip - big_square, vytip - big_square, (big_square) * 2, (big_square) * 2, 0, 255, 255]
    $gtk.args.outputs.borders << [vxtip - (big_square + 1), vytip - (big_square + 1), (big_square + 1) * 2, (big_square + 1) * 2, 0, 255, 255]

    # Square Change in Velocity
    $gtk.args.outputs.borders << [vxtip - (small_square - 1) + (boid_cx * length * 10), vytip - (small_square - 1) + (boid_cy * length * 10), (small_square - 1) * 2, (small_square - 1) * 2, 255, 0, 255, 255]
    $gtk.args.outputs.borders << [vxtip - small_square + (boid_cx * length * 10), vytip - small_square + (boid_cy * length * 10), (small_square) * 2, (small_square) * 2, 255, 0, 255, 255]
    $gtk.args.outputs.borders << [vxtip - (small_square + 1) + (boid_cx * length * 10), vytip - (small_square + 1) + (boid_cy * length * 10), (small_square + 1) * 2, (small_square + 1) * 2, 255, 0, 255, 255]
  end
end
