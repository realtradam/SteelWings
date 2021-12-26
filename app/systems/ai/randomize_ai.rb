FF::Scn::AIRandomizer.add(
  FF::Sys.new('RandomizeAI', priority: 50) do
    timer = FF::Cmp::SingletonAITimer[0]
    timer.timer += 1
    if timer.timer > timer.interval
      random_ai_pick = FF::Cmp::SingletonRandomAIPick[0]
      random_ai_pick.entities.each do |entity|
        entity.remove random_ai_pick
        puts 'remove pick'
      end
      FF::Cmp::BoidsSeparation.each do |sep|
        if rand < 0.3
          sep.entities[0].add random_ai_pick
          puts 'pick'
        end
      end
      x = rand 3
      if x == 0
        FF::Sys::Scatter.call
        puts 'scatter'
      elsif x == 1
        FF::Sys::Rejoin.call
        puts 'rejoin'
      elsif x == 2
        FF::Sys::TargetPlayer.call
        puts 'target'
      end
      timer.interval = (300..1200).to_a.sample
      puts timer.interval
      timer.timer = 0
    end
  end
)
