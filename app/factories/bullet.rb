class Factory
  class Bullet
    def self.new(x:, y:, damage: 10, vx: 10, vy: 0)
      puts 'new ent created'
      sprite = FF::Cmp::Sprite.new
      sprite.props[:path] = 'sprites/kenny/Tiles/tile_0000.png'
      FF::Ent.new(
        sprite,
        FF::Cmp::Boid.new(x: x, y: y, vx: vx, vy: vy, w: 16, h: 16),
        FF::Cmp::SingletonCamera[0],
        FF::Cmp::Hitcircle.new(r: 10),
        FF::Cmp::Hp.new(health: 1),
        FF::Cmp::Team.new,
        FF::Cmp::CollisionDamage.new(damage: damage),
      )
    end
  end
end
