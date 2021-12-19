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
          sprite.props[:path] = btn.pressed_sprite_path
        elsif $gtk.args.inputs.mouse.up and btn.clicked
          btn.clicked = false
          sprite.props[:path] = btn.unpressed_sprite_path
          btn.action.call
        end
      else
        btn.clicked = false
        sprite.props[:path] = btn.unpressed_sprite_path
      end
    end
  end
)
