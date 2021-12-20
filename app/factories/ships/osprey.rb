class Factory
  class Osprey
    def self.new(x: x, y: y)
      sprite = FF::Cmp::Sprite.new
      sprite.props[:path] = [
        'sprites/kenny/Ships/WeebillGrey.png',
        'sprites/kenny/Ships/BuntingGrey.png',
        'sprites/kenny/Ships/NighthawkGrey.png',
        'sprites/kenny/Ships/MagpieGrey.png',
        'sprites/kenny/Ships/WaxwingGrey.png',
        'sprites/kenny/Ships/LongspurGrey.png',
        'sprites/kenny/Ships/WarblerGrey.png',
        'sprites/kenny/Ships/NutcrackerGrey.png',
      ].sample
      FF::Ent.new(
        FF::Cmp::Boid.new(x: x, y: y, vx: -3, vy: -3, w: 32, h: 32),
        sprite,
        FF::Cmp::BoidBounds.new(strength: 0.6),
        FF::Cmp::BoidsAlignment.new(strength: 1),
        FF::Cmp::BoidsSeparation.new(distance: 150, strength: 0.001),
        FF::Cmp::BoidsCohesion.new(strength: 10000),
        FF::Cmp::Hp.new(health: 100),
        FF::Cmp::CollisionDamage.new(damage: 100),
        FF::Cmp::Hitcircle.new(r: 12),
        FF::Cmp::BoidMinimumSpeed.new(speed: 3),
        FF::Cmp::Team.new,
        FF::Cmp::SingletonDebugVectorArrow[0],
        FF::Cmp::SingletonCamera[0],
      )
    end
  end
end

