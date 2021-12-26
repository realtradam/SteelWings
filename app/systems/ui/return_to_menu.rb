FF::Sys.new('ReturnToMenu', priority: 0) do
  FF::Ent.each do |entity|
    component_hash = entity.components.clone
    component_hash.each_pair do |manager, manager_array|
      manager_array.each do |component|
        next if component.respond_to?(:singleton)
        component.delete
      end
    end
    entity.delete
  end
  FF::Scn::BoidRules.add(FF::Sys::Follow, FF::Sys::RandomizeAI)
  FF::Sys::InitTitleScreen.call
end
