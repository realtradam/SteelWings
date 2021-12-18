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
    $gtk.args.outputs.lines << [ox, oy, vxtip, vytip, 255, 255, 0, 255]
    #$gtk.args.outputs.lines << [ox, oy, ox + (boid.cx * length * 10), oy + (boid.cy * length), 0, 255, 0, 255]
    $gtk.args.outputs.lines << [vxtip, vytip, vxtip + (boid.cx * length * 10), vytip + (boid.cy * length * 10), 0, 0, 255, 255]

  end
end
