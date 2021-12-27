FF::Sys.new('StartGame', priority: 50 ) do
  FF::Cmp::SingletonTitle[0].entities.reverse_each do |entity|
    entity.components[FF::Cmp::Sprite][0].delete
    if (!entity.components[FF::Cmp::Button].nil? && !entity.components[FF::Cmp::Hitbox].nil?)
      entity.components[FF::Cmp::Hitbox][0].delete
      entity.components[FF::Cmp::Button][0].delete
    end 
    entity.delete
  end

  #FF::Cmp::SingletonTitle[0].title_screen = false
  #FF::Stg.remove FF::Scn::TitleScreen

  debug_arrow = FF::Cmp::SingletonDebugVectorArrow[0]
  position = [
    {x: 100, y: 100},
    {x: 500, y: 500},
    {x: 700, y: 200},
    {x: 150, y: 250},
  ]
  position_range = (500..1000).to_a

  sprite = FF::Cmp::Sprite.new
  sprite.props[:path] = 'sprites/background.png'
  FF::Ent.new(
    sprite,
    FF::Cmp::SingletonCamera[0],
    FF::Cmp::Boid.new(h: 1920 * 2, w: 1920 * 2)
  )
  8.times do |pos|
    Factory::SampleEnemy.new(x: position_range.sample, y: position_range.sample)
  end

  sprite = FF::Cmp::Sprite.new
  sprite.props[:path] = [
    'sprites/kenny/Ships/Pintail.png',
    'sprites/kenny/Ships/Osprey.png',
    'sprites/kenny/Ships/Falcon.png',
    'sprites/kenny/Ships/Grosbeak.png',
  ].sample
  FF::Ent.new(
    FF::Cmp::Boid.new(x: 0, y: 0, vx: 25, vy: 25, w: 32, h: 32),
    sprite,
    debug_arrow,
    FF::Cmp::SingletonCamera[0],
    FF::Cmp::SingletonMoveCamera[0],
    FF::Cmp::BoidBounds.new,
    FF::Cmp::Follow.new(target: :mouse, strength: 0.007),
    FF::Cmp::SingletonPlayer[0],
    FF::Cmp::Team.new(team: 'player'),
    FF::Cmp::Weapon.new,
    FF::Cmp::BoidMinimumSpeed.new(speed: 5),
    FF::Cmp::DecaySpeed.new(strength: 0.8),
    FF::Cmp::Hp.new(health: 100),
    FF::Cmp::CollisionDamage.new(damage: 100),
    FF::Cmp::Hitcircle.new(r: 32),
  )

  score_label_shadow = FF::Cmp::Label.new
  score_label_shadow.props.merge!({
    x: 50,
    y: 667,
    text: '0',
    size_enum: 8,
    r: 100,
    g: 100,
    b: 100,
    font: 'fonts/kenvector_future_thin.ttf',
  })
  score_label = FF::Cmp::Label.new
  score_label.props.merge!({
    x: 50,
    y: 670,
    text: '0',
    size_enum: 8,
    font: 'fonts/kenvector_future_thin.ttf',
  })
  score = FF::Cmp::SingletonScore[0]
  score.score = 0
  FF::Ent.new(
    score_label,
    score_label_shadow,
    score,
  )

  FF::Stg.add(
    FF::Scn::BoidRules,
    FF::Scn::Camera,
    FF::Scn::Cleanup,
  )
  FF::Scn::Debug.add(FF::Sys::DebugRenderVectorArrow)
  @pause = false
  #FF::Stg.remove FF::Scn::BoidRules
end
