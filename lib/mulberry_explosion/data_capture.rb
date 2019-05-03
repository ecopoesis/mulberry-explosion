# frozen_string_literal: true

module MulberryExplosion
  class DataCapture
    attr_accessor :values, :count

    def initialize(max: 1000)
      @values = Array.new(max, 0)
      @count = 0
    end

    def add(value)
      raise ArgumentError.new('Value must be a positive integer') if value < 0
      raise ArgumentError.new("Value must be <= #{values.size - 1}") if value > values.size - 1

      @values[value] += 1
      @count += 1
    end

    def build_stats
      stats = MulberryExplosion::Statistics.new(count)
      left = 0
      right = count

      values.each_with_index do |value, index|
        next if value == 0

        right -= value
        stats.add_record(index, less: left, greater: right)
        left += value
      end

      stats
    end
  end
end
