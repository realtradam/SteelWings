FF::Scn::BoidRules.add(
  FF::Sys.new('BoidsAlignment', priority: 50) do
    group_velocity = [0.0, 0.0]
    boids_count = FF::Cmp::BoidsCohesion.data.count

    FF::Cmp::BoidsAlignment.each do |alignment|
      boid = alignment.entities[0].components[FF::Cmp::Boid][0]
      group_velocity[0] += boid.vx
      group_velocity[1] += boid.vy
    end

    FF::Cmp::BoidsAlignment.each do |alignment|
      boid_update = alignment.entities[0].components[FF::Cmp::Boid][0]
      move_boid = group_velocity.dup
      move_boid[0] -= boid_update.vx
      move_boid[1] -= boid_update.vy
      move_boid[0] /= boids_count - 1.0
      move_boid[1] /= boids_count - 1.0

      boid_update.cx += (move_boid[0] - boid_update.vx) / alignment.strength
      boid_update.cy += (move_boid[1] - boid_update.vy) / alignment.strength
    end
  end
)
