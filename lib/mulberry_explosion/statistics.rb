# frozen_string_literal: true

module MulberryExplosion
  class Statistics
    attr_accessor :records
    attr_reader :total

    def initialize(total)
      @total = total
      @records = {}
    end

    def add_record(value, less:, greater:)
      @records[value] = { less: less, greater: greater }
    end

    def less(value)
      record(value)[:less]
    end

    def greater(value)
      record(value)[:greater]
    end

    def between(first, last)
      total - less(first) - greater(last)
    end

    private

    def record(value)
      records.fetch(value) { raise ArgumentError.new("No statistic recorded for #{value}") }
    end
  end
end
