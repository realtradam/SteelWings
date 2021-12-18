FF::Ent.new(FF::Cmp::Sprite.new,
            FF::Cmp::Boid.new(x: 10, y: 10, vx: 0, vy: 0),
            FF::Cmp::BoidBounds.new,
            FF::Cmp::BoidsCohesion.new)
FF::Ent.new(FF::Cmp::Sprite.new,
            FF::Cmp::Boid.new(x: 50, y: 50),
            FF::Cmp::BoidBounds.new,
            FF::Cmp::BoidsCohesion.new)
FF::Ent.new(FF::Cmp::Sprite.new,
            FF::Cmp::Boid.new(x: 70, y: 20),
            FF::Cmp::BoidBounds.new,
            FF::Cmp::BoidsCohesion.new)
FF::Ent.new(FF::Cmp::DebugVectorArrow.new(length: 5),
            FF::Cmp::Sprite.new,
            FF::Cmp::Boid.new(x: 150, y: 250),
            FF::Cmp::BoidBounds.new,
            FF::Cmp::BoidsCohesion.new)
FF::Scn::Debug.add(FF::Sys::DebugRenderVectorArrow)
@pause = false
def tick args
  args.outputs.background_color = [0,0,0]
  FelFlame::Stage.call
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
