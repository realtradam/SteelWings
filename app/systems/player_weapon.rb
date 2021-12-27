FF::Scn::BoidRules.add(
  FF::Sys.new('PlayerWeapon') do
    player = FF::Cmp::SingletonPlayer[0].entities[0]
    unless player.nil?
      weapon = player.components[FF::Cmp::Weapon][0]
      weapon.cooldown -= 1 unless weapon.cooldown <= 0
      if $gtk.args.inputs.mouse.button_left
        boid = player.components[FF::Cmp::Boid][0]
        if player.components[FF::Cmp::Weapon][0].cooldown <= 0
          weapon.cooldown += weapon.cooldown_max
          # spawn bullet facing correct angle
          mag = Math.sqrt((boid.vx ** 2) + (boid.vy ** 2))
          bullet = Factory::Bullet.new(damage: weapon.damage, vx: (boid.vx/mag) * weapon.speed, vy: (boid.vy/mag) * weapon.speed, x: boid.x, y: boid.y)
          bullet.remove(bullet.components[FF::Cmp::Team][0])
          bullet.add(FF::Cmp::Team.new(team: 'player'))
          $gtk.args.gtk.queue_sound "sounds/shoot.mp3"
        end
      end
    end
  end
)
