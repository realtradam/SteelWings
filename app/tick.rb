
#FF::Cmp::Boid.new(x: position_range.sample, y: position_range.sample, vx: 25, vy: 25, w: sprite.props[:w], h: sprite.props[:h]),
#FF::Cmp::SingletonCamera[0],

#@pause = false
@camera = FF::Cmp::SingletonCamera[0]
@scatter = false
@target = true
@timer = 0
FF::Sys::InitTitleScreen.call
def tick args
  #puts @timer
  @timer += 1
  if @timer >= 100 && !FF::Cmp::SingletonTitle[0].title_screen
    @timer -= 100
    puts "scatter: #{@scatter}"
    puts "target: #{@target}"
    @scatter = !@scatter
    if @scatter
      FF::Sys::Scatter.call
    elsif @target
      @target = false
      FF::Sys::Rejoin.call
    else
      @target = true
      FF::Sys::TargetPlayer.call
    end
  end

  args.outputs.background_color = [0,0,0]
  args.outputs.solids << [-10_000, -10_000, 20_000, 20_000, 223, 246, 245]

  FelFlame::Stage.call

  # Spawn Bullet
  if args.inputs.keyboard.keys[:down].include?(:b)
    Factory::Bullet.new(x: @camera.x, y: @camera.y)
  end

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
      FF::Stg.add FF::Scn::BoidRules
      @pause = false
    else
      FF::Stg.remove FF::Scn::BoidRules
      @pause = true
    end
  end
end
