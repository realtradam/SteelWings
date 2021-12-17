class FelFlame
  class Entities
    # Holds the unique ID of this entity
    # @return [Integer]
    attr_reader :id

    # A seperate attr_writer was made for documentation readability reasons.
    # Yard will list attr_reader is readonly which is my intention.
    # This value needs to be changable as it is set by other functions.
    # @!visibility private
    attr_writer :id

    # Creating a new Entity
    # @param components [Components] Can be any number of components, identical duplicates will be automatically purged however different components from the same component manager are allowed.
    # @return [Entity]
    def initialize(*components)
      # Assign new unique ID
      new_id = self.class.data.find_index(&:nil?)
      new_id = self.class.data.size if new_id.nil?
      self.id = new_id

      # Add each component
      add(*components)

      self.class.data[id] = self
    end

    # A hash that uses component manager constant names as keys, and where the values of those keys are arrays that contain the {FelFlame::ComponentManager#id IDs} of the components attached to this entity.
    # @return [Hash<Component_Manager, Array<Integer>>]
    def components
      @components ||= {}
    end

    # An alias for the {#id ID reader}
    # @return [Integer]
    def to_i
      id
    end

    # Removes this Entity from the list and purges all references to this Entity from other Components, as well as its {id ID} and data.
    # @return [Boolean] +true+
    def delete
      components.each do |component_manager, component_array|
        component_array.each do |component|
          component.entities.delete(self)
        end
      end
      FelFlame::Entities.data[id] = nil
      @components = {}
      @id = nil
      true
    end

    # Add any number components to the Entity.
    # @param components_to_add [Component] Any number of components created from any component manager
    # @return [Boolean] +true+
    def add(*components_to_add)
      components_to_add.each do |component|
        if components[component.class].nil?
          components[component.class] = [component]
          component.entities.push self
          check_systems component, :addition_triggers
        elsif !components[component.class].include? component
          components[component.class].push component
          component.entities.push self
          check_systems component, :addition_triggers
        end
      end
      true
    end

    # triggers every system associated with this component's trigger
    # @return [Boolean] +true+
    # @!visibility private
    def check_systems(component, trigger_type)
      component_calls = component.class.send(trigger_type)
      component.send(trigger_type).each do |system|
        component_calls |= [system]
      end
      component_calls.sort_by(&:priority).reverse.each(&:call)
      true
    end

    # Remove a component from the Entity
    # @param components_to_remove [Component] A component created from any component manager
    # @return [Boolean] +true+
    def remove(*components_to_remove)
      components_to_remove.each do |component|
        check_systems component, :removal_triggers if component.entities.include? self
        component.entities.delete self
        components[component.class].delete component
      end
      true
    end

    # Export all data into a JSON String which can then be saved into a file
    # TODO: This function is not yet complete
    # @return [String] A JSON formatted String
    #def to_json() end

    class <<self
      include Enumerable
      # @return [Array<Entity>] Array of all Entities that exist
      # @!visibility private
      def data
        @data ||= []
      end

      # Gets an Entity from the given {id unique ID}. Usage is simular to how an Array lookup works
      #
      # @example
      #   # This gets the Entity with ID 7
      #   FelFlame::Entities[7]
      # @param entity_id [Integer]
      # @return [Entity] returns the Entity that uses the given unique ID, nil if there is no Entity associated with the given ID
      def [](entity_id)
        data[entity_id]
      end

      # Iterates over all entities. The data is compacted so that means index does not correlate to ID.
      # You also call other enumerable methods instead of each, such as +each_with_index+ or +select+
      # @return [Enumerator]
      def each(&block)
        data.compact.each(&block)
      end

      # Creates a new entity using the data from a JSON string
      # TODO: This function is not yet complete
      # @param json_string [String] A string that was exported originally using the {FelFlame::Entities#to_json to_json} function
      # @param opts [Keywords] What values(its {FelFlame::Entities#id ID} or the {FelFlame::ComponentManager#id component IDs}) should be overwritten TODO: this might change
      #def from_json(json_string, **opts) end
    end
  end
end
class FelFlame
  class Components
    @component_map = []
    class <<self
      include Enumerable
      # Creates a new {FelFlame::ComponentManager component manager}.
      #
      # @example
      #   # Here color is set to default to red
      #   # while max and current are nil until set.
      #   # When you make a new component using this component manager
      #   # these are the values and accessors it will have.
      #   FelFlame::Component.new('Health', :max, :current, color: 'red')
      #
      # @param component_name [String] Name of your new component manager. Must be stylized in the format of constants in Ruby
      # @param attrs [:Symbols] New components made with this manager will include these symbols as accessors, the values of these accessors will default to nil
      # @param attrs_with_defaults [Keyword: DefaultValue] New components made with this manager will include these keywords as accessors, their defaults set to the values given to the keywords
      # @return [ComponentManager]
      def new(component_name, *attrs, **attrs_with_defaults)
        if FelFlame::Components.const_defined?(component_name)
          raise(NameError.new, "Component Manager '#{component_name}' is already defined")
        end


        const_set(component_name, Class.new(FelFlame::ComponentManager) {})

        attrs.each do |attr|
          if FelFlame::Components.const_get(component_name).method_defined?("#{attr}") || FelFlame::Components.const_get(component_name).method_defined?("#{attr}=")
            raise NameError.new "The attribute name \"#{attr}\" is already a method"
          end
          FelFlame::Components.const_get(component_name).attr_accessor attr
        end
        attrs_with_defaults.each do |attr, _default|
          attrs_with_defaults[attr] = _default.dup
          FelFlame::Components.const_get(component_name).attr_reader attr
          FelFlame::Components.const_get(component_name).define_method("#{attr}=") do |value|
            attr_changed_trigger_systems(attr) unless value.equal? send(attr)
            instance_variable_set("@#{attr}", value)
          end
        end
        FelFlame::Components.const_get(component_name).define_method(:set_defaults) do
          attrs_with_defaults.each do |attr, default|
            instance_variable_set("@#{attr}", default.dup)
          end
        end
        FelFlame::Components.const_get(component_name)
      end

      # Iterate over all existing component managers. You also call other enumerable methods instead of each, such as +each_with_index+ or +select+
      # @return [Enumerator]
      def each(&block)
        constants.each(&block)
      end
    end
  end

  # Component Managers are what is used to create individual components which can be attached to entities.
  # When a Component is created from a Component Manager that has accessors given to it, you can set or get the values of those accessors using standard ruby message sending (e.g +@component.var = 5+), or by using the {#attrs} and {#update_attrs} methods instead.
  class ComponentManager

    # Holds the {id unique ID} of a component. The {id ID} is only unique within the scope of the component manager it was created from.
    # @return [Integer]
    attr_reader :id

    # A seperate attr_writer was made for documentation readability reasons.
    # Yard will list attr_reader is readonly which is my intention.
    # This value needs to be changable as it is set by other functions.
    # @!visibility private
    attr_writer :id

    # Allows overwriting the storage of triggers, such as for clearing.
    # This method should generally only need to be used internally and
    # not by a game developer.
    # @!visibility private
    attr_writer :addition_triggers, :removal_triggers, :attr_triggers

    # Stores references to systems that should be triggered when a
    # component from this manager is added.
    # Do not edit this array as it is managed by FelFlame automatically.
    # @return [Array<System>]
    def addition_triggers
      @addition_triggers ||= []
    end

    # Stores references to systems that should be triggered when a
    # component from this manager is removed.
    # Do not edit this array as it is managed by FelFlame automatically.
    # @return [Array<System>]
    def removal_triggers
      @removal_triggers ||= []
    end

    # Stores references to systems that should be triggered when an
    # attribute from this manager is changed.
    # Do not edit this hash as it is managed by FelFlame automatically.
    # @return [Hash<Symbol, Array<System>>]
    def attr_triggers
      @attr_triggers ||= {}
    end

    # Creates a new component and sets the values of the attributes given to it. If an attritbute is not passed then it will remain as the default.
    # @param attrs [Keyword: Value] You can pass any number of Keyword-Value pairs
    # @return [Component]
    def initialize(**attrs)
      # Prepare the object
      # (this is a function created with metaprogramming
      # in FelFlame::Components
      set_defaults

      # Generate ID
      new_id = self.class.data.find_index { |i| i.nil? }
      new_id = self.class.data.size if new_id.nil?
      @id = new_id

      # Fill params
      attrs.each do |key, value|
        send "#{key}=", value
      end

      # Save Component
      self.class.data[new_id] = self
    end

    class <<self

      # Allows overwriting the storage of triggers, such as for clearing.
      # This method should generally only need to be used internally and
      # not by a game developer.
      # @!visibility private
      attr_writer :addition_triggers, :removal_triggers, :attr_triggers

      # Stores references to systems that should be triggered when this
      # component is added to an enitity.
      # Do not edit this array as it is managed by FelFlame automatically.
      # @return [Array<System>]
      def addition_triggers
        @addition_triggers ||= []
      end

      # Stores references to systems that should be triggered when this
      # component is removed from an enitity.
      # Do not edit this array as it is managed by FelFlame automatically.
      # @return [Array<System>]
      def removal_triggers
        @removal_triggers ||= []
      end

      # Stores references to systems that should be triggered when an
      # attribute from this component changed.
      # Do not edit this hash as it is managed by FelFlame automatically.
      # @return [Hash<Symbol, System>]
      def attr_triggers
        @attr_triggers ||= {}
      end

      # @return [Array<Component>] Array of all Components that belong to a given component manager
      # @!visibility private
      def data
        @data ||= []
      end

      # Gets a Component from the given {id unique ID}. Usage is simular to how an Array lookup works.
      #
      # @example
      #   # this gets the 'Health' Component with ID 7
      #   FelFlame::Components::Health[7]
      # @param component_id [Integer]
      # @return [Component] Returns the Component that uses the given unique {id ID}, nil if there is no Component associated with the given {id ID}
      def [](component_id)
        data[component_id]
      end

      # Iterates over all components within the component manager.
      # Special Enumerable methods like +map+ or +each_with_index+ are not implemented
      # @return [Enumerator]
      def each(&block)
        data.compact.each(&block)
      end
    end

    # An alias for the {id ID Reader}
    # @return [Integer]
    def to_i
      id
    end

    # A list of entity ids that are linked to the component
    # @return [Array<Integer>]
    def entities
      @entities ||= []
    end

    # Update attribute values using a hash or keywords.
    # @return [Hash<Symbol, Value>] Hash of updated attributes
    def update_attrs(**opts)
      opts.each do |key, value|
        send "#{key}=", value
      end
    end

    # Execute systems that have been added to execute on variable change
    # @return [Boolean] +true+
    def attr_changed_trigger_systems(attr)
      systems_to_execute = self.class.attr_triggers[attr]
      systems_to_execute = [] if systems_to_execute.nil?

      systems_to_execute |= attr_triggers[attr] unless attr_triggers[attr].nil?

      systems_to_execute.sort_by(&:priority).reverse.each(&:call)
      true
    end

    # Removes this component from the list and purges all references to this Component from other Entities, as well as its {id ID} and data.
    # @return [Boolean] +true+.
    def delete
      addition_triggers.each do |system|
        system.clear_triggers component_or_manager: self
      end
      # This needs to be cloned because indices get deleted as
      # the remove command is called, breaking the loop if it
      # wasn't referencing a clone(will get Nil errors)
      iter = entities.map(&:clone)
      iter.each do |entity|
        #FelFlame::Entities[entity_id].remove self #unless FelFlame::Entities[entity_id].nil?
        entity.remove self
      end
      self.class.data[id] = nil
      instance_variables.each do |var|
        instance_variable_set(var, nil)
      end
      true
    end

    # @return [Hash<Symbol, Value>] A hash, where all the keys are attributes linked to their respective values.
    def attrs
      return_hash = instance_variables.each_with_object({}) do |key, final|
        final[key.to_s.delete_prefix('@').to_sym] = instance_variable_get(key)
      end
      return_hash.delete(:attr_triggers)
      return_hash
    end

    # Export all data into a JSON String, which could then later be loaded or saved to a file
    # TODO: This function is not yet complete
    # @return [String] a JSON formatted String
    #def to_json
    #  # should return a json or hash of all data in this component
    #end
  end
end
class FelFlame
  class Systems
    # How early this System should be executed in a list of Systems
    attr_accessor :priority

    # The Constant name assigned to this System
    attr_reader :const_name

    # Allows overwriting the storage of triggers, such as for clearing.
    # This method should generally only need to be used internally and
    # not by a game developer.
    # @!visibility private
    attr_writer :addition_triggers, :removal_triggers, :attr_triggers

    def priority=(priority)
      @priority = priority
      FelFlame::Stage.systems = FelFlame::Stage.systems.sort_by(&:priority)
    end
    # Stores references to components or their managers that trigger
    # this component when a component or component from that manager
    # is added to an entity.
    # Do not edit this hash as it is managed by FelFlame automatically.
    # @return [Array<Component>]
    def addition_triggers
      @addition_triggers ||= []
    end

    # Stores references to components or their managers that trigger
    # this component when a component or component from that manager
    # is removed from an entity.
    # Do not edit this hash as it is managed by FelFlame automatically.
    # @return [Array<Component>]
    def removal_triggers
      @removal_triggers ||= []
    end


    # Stores references to systems that should be triggered when an
    # attribute from this manager is changed
    # Do not edit this hash as it is managed by FelFlame automatically.
    # @return [Hash<Symbol, Array<Symbol>>]
    def attr_triggers
      @attr_triggers ||= {}
    end

    class <<self
      include Enumerable

      # Iterate over all Systems, sorted by their priority. You also call other enumerable methods instead of each, such as +each_with_index+ or +select+
      # @return [Enumerator]
      def each(&block)
        constants.map { |sym| const_get(sym) }.sort_by(&:priority).reverse.each(&block)
      end
    end

    # Creates a new System which can be accessed as a constant under the namespace {FelFlame::Systems}.
    # The name given is what constant the system is assigned to
    #
    # @example
    #   FelFlame::Systems.new('PassiveHeal', priority: -2) do
    #     FelFlame::Components::Health.each do |component|
    #       component.hp += 5
    #     end
    #   end
    #   # Give it a low priority so other systems such as a
    #   #   Poison system would kill the player first
    #
    # @param name [String] The name this system will use. Needs to to be in the Ruby Constant format.
    # @param priority [Integer] Which priority order this system should be executed in relative to other systems. Higher means executed earlier.
    # @param block [Proc] The code you wish to be executed when the system is triggered. Can be defined by using a +do end+ block or using +{ }+ braces.
    def initialize(name, priority: 0, &block)
      FelFlame::Systems.const_set(name, self)
      @const_name = name
      @priority = priority
      @block = block
    end

    # Manually execute the system a single time
    def call
      @block.call
    end
    # Redefine what code is executed by this System when it is called upon.
    # @param block [Proc] The code you wish to be executed when the system is triggered. Can be defined by using a +do end+ block or using +{ }+ braces.
    def redefine(&block)
      @block = block
    end

    # Removes triggers from this system. This function is fairly flexible so it can accept a few different inputs
    # For addition and removal triggers, you can optionally pass in a component, or a manager to clear specifically
    # the relevant triggers for that one component or manager. If you do not pass a component or manager then it will
    # clear triggers for all components and managers.
    # For attr_triggers
    # @example
    #   # To clear all triggers that execute this system when a component is added:
    #   FelFlame::Systems::ExampleSystem.clear_triggers :addition_triggers
    #   # Same as above but for when a component is removed instead
    #   FelFlame::Systems::ExampleSystem.clear_triggers :removal_triggers
    #   # Same as above but for when a component has a certain attribute changed
    #   FelFlame::Systems::ExampleSystem.clear_triggers :attr_triggers
    #
    #   # Clear a trigger from a specific component
    #   FelFlame::Systems::ExampleSystem.clear_triggers :addition_triggers, FelFlame::Component::ExampleComponent[0]
    #   # Clear a trigger from a specific component manager
    #   FelFlame::Systems::ExampleSystem.clear_triggers :addition_triggers, FelFlame::Component::ExampleComponent
    #
    #   # Clear the trigger that executes a system when the ':example_attr' is changes
    #   FelFlame::Systems::ExampleSystem.clear_triggers :attr_triggers, :example_attr
    # @param trigger_types [:Symbols] One or more of  the following trigger types: +:addition_triggers+, +:removal_triggers+, or +:attr_triggers+. If attr_triggers is used then you may pass attributes you wish to be cleared as symbols in this parameter as well
    # @param component_or_manager [Component or ComponentManager] The object to clear triggers from. Use Nil to clear triggers from all components associated with this system.
    # @return [Boolean] +true+
    def clear_triggers(*trigger_types, component_or_manager: nil)
      trigger_types = [:addition_triggers, :removal_triggers, :attr_triggers] if trigger_types.empty?

      if trigger_types.include? :attr_triggers
        if (trigger_types - [:addition_triggers,
            :removal_triggers,
            :attr_triggers]).empty?

          if component_or_manager.nil?
            #remove all attrs
            self.attr_triggers.each do |cmp_or_mgr, attrs|
              attrs.each do |attr|
                next if cmp_or_mgr.attr_triggers[attr].nil?

                cmp_or_mgr.attr_triggers[attr].delete self
              end
              self.attr_triggers = {}
            end
          else
            #remove attrs relevant to comp_or_man
            unless self.attr_triggers[component_or_manager].nil?
              self.attr_triggers[component_or_manager].each do |attr|
                component_or_manager.attr_triggers[attr].delete self
              end
              self.attr_triggers[component_or_manager] = []
            end
          end

        else

          if component_or_manager.nil?
            (trigger_types - [:addition_triggers, :removal_triggers, :attr_triggers]).each do |attr|
              #remove attr
              self.attr_triggers.each do |cmp_or_mgr, attrs|
                cmp_or_mgr.attr_triggers[attr].delete self
              end
            end
            self.attr_triggers.delete (trigger_types - [:addition_triggers,
                                                        :removal_triggers,
                                                        :attr_triggers])
          else
            #remove attr from component_or_manager
            (trigger_types - [:addition_triggers, :removal_triggers, :attr_triggers]).each do |attr|
              next if component_or_manager.attr_triggers[attr].nil?
              component_or_manager.attr_triggers[attr].delete self
            end
            self.attr_triggers[component_or_manager] -= trigger_types unless self.attr_triggers[component_or_manager].nil?
          end

        end
      end

      (trigger_types & [:removal_triggers, :addition_triggers] - [:attr_triggers]).each do |trigger_type|
        if component_or_manager.nil?
          #remove all removal triggers
          self.send(trigger_type).each do |trigger|
            trigger.send(trigger_type).delete self
          end
          self.send("#{trigger_type.to_s}=", [])
        else
          #remove removal trigger relevant to comp/man
          self.send(trigger_type).delete component_or_manager
          component_or_manager.send(trigger_type).delete self
        end
      end
      true
    end

    # Add a component or component manager so that it triggers this system when the component or a component from the component manager is added to an entity
    # @param component_or_manager [Component or ComponentManager] The component or component manager to trigger this system when added
    # @return [Boolean] +true+
    def trigger_when_added(component_or_manager)
      self.addition_triggers |= [component_or_manager]
      component_or_manager.addition_triggers |= [self]
      true
    end

    # Add a component or component manager so that it triggers this system when the component or a component from the component manager is removed from an entity
    # @param component_or_manager [Component or ComponentManager] The component or component manager to trigger this system when removed
    # @return [Boolean] +true+
    def trigger_when_removed(component_or_manager)
      self.removal_triggers |= [component_or_manager]
      component_or_manager.removal_triggers |= [self]
      true
    end

    # Add a component or component manager so that it triggers this system when a component's attribute is changed.
    # @return [Boolean] +true+
    def trigger_when_is_changed(component_or_manager, attr)
      if component_or_manager.attr_triggers[attr].nil?
        component_or_manager.attr_triggers[attr] = [self]
      else
        component_or_manager.attr_triggers[attr] |= [self]
      end
      if self.attr_triggers[component_or_manager].nil?
        self.attr_triggers[component_or_manager] = [attr]
      else
        self.attr_triggers[component_or_manager] |= [attr]
      end
      true
    end
  end
end
class FelFlame
  class Scenes
    # The Constant name assigned to this Scene
    attr_reader :const_name

    # Allows overwriting the storage of systems, such as for clearing.
    # This method should generally only need to be used internally and
    # not by a game developer/
    # @!visibility private
    attr_writer :systems

    # Create a new Scene using the name given
    # @param name [String] String format must follow requirements of a constant
    def initialize(name)
      FelFlame::Scenes.const_set(name, self)
      @const_name = name
    end

    # The list of Systems this Scene contains
    # @return [Array<System>]
    def systems
      @systems ||= []
    end

    # Execute all systems in this Scene, in the order of their priority
    # @return [Boolean] +true+
    def call
      systems.each(&:call)
      true
    end

    # Adds any number of Systems to this Scene
    # @return [Boolean] +true+
    def add(*systems_to_add)
      self.systems |= systems_to_add
      self.systems = systems.sort_by(&:priority)
      FelFlame::Stage.update_systems_list if FelFlame::Stage.scenes.include? self
      true
    end

    # Removes any number of SystemS from this Scene
    # @return [Boolean] +true+
    def remove(*systems_to_remove)
      self.systems -= systems_to_remove
      self.systems = systems.sort_by(&:priority)
      FelFlame::Stage.update_systems_list if FelFlame::Stage.scenes.include? self
      true
    end

    # Removes all Systems from this Scene
    # @return [Boolean] +true+
    def clear
      systems.clear
      FelFlame::Stage.update_systems_list if FelFlame::Stage.scenes.include? self
      true
    end
  end
end
class FelFlame
  class Stage
    class <<self
      # Allows clearing of scenes and systems.
      # Used internally by FelFlame and shouldn't need to be ever used by developers
      # @!visibility private
      attr_writer :scenes, :systems

      # Add any number of Scenes to the Stage
      # @return [Boolean] +true+
      def add(*scenes_to_add)
        self.scenes |= scenes_to_add
        scenes_to_add.each do |scene|
          self.systems |= scene.systems
        end
        self.systems = systems.sort_by(&:priority)
        true
      end

      # Remove any number of Scenes from the Stage
      # @return [Boolean] +true+
      def remove(*scenes_to_remove)
        self.scenes -= scenes_to_remove
        update_systems_list
        true
      end

      # Updates the list of systems from the Scenes added to the Stage and make sure they are ordered correctly
      # This is used internally by FelFlame and shouldn't need to be ever used by developers
      # @return [Boolean] +true+
      # @!visibility private
      def update_systems_list
        systems.clear
        scenes.each do |scene|
          self.systems |= scene.systems
        end
        self.systems = systems.sort_by(&:priority)
        true
      end

      # Clears all Scenes that were added to the Stage
      # @return [Boolean] +true+
      def clear
        systems.clear
        scenes.clear
        true
      end

      # Executes one frame of the game. This executes all the Systems in the Scenes added to the Stage. Systems that exist in two or more different Scenes will still only get executed once.
      # @return [Boolean] +true+
      def call
        systems.each(&:call)
        true
      end

      # Contains all the Scenes added to the Stage
      # @return [Array<Scene>]
      def scenes
        @scenes ||= []
      end

      # Stores systems in the order the stage manager needs to call them
      # This method should generally only need to be used internally and not by a game developer
      # @!visibility private
      def systems
        @systems ||= []
      end
    end
  end
end
#require_relative 'felflame/entity_manager'
#require_relative 'felflame/component_manager'
#require_relative 'felflame/system_manager'
#require_relative 'felflame/scene_manager'
#require_relative 'felflame/stage_manager'

#require_relative "felflame/version"

# The FelFlame namespace where all its functionality resides under.
class FelFlame
  class <<self
    # :nocov:

    # An alias for {FelFlame::Stage.call}. It executes a single frame in the game.
    def call
      FelFlame::Stage.call
    end
    # :nocov:
  end

  # Creates and manages Entities. Allows accessing Entities using their {FelFlame::Entities#id ID}. Entities are just collections of Components.
  class Entities; end

  # Creates component managers and allows accessing them them under the {FelFlame::Components} namespace as Constants
  #
  # To see how component managers are used please look at the {FelFlame::ComponentManager} documentation.
  class Components; end

  # Creates an manages Systems. Systems are the logic of the game and do not contain any data within them.
  #
  # TODO: Improve Systems overview
  class Systems; end

  # Creates and manages Scenes. Scenes are collections of Systems, and execute all the Systems when called upon.
  # 
  # TODO: Improve Scenes overview
  class Scenes; end

  # Stores Scenes which you want to execute on each frame. When called upon will execute all Systems in the Scenes in the Stage and will execute them according to their priority order.
  class Stage; end
end

# An alias for {FelFlame}
FF = FelFlame

# An alias for {FelFlame::Entities}
FF::Ent = FelFlame::Entities

# An alias for {FelFlame::Components}
FF::Cmp = FelFlame::Components

# An alias for {FelFlame::Systems}
FF::Sys = FelFlame::Systems

# An alias for {FelFlame::Scenes}
FF::Scn = FelFlame::Scenes

# An alias for {FelFlame::Stage}
FF::Stg = FelFlame::Stage
