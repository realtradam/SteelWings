FF::Scn::Render.add(
  FF::Sys.new('Render', priority: 99) do
    FF::Cmp::Sprite.each do |sprite|
      $gtk.args.outputs.sprites << sprite.props
    end
    FF::Cmp::Label.each do |label|
      $gtk.args.outputs.labels << label.props
    end
  end
)
