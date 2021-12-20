FF::Scn::BoidRules.add(
  FF::Sys.new('PlayerWeapon') do
    if $gtk.args.inputs.mouse.down
      player = FF::Cmp::SingletonPlayer[0].entities[0]
      boid = player.components[FF::Cmp::Boid][0]
      weapon = player.components[FF::Cmp::Weapon][0]
      if player.components[FF::Cmp::Weapon][0].cooldown <= 0
        # spawn bullet facing correct angle
        mag = Math.sqrt((boid.vx ** 2) + (boid.vy ** 2))
        bullet = Factory::Bullet.new(damage: weapon.damage, vx: (boid.vx/mag) * weapon.speed, vy: (boid.vy/mag) * weapon.speed, x: boid.x, y: boid.y)
        bullet.remove(bullet.components[FF::Cmp::Team][0])
        bullet.add(FF::Cmp::Team.new(team: 'player'))
      end
    end
  end
)
