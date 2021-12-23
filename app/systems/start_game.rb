FF::Sys.new('StartGame', priority: 50 ) do
  thing = FF::Cmp::SingletonTitle[0].entities.clone
  thing.each do |entity|
    entity.components[FF::Cmp::Sprite][0].delete
    if (!entity.components[FF::Cmp::Button].nil? && !entity.components[FF::Cmp::Hitbox].nil?)
      entity.components[FF::Cmp::Hitbox][0].delete
      entity.components[FF::Cmp::Button][0].delete
    end 
    entity.delete
  end

  FF::Cmp::SingletonTitle[0].title_screen = false
  FF::Stg.remove FF::Scn::TitleScreen

  debug_arrow = FF::Cmp::SingletonDebugVectorArrow.new(length: 5)
  position = [
    {x: 100, y: 100},
    {x: 500, y: 500},
    {x: 700, y: 200},
    {x: 150, y: 250},
  ]
  position_range = (100..700).to_a

  sprite = FF::Cmp::Sprite.new
  sprite.props[:path] = 'sprites/background.png'
  FF::Ent.new(
    sprite,
    FF::Cmp::SingletonCamera[0],
    FF::Cmp::Boid.new(h: 1920 * 2, w: 1920 * 2)
  )
  #15.times do |pos|
  #  Factory::Osprey.new(x: position_range.sample, y: position_range.sample)
  #end

  sprite = FF::Cmp::Sprite.new
  sprite.props[:path] = [
    'sprites/kenny/Ships/Pintail.png',
    'sprites/kenny/Ships/Osprey.png',
    'sprites/kenny/Ships/Falcon.png',
    'sprites/kenny/Ships/Grosbeak.png',
  ].sample
  FF::Ent.new(
    FF::Cmp::Boid.new(x: position_range.sample, y: position_range.sample, vx: 25, vy: 25, w: 32, h: 32),
    sprite,
    debug_arrow,
    FF::Cmp::SingletonCamera[0],
    FF::Cmp::BoidBounds.new,
    FF::Cmp::Follow.new(target: :mouse, strength: 0.007),
    FF::Cmp::SingletonPlayer[0],
    FF::Cmp::Team.new(team: 'player'),
    FF::Cmp::Weapon.new,
    FF::Cmp::BoidMinimumSpeed.new(speed: 5),
    FF::Cmp::DecaySpeed.new(strength: 0.8),
  )



  FF::Stg.add(
    FF::Scn::BoidRules,
    FF::Scn::Camera,
    FF::Scn::Cleanup,
    FF::Scn::Debug,
  )

  FF::Scn::Debug.add(FF::Sys::DebugRenderVectorArrow)
  @pause = false
  #FF::Stg.remove FF::Scn::BoidRules
end
