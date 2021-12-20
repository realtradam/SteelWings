class Factory
  class Osprey
    def self.new(x: x, y: y)
      sprite = FF::Cmp::Sprite.new
      sprite.props[:path] = 'sprites/kenny/Ships/Osprey.png'
      FF::Ent.new(
        FF::Cmp::Boid.new(x: x, y: y, vx: 0, vy: 0, w: 32, h: 32),
        sprite,
        FF::Cmp::BoidBounds.new(strength: 0.6),
        FF::Cmp::BoidsAlignment.new(strength: 1),
        FF::Cmp::BoidsSeparation.new(distance: 150, strength: 0.001),
        FF::Cmp::BoidsCohesion.new(strength: 10000),
        FF::Cmp::Hp.new(health: 100),
        FF::Cmp::CollisionDamage.new(damage: 100),
        FF::Cmp::Hitcircle.new(r: 12),
        FF::Cmp::Team.new,
        FF::Cmp::SingletonDebugVectorArrow[0],
        FF::Cmp::SingletonCamera[0],
      )
    end
  end
end

