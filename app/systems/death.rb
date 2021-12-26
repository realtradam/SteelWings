FF::Scn::BoidRules.add(
  FF::Sys.new("Death", priority: 200) do
    FF::Cmp::Hp.each do |hp|
      if hp.health <= 0
        component_hash = hp.entities[0].components.clone
        component_hash.each_pair do |manager, manager_array|
          if manager.equal?(FF::Cmp::SingletonPlayer)
            FF::Sys::EndGame.call
          end
          next if manager.equal?(FF::Cmp::Hp)
          manager_array.each do |component|
            next if component.respond_to?(:singleton)
            component.delete
          end
        end
        hp.entities[0].delete
        hp.delete
      end
    end
  end
)
