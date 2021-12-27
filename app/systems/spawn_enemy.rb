FF::Scn::BoidRules.add(
  FF::Sys.new("SpawnEnemy", priority: 500) do
    while FF::Cmp::SingletonEnemyTeam[0].entities.length < 16
      position_range = ((1280*2.5).to_i..(1280*3)).to_a
      posneg = [1,-1]
      Factory::SampleEnemy.new(x: position_range.sample * posneg.sample, y: position_range.sample * posneg.sample)
    end
  end
)
