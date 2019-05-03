module MulberryExplosion
  class DataCapture

    attr_accessor :values, :count

    def initialize(max: 1000)
      @values = Array.new(max, 0)
      @count = 0
    end

    def add(value)
      @values[value] += 1
      @count += 1
    end

    def build_stats
      stats = MulberryExplosion::Statistics.new(count)
      left = 0
      right = count

      values.each_with_index do |value, index|
        unless value == 0
          right -= value
          stats.record(index, less: left, greater: right)
          left += value
        end
      end

      stats
    end
  end
end