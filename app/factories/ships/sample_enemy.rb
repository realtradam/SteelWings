class Factory
  class SampleEnemy
    def self.defaults
      @defaults ||= {
        boid_bounds_strength: 0.6,
        boids_alignment_strength: 0.002,
        boids_seperation_strength: 0.001,
        boids_seperation_distance: 150,
        boids_cohesion_strength: 0.0005,
        hp_health: 100,
        collision_damage_damage: 100,
        hitcircle_r: 12,
        boid_minimum_speed_speed: 7,
        decay_speed_multiplier: 0.8,
      }
    end
    def self.new(x: 0, y: 0, vx: -3, vy: -3)
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
        FF::Cmp::Boid.new(x: x, y: y, vx: vx, vy: vy, w: 32, h: 32),
        sprite,
        FF::Cmp::BoidBounds.new(strength: self.defaults[:boid_bounds_strength]),
        FF::Cmp::BoidsAlignment.new(strength: self.defaults[:boids_alignment_strength]),
        FF::Cmp::BoidsSeparation.new(distance: self.defaults[:boids_seperation_distance], strength: self.defaults[:boids_seperation_strength]),
        FF::Cmp::BoidsCohesion.new(strength: self.defaults[:boids_cohesion_strength]),
        FF::Cmp::Hp.new(health: self.defaults[:hp_health]),
        FF::Cmp::CollisionDamage.new(damage: self.defaults[:collision_damage_damage]),
        FF::Cmp::Hitcircle.new(r: self.defaults[:hitcircle_r]),
        FF::Cmp::BoidMinimumSpeed.new(speed: self.defaults[:boid_minimum_speed_speed]),
        FF::Cmp::DecaySpeed.new(strength: self.defaults[:decay_speed_multiplier]),
        FF::Cmp::Team.new,
        FF::Cmp::SingletonDebugVectorArrow[0],
        FF::Cmp::SingletonCamera[0],
        FF::Cmp::SingletonEnemyTeam[0],
      )
    end
  end
end

