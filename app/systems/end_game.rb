FF::Sys.new('EndGame', priority: 50) do
  FF::Scn::BoidRules.remove(FF::Sys::Follow, FF::Sys::RandomizeAI)
  overlay_sprite = FF::Cmp::Sprite.new
  overlay_sprite.props.merge!({
    x: 0,
    y: 0,
    w: $gtk.args.grid.w,
    h: $gtk.args.grid.h,
    path: 'sprites/title/overlay.png'
  })
  gameover_sprite = FF::Cmp::Sprite.new
  gameover_sprite.props.merge!({
    x: 1280/2 - 643/2,
    y: 500,
    w: 643,
    h: 76,
    path: 'sprites/title/gameover.png'
  })
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
    overlay_sprite,
    gameover_sprite,
  )
  FF::Ent.new(
    FF::Cmp::Button.new(action: FF::Sys::ReturnToMenu, pressed_sprite_path: 'sprites/title/return_pressed.png', unpressed_sprite_path: 'sprites/title/return.png'),
    FF::Cmp::Hitbox.new(x: btn_x, y: btn_y, w: btn_w, h: btn_h),
    btn_sprite,
  )
end
