FF::Scn::BoidRules.add(
  FF::Sys.new("Death", priority: 200) do
    FF::Cmp::Hp.each do |hp|
      if hp.health <= 0
        component_hash = hp.entities[0].components.clone
        component_hash.each_pair do |manager, manager_array|
          next if manager.equal?(FF::Cmp::SingletonCamera)
          next if manager.equal?(FF::Cmp::Hp)
          next if manager.equal?(FF::Cmp::DebugVectorArrow)
          manager_array.each do |component|
            # unless singleton
            component.delete
          end
        end
        hp.entities[0].delete
        hp.delete
      end
    end
  end
)
