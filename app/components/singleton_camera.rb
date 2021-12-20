FF::Cmp.new('SingletonCamera',
            singleton: true,
            :x, :y,
            :zoom, :angle)

FF::Cmp::SingletonCamera.new(x: 0.0, y: 0.0, zoom: 1.0, angle: 0.0)
