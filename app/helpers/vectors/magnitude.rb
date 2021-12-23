class Helpers
  class Vectors
    def self.magnitude(x2, y2, x1 = 0, y1 = 0)
      Math.sqrt((((x2 - x1)**2) + ((y2 - y1)**2)).to_f)
    end
  end
end
