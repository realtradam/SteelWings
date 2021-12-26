FF::Scn::UI.add(
  FF::Sys.new('ButtonHandler', priority: 50) do
    FF::Cmp::Button.each do |button|
      sprite = button.entities[0].components[FF::Cmp::Sprite][0]
      hitbox = button.entities[0].components[FF::Cmp::Hitbox][0]
      mouse = $gtk.args.inputs.mouse

      if button.clicked
        sprite.props[:path] = button.pressed_sprite_path
      else
        sprite.props[:path] = button.unpressed_sprite_path
      end

      if mouse.x > hitbox.x and mouse.x < hitbox.x + hitbox.w and mouse.y > hitbox.y and mouse.y < hitbox.y + hitbox.h
        if mouse.down
          button.clicked = true
        elsif mouse.up and button.clicked
          button.clicked = false
          button.action.call
        end
      else
        button.clicked = false
      end
    end
  end
)
