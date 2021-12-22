FF::Sys.new('InitTitleScreen', priority: 1) do
  btn_w = 190
  btn_h = 49
  btn_x = 1280/2 - btn_w/2
  btn_y = 200
  
  bg_sprite = FF::Cmp::Sprite.new
  title_sprite = FF::Cmp::Sprite.new
  btn_sprite = FF::Cmp::Sprite.new
  title_sprite.props[:x] = 1280/2 - 993/2
  title_sprite.props[:y] = 500
  title_sprite.props[:w] = 993
  title_sprite.props[:h] = 89
  title_sprite.props[:path] = 'sprites/title/title.png'
  bg_sprite.props[:x] = 0
  bg_sprite.props[:y] = 0
  bg_sprite.props[:w] = 1280
  bg_sprite.props[:h] = 720
  bg_sprite.props[:path] = 'sprites/title/titlebackground.png'
  btn_sprite.props[:x] = btn_x
  btn_sprite.props[:y] = btn_y
  btn_sprite.props[:w] = btn_w
  btn_sprite.props[:h] = btn_h
  FF::Ent.new(
    bg_sprite,
    FF::Cmp::SingletonTitle[0]
  )
  FF::Ent.new(
    FF::Cmp::Button.new(action: FF::Sys::StartGame, pressed_sprite_path: 'sprites/title/start_pressed.png', unpressed_sprite_path: 'sprites/title/start.png'),
    FF::Cmp::Hitbox.new(x: btn_x, y: btn_y, w: btn_w, h: btn_h),
    btn_sprite,
    FF::Cmp::SingletonTitle[0]
  )
  FF::Ent.new(
    title_sprite,
    FF::Cmp::SingletonTitle[0]
  )

end
