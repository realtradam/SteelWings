FF::Sys.new('DebugRenderVectorArrow', priority: 100) do
  FF::Cmp::DebugVectorArrow[0].entities.each do |entity|
    boid = entity.components[FF::Cmp::Boid][0]
    ox = boid.x + entity.components[FF::Cmp::Sprite][0].props.w / 2
    oy = boid.y + entity.components[FF::Cmp::Sprite][0].props.h / 2
    length = FF::Cmp::DebugVectorArrow[0].length
    #puts "vx: #{boid.vx}"
    #puts "cx: #{boid.cx}"
    vxtip = ox + (boid.vx * length)
    vytip = oy + (boid.vy * length)

    # Velocity
    $gtk.args.outputs.lines << [ox, oy, vxtip, vytip, 0, 255, 255, 255]
    $gtk.args.outputs.lines << [ox+1, oy, vxtip+1, vytip, 0, 255, 255, 255]
    $gtk.args.outputs.lines << [ox-1, oy, vxtip-1, vytip, 0, 255, 255, 255]
    $gtk.args.outputs.lines << [ox, oy+1, vxtip, vytip+1, 0, 255, 255, 255]
    $gtk.args.outputs.lines << [ox, oy-1, vxtip, vytip-1, 0, 255, 255, 255]
    #$gtk.args.outputs.lines << [ox, oy, ox + (boid.cx * length * 10), oy + (boid.cy * length), 0, 255, 0, 255]

    # Change in Velocity
    $gtk.args.outputs.lines << [vxtip, vytip, vxtip + (boid.cx * length * 10), vytip + (boid.cy * length * 10), 255, 0, 255, 255]
    $gtk.args.outputs.lines << [vxtip+1, vytip, vxtip+1 + (boid.cx * length * 10), vytip + (boid.cy * length * 10), 255, 0, 255, 255]
    $gtk.args.outputs.lines << [vxtip-1, vytip, vxtip-1 + (boid.cx * length * 10), vytip + (boid.cy * length * 10), 255, 0, 255, 255]
    $gtk.args.outputs.lines << [vxtip, vytip+1, vxtip + (boid.cx * length * 10), vytip+1 + (boid.cy * length * 10), 255, 0, 255, 255]
    $gtk.args.outputs.lines << [vxtip, vytip-1, vxtip + (boid.cx * length * 10), vytip-1 + (boid.cy * length * 10), 255, 0, 255, 255]

    # Square Velocity
    $gtk.args.outputs.borders << [vxtip - 24, vytip - 24, 48, 48, 0, 255, 255]
    $gtk.args.outputs.borders << [vxtip - 25, vytip - 26, 52, 52, 0, 255, 255]
    $gtk.args.outputs.borders << [vxtip - 25, vytip - 25, 50, 50, 0, 255, 255]

    # Square Change in Velocity
    $gtk.args.outputs.borders << [vxtip - 14 + (boid.cx * length * 10), vytip - 14 + (boid.cy * length * 10), 28, 28, 255, 0, 255, 255]
    $gtk.args.outputs.borders << [vxtip - 15 + (boid.cx * length * 10), vytip - 15 + (boid.cy * length * 10), 30, 30, 255, 0, 255, 255]
    $gtk.args.outputs.borders << [vxtip - 16 + (boid.cx * length * 10), vytip - 16 + (boid.cy * length * 10), 32, 32, 255, 0, 255, 255]
  end
end
