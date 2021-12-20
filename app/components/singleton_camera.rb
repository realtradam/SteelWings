FF::Cmp.new('SingletonCamera',
            :x, :y,
            :zoom, :angle,
            singleton: true)

FF::Cmp::SingletonCamera.new(x: 0.0, y: 0.0, zoom: 1.0, angle: 0.0)
