FF::Sys.new('EndGame', priority: 1) do
  FF::Scn::BoidRules.remove(FF::Sys::Follow, FF::Sys::RandomizeAI)
  btn_w = 190
  btn_h = 49
  btn_x = 1280/2 - btn_w/2
  btn_y = 200
  btn_sprite = FF::Cmp::Sprite.new
  btn_sprite.props.merge!({
    x: btn_x,
    y: btn_y,
    w: btn_w,
    h: btn_h,
  })
  FF::Ent.new(
    FF::Cmp::Button.new(action: FF::Sys::StartGame, pressed_sprite_path: 'sprites/title/start_pressed.png', unpressed_sprite_path: 'sprites/title/start.png'),
    FF::Cmp::Hitbox.new(x: btn_x, y: btn_y, w: btn_w, h: btn_h),
    btn_sprite,
    FF::Cmp::SingletonTitle[0]
  )
end
