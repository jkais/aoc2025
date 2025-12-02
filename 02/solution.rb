module Solution02
  def self.solve1(data)
    ranges = data[0].split(",").map { |range| range.split("-").map(&:to_i) }

    result = 0

    ranges.each do |range|
      range[0].upto(range[1]) do |number|
        result += number if isInvalid1?(number)
      end
    end

    return result
  end

  def self.solve2(data)
    ranges = data[0].split(",").map { |range| range.split("-").map(&:to_i) }

    result = 0

    ranges.each do |range|
      range[0].upto(range[1]) do |number|
        result += number if isInvalid2?(number)
      end
    end

    return result
  end

  def self.isInvalid1?(number)
    number = number.to_s
    length = number.length
    return false if length.odd?

    first = number[0..(length/2 - 1)]
    second = number[length/2..-1]

    first == second
  end

  def self.isInvalid2?(number)
    number = number.to_s

    piece = ""
    l = 0
    while piece.length < (number.length / 2) do
      piece = number[0..l]
      times = number.length / piece.length
      return true if piece * times == number

      l += 1
    end

    return false
  end
end
