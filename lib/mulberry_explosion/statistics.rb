module MulberryExplosion
  class Statistics

    attr_accessor :records
    attr_reader :total

    def initialize(total)
      @total = total
      @records = {}
    end

    def record(value, less:, greater:)
      @records[value] = { less: less, greater: greater }
    end

    def less(value)
      records[value][:less]
    end

    def greater(value)
      records[value][:greater]
    end

    def between(a, b)
      total - less(a) - greater(b)
    end
  end
end