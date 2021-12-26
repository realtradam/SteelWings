FF::Sys.new('InitTitleScreen', priority: 1) do
  FF::Stg.remove(
    FF::Scn::BoidRules,
    FF::Scn::Camera,
    FF::Scn::Cleanup,
  )
  bg_sprite = FF::Cmp::Sprite.new
  bg_sprite.props.merge!({
    x: 0,
    y: 0,
    w: 1280,
    h: 720,
    path: 'sprites/title/titlebackground.png'
  })
  title_sprite = FF::Cmp::Sprite.new
  title_sprite.props.merge!({
    x: 1280/2 - 993/2,
    y: 500,
    w: 993,
    h: 89,
    path: 'sprites/title/title.png'
  })
  btn_sprite = FF::Cmp::Sprite.new
  btn_w = 190
  btn_h = 49
  btn_x = 1280/2 - btn_w/2
  btn_y = 200
  btn_sprite.props.merge!({
    x: btn_x,
    y: btn_y,
    w: btn_w,
    h: btn_h,
  })
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
