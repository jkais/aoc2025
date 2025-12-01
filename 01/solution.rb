module Solution01
  class Dial
    POSITIONS = 100
    attr_reader :position, :zeros

    def initialize
      @position = 50
      @zeros = 0
    end

    def move1(input)
      direction = input[0]
      times = input[1..].to_i

      if direction == "R"
        @position += times
      else
        @position -= times
      end

      @position += POSITIONS
      @position = @position % POSITIONS

      @zeros += 1 if @position == 0
    end

    def move2(input)
      direction = input[0]
      times = input[1..].to_i

      if direction == "R"
        times.times do 
          @position += 1
          @position = 0 if @position == 100
          @zeros += 1 if @position == 0
        end
      else
        times.times do
          @position -= 1
          @position = 99 if @position == -1
          @zeros += 1 if @position == 0
        end
      end

    end
  end


  def self.solve1(data)
    dial = Dial.new

    data.each do |input|
      dial.move1(input)
    end

    return dial.zeros
  end

  def self.solve2(data)
    dial = Dial.new

    data.each do |input|
      dial.move2(input)
    end

    return dial.zeros
  end
end
