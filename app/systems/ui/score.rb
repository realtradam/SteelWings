FF::Sys.new("Score", priority: 50) do
  score = FF::Cmp::SingletonScore[0]
  score.score += 100
  score.entities[0].components[FF::Cmp::Label].each do |label|
    label.props[:text] = score.score.to_s
  end
end
