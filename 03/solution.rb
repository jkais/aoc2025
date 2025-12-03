module Solution03
  def self.solve1(data)
    result = 0

    data.each do |bank|
      result += max_jolt(bank.split("").map(&:to_i), 2)
    end

    return result
  end

  def self.solve2(data)
    result = 0

    data.each do |bank|
      result += max_jolt(bank.split("").map(&:to_i))
    end

    return result
  end

  def self.max_jolt(bank, amount=12)
    result = ""
    from = 0

    amount.downto(1) do |num|
      to = bank.length - num
      max = bank[from..to].max
      result += max.to_s
      from = bank[from..to].index(max) + 1 + from
    end

    return result.to_i
  end
end
