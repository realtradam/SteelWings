FF::Scn::TitleScreen.add(
  FF::Sys.new('TitleScreen', priority: 50) do
    FF::Cmp::Title[0].entities.each do |entity|
      next unless entity.components.key?(FF::Cmp::Button)

      btn = entity.components[FF::Cmp::Button][0]
      sprite = entity.components[FF::Cmp::Sprite][0]
      hitbox = entity.components[FF::Cmp::Hitbox][0]
      mouse = $gtk.args.inputs.mouse

      if mouse.x > hitbox.x and mouse.x < hitbox.x + hitbox.w and mouse.y > hitbox.y and mouse.y < hitbox.y + hitbox.h
        if $gtk.args.inputs.mouse.down
          btn.clicked = true
          #sprite.props[:path] = ''
        else
          btn.clicked = false
          #sprite.props[:path] = ''
        end
        if $gtk.args.inputs.mouse.click
          btn.action.call
          puts 'click'
        end
      end
    end
  end
)
