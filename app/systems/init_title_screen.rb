FF::Sys.new('InitTitleScreen', priority: 1) do
  btn_w = 190
  btn_h = 49
  btn_x = 1280/2 - btn_w/2
  btn_y = 200
  
  FF::Cmp.new('Title').new
  #title_cmp = FF::Cmp::Title.new
  sprite = FF::Cmp::Sprite.new
  sprite.props[:x] = btn_x
  sprite.props[:y] = btn_y
  sprite.props[:w] = btn_w
  sprite.props[:h] = btn_h
  #sprite.props[:path] = 'sprites/title/start.png'
  # start button
  FF::Ent.new(
    FF::Cmp::Button.new(action: FF::Sys::StartGame, pressed_sprite_path: 'sprites/title/start_pressed.png', unpressed_sprite_path: 'sprites/title/start.png'),
    FF::Cmp::Hitbox.new(x: btn_x, y: btn_y, w: btn_w, h: btn_h),
    sprite,
    FF::Cmp::Title[0]
  )
end
