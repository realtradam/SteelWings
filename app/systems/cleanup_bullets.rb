FF::Scn::Cleanup.add(
  FF::Sys.new('CleanupBullets', priority: 99) do
    FF::Cmp::SingletonBullet[0].entities.each do |ent|
      sprite = ent.components[FF::Cmp::Sprite][0].props
      hp = ent.components[FF::Cmp::Hp][0]
      if sprite.x < 0 or sprite.x > $gtk.args.grid.w or sprite.y < 0 or sprite.y > $gtk.args.grid.h
        hp.health = -1
      end
    end
  end
)
