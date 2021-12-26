FF::Sys.new('ReturnToMenu', priority: 200) do
  FF::Ent.each do |entity|
    entity.components.each do |manager, manager_array|
      manager_array.reverse_each do |component|
        next if component.respond_to?(:singleton)
        component.delete
      end
    end
    entity.delete
  end
  FF::Scn::BoidRules.add(FF::Sys::Follow, FF::Sys::RandomizeAI)
  FF::Sys::InitTitleScreen.call
end
