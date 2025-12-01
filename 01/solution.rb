module Solution01
  class Dial
    POSITIONS = 100
    attr_reader :position

    def initialize
      @position = 50
    end

    def move(input)
      direction = input[0]
      times = input[1..].to_i

      if direction == "R"
        @position += times
      else
        @position -= times
      end

      @position += POSITIONS
      @position = @position % POSITIONS
    end
  end


  def self.solve1(data)
    dial = Dial.new

    zeros = 0

    data.each do |input|
      dial.move(input)
      zeros += 1 if dial.position == 0
    end

    return zeros
  end

  def self.solve2(data)
    return 0
  end
end
