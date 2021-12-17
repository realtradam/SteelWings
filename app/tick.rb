FF::Ent.new(FF::Cmp::Sprite.new, FF::Cmp::Boid.new(vx: 10, vy: 10), FF::Cmp::BoidBounds.new)
def tick args
  FelFlame::Stage.call
end
