FF::Scn::BoidRules.add(
  FF::Sys.new('BoidsCohesion', priority: 50) do
    center_mass = [0.0, 0.0]
    boids_count = FF::Cmp::BoidsCohesion.data.count

    FF::Cmp::BoidsCohesion.each do |cohesion|
      boid = cohesion.entities[0].components[FF::Cmp::Boid][0]
      center_mass[0] += boid.x
      center_mass[1] += boid.y
      #puts boid.x
      #puts boid.y
    end
    
    #puts center_mass
    FF::Cmp::BoidsCohesion.each do |cohesion|
      boid_update = cohesion.entities[0].components[FF::Cmp::Boid][0]
      move_boid = center_mass.dup
      move_boid[0] -= boid_update.x
      move_boid[1] -= boid_update.y
      move_boid[0] /= boids_count - 1.0
      move_boid[1] /= boids_count - 1.0

      boid_update.cx += (move_boid[0] - boid_update.x) / cohesion.strength.to_i
      boid_update.cy += (move_boid[1] - boid_update.y) / cohesion.strength.to_i
    end
  end
)
