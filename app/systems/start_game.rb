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

  5.times do |pos|
    Factory::Osprey.new(x: position_range.sample, y: position_range.sample)
  end

  FF::Stg.add(
    FF::Scn::BoidRules,
    FF::Scn::Debug,
  )

  FF::Scn::Debug.add(FF::Sys::DebugRenderVectorArrow)
  @pause = false
  #FF::Stg.remove FF::Scn::BoidRules
end
