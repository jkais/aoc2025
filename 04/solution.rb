module Solution04
  def self.solve1(data)
    Grid.new(data).removeable.count
  end

  def self.solve2(data)
    grid = Grid.new(data)

    rolls_start = grid.rolls

    grid.remove_all_rolls

    return rolls_start - grid.rolls
  end
end

class Grid
  attr_reader :data, :height, :width

  def initialize(data)
    @data = data.map{ |row| row.split("") }
    @height = data.size
    @width = data[0].size
  end

  def remove_all_rolls
    nil while remove_rolls > 0
  end

  def remove_rolls
    rolls_start = rolls

    removeable.each do |pos|
      set(pos[0], pos[1])
    end

    return rolls_start - rolls
  end

  def removeable
    result = []

    0.upto(width - 1) do |x|
      0.upto(height - 1) do |y|
        result << [x, y] if at(x, y) == "@" && adjacent(x, y).count("@") < 4
      end
    end

    return result
  end

  def adjacent(x, y)
    result = []

    result << at(x - 1, y - 1)
    result << at(x, y - 1)
    result << at(x + 1, y - 1)

    result << at(x - 1, y)
    result << at(x + 1, y)

    result << at(x - 1, y + 1)
    result << at(x, y + 1)
    result << at(x + 1, y + 1)
  end

  def at(x, y)
    if x >= 0 && y >= 0 && x < width && y < height
      data[y][x]
    end
  end

  def set(x, y, value=".")
    data[y][x] = value
  end

  def rolls
    data.map { |row| row.join }.join.count("@")
  end

  def print
    puts
    data.each do |row|
      puts row.join
    end
  end
end
