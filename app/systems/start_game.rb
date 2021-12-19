FF::Sys.new('StartGame', priority: 50 ) do
  FF::Cmp::Title[0].entities.each do |entity|
    entity.components[FF::Cmp::Sprite][0].delete
    entity.components[FF::Cmp::Button][0].delete
    entity.components[FF::Cmp::Hitbox][0].delete
    entity.delete
  end
  FF::Cmp::Title[0].delete
  FF::Stg.remove FF::Scn::TitleScreen

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
      debug_arrow,
      FF::Cmp::SingletonCamera[0],
    )
  end

  FF::Stg.add(
    FF::Scn::BoidRules,
    FF::Scn::Debug,
  )

  FF::Scn::Debug.add(FF::Sys::DebugRenderVectorArrow)
  @pause = false
  #FF::Stg.remove FF::Scn::BoidRules
end
