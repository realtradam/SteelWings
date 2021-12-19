debug_arrow = FF::Cmp::DebugVectorArrow.new(length: 5)
position = [
  {x: 100, y: 100},
  {x: 500, y: 500},
  {x: 700, y: 200},
  {x: 150, y: 250},
]
position_range = (100..700).to_a

25.times do |pos|
  sprite = FF::Cmp::Sprite.new
  sprite.props[:path] = 'sprites/kenny/Ships/ship_0011.png'
  FF::Ent.new(
    FF::Cmp::Boid.new(x: position_range.sample, y: position_range.sample, vx: 25, vy: 25, w: sprite.props[:w], h: sprite.props[:h]),
    sprite,
    FF::Cmp::BoidBounds.new(strength: 1),
    FF::Cmp::BoidsAlignment.new(strength: 1),
    FF::Cmp::BoidsSeparation.new(distance: 150, strength: 0.01),
    FF::Cmp::BoidsCohesion.new(strength: 100),
    FF::Cmp::SingletonCamera[0],
    debug_arrow,
  )
end
#FF::Ent.new(
#  FF::Cmp::Sprite.new,
#  FF::Cmp::Boid.new(x: 150, y: 250),
#  FF::Cmp::BoidBounds.new,
#FF::Cmp::BoidsAlignment.new,
#  FF::Cmp::BoidsSeparation.new(strength: 1.0),
#  #FF::Cmp::BoidsCohesion.new,
#  debug_arrow,
#)
FF::Scn::Debug.add(FF::Sys::DebugRenderVectorArrow)
@pause = true
FF::Stg.remove FF::Scn::BoidRules
@camera = FF::Cmp::SingletonCamera[0]
def tick args
  args.outputs.background_color = [0,0,0]
  FelFlame::Stage.call

  # Moving Camera
  if args.inputs.keyboard.keys[:down_or_held].include?(:d)
    @camera.x += (Math.cos(-@camera.angle * (Math::PI / 180.0)) * 5)
    @camera.y += (Math.sin(-@camera.angle * (Math::PI / 180.0)) * 5)
  end
  if args.inputs.keyboard.keys[:down_or_held].include?(:a)
    @camera.x += (Math.cos(-@camera.angle * (Math::PI / 180.0)) * -5)
    @camera.y += (Math.sin(-@camera.angle * (Math::PI / 180.0)) * -5)
  end
  if args.inputs.keyboard.keys[:down_or_held].include?(:w)
    #@camera.y += 5
    @camera.x -= (Math.sin(-@camera.angle * (Math::PI / 180.0)) * 5)
    @camera.y += (Math.cos(-@camera.angle * (Math::PI / 180.0)) * 5)
  end
  if args.inputs.keyboard.keys[:down_or_held].include?(:s)
    #@camera.y -= 5
    @camera.x -= (Math.sin(-@camera.angle * (Math::PI / 180.0)) * -5)
    @camera.y += (Math.cos(-@camera.angle * (Math::PI / 180.0)) * -5)
  end
  if args.inputs.keyboard.keys[:down_or_held].include?(:q)
    @camera.angle += 3
  end
  if args.inputs.keyboard.keys[:down_or_held].include?(:e)
    @camera.angle -= 3
  end
  if args.inputs.keyboard.keys[:down_or_held].include?(:z)
    @camera.zoom *= 1.05
  end
  if args.inputs.keyboard.keys[:down_or_held].include?(:x)
    @camera.zoom *= 0.95
  end

  # Pausing
  if args.inputs.keyboard.keys[:down].include?(:right)
    FF::Scn::BoidRules.call
  end
  if args.inputs.keyboard.keys[:down].include?(:space)
    if @pause
      FF::Stg.remove FF::Scn::BoidRules
      @pause = false
    else
      FF::Stg.add FF::Scn::BoidRules
      @pause = true
    end
  end
end
