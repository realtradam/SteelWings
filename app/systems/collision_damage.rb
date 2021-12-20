FF::Scn::BoidRules.add(
  FF::Sys.new("CollisionDamage", priority: 65) do
    FF::Cmp::Hitcircle.each do |hitcircle_self|
      boid_self = hitcircle_self.entities[0].components[FF::Cmp::Boid][0]
      FF::Cmp::Hitcircle.each do |hitcircle_target|
        next if hitcircle_self == hitcircle_target
        next if hitcircle_self.entities[0].components[FF::Cmp::Team][0].team == hitcircle_target.entities[0].components[FF::Cmp::Team][0].team
        puts 'passed first check'
        boid_target = hitcircle_target.entities[0].components[FF::Cmp::Boid][0]
        if Math.sqrt(((boid_self.x - boid_target.x) ** 2) + ((boid_self.y - boid_target.y) ** 2)) < (hitcircle_target.r + hitcircle_self.r)
          hitcircle_target.entities[0].components[FF::Cmp::Hp][0].health -= hitcircle_self.entities[0].components[FF::Cmp::CollisionDamage][0].damage
        end
      end
    end
  end
)
