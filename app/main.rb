require 'app/felflame.rb'

require 'app/scenes/scenes.rb'

require 'app/components/sprite.rb'
require 'app/components/boid.rb'
require 'app/components/rules/bounds.rb'
require 'app/components/rules/cohesion.rb'
require 'app/components/debug/debug_vector_arrow.rb'

require 'app/systems/render.rb'
require 'app/systems/update_boid_sprite.rb'
require 'app/systems/update_boid_position.rb'
require 'app/systems/rules/bounds.rb'
require 'app/systems/rules/cohesion.rb'
require 'app/systems/rules/reset_change_vector.rb'
require 'app/systems/debug/debug_render_vector_arrow.rb'

require 'app/tick.rb'
