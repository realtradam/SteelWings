require 'app/felflame.rb'

require 'app/scenes/scenes.rb'

require 'app/components/sprite.rb'
require 'app/components/boid.rb'
require 'app/components/button.rb'
require 'app/components/hitbox.rb'
require 'app/components/rules/bounds.rb'
require 'app/components/rules/cohesion.rb'
require 'app/components/rules/alignment.rb'
require 'app/components/rules/separation.rb'
require 'app/components/rules/follow.rb'
require 'app/components/rules/minimum_speed.rb'
require 'app/components/rules/decay_speed.rb'
require 'app/components/debug/singleton_debug_vector_arrow.rb'
require 'app/components/singleton_camera.rb'
require 'app/components/singleton_bullet.rb'
require 'app/components/stats/collision_damage.rb'
require 'app/components/stats/hp.rb'
require 'app/components/hitcircle.rb'
require 'app/components/teams/singleton_player_team.rb'
require 'app/components/teams/singleton_enemy_team.rb'
require 'app/components/weapon.rb'
require 'app/components/teams/team.rb'
require 'app/components/singleton_title.rb'


require 'app/systems/init_title_screen.rb'
require 'app/systems/title_screen.rb'
require 'app/systems/start_game.rb'
require 'app/systems/render.rb'
require 'app/systems/update_boid_sprite.rb'
require 'app/systems/update_boid_position.rb'
require 'app/systems/rules/bounds.rb'
require 'app/systems/rules/cohesion.rb'
require 'app/systems/rules/alignment.rb'
require 'app/systems/rules/separation.rb'
require 'app/systems/rules/reset_change_vector.rb'
require 'app/systems/rules/follow.rb'
require 'app/systems/rules/decay_speed.rb'
require 'app/systems/debug/debug_render_vector_arrow.rb'
require 'app/systems/camera.rb'
require 'app/systems/collision_damage.rb'
require 'app/systems/death.rb'
require 'app/systems/player_weapon.rb'
require 'app/systems/move_camera.rb'
require 'app/systems/rules/minimum_speed.rb'
require 'app/systems/cleanup_bullets.rb'
require 'app/systems/ai/scatter.rb'
require 'app/systems/ai/rejoin.rb'
require 'app/systems/ai/target_player.rb'
require 'app/factories/bullet.rb'
require 'app/factories/ships/osprey.rb'

require 'app/tick.rb'
