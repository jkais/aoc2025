require 'yaml'

def solve(day, only_test: false)
  folder_name = "%02d" % day
  solution_file = "#{folder_name}/solution.rb"
  return unless File.exist?(solution_file)

  puts "SOLUTION FOR DAY #{folder_name}"
  puts "==================="

  require_relative solution_file

  sets = only_test ? [:test] : [:test, :input]

  sets.each do |data|
    data_file = "#{folder_name}/data/#{data}.data"
    next unless File.exist?(data_file)
    puts
    puts "Running #{data} data..."

    input = File.read(data_file).split("\n")

    implementation = Object.const_get("Solution#{folder_name}")

    [1, 2].each do |exercise|
      result = implementation.send("solve#{exercise}", input)
      puts
      puts "Exercise #{exercise}"
      puts "Result: #{result}"

      yaml_file = "#{folder_name}/data/#{data}.solution.yml"

      if File.exist?(yaml_file)
        solution = YAML.load_file(yaml_file)[exercise]
        next unless !!solution
        if solution.to_s == result.to_s
          puts "✅"
        else
          puts "❌"
          puts "Solution should be: #{solution}"
        end
      end
    end
  end
end

if !!ARGV.first  
  solve(ARGV.first, only_test: ARGV[1] == "test")
else
  (1..12).each do |day|
    solve(day)
  end
end
