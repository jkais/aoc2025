require 'yaml'
require 'pry'

def solve(day, only_test: false)
  day = day.to_i
  folder_name = "%02d" % day
  solution_file = "#{folder_name}/solution.rb"
  return unless File.exist?(solution_file)

  puts
  puts "SOLUTION FOR DAY #{"🕯️"*day}"
  puts

  require_relative solution_file

  sets = only_test ? [:test] : [:test, :input]

  sets.each do |data|
    data_file = "#{folder_name}/data/#{data}.data"
    next unless File.exist?(data_file)
    puts "Running #{data} data..."

    input = File.read(data_file).split("\n")

    implementation = Object.const_get("Solution#{folder_name}")

    [1, 2].each do |exercise|
      result = implementation.send("solve#{exercise}", input)
      puts
      puts "Exercise #{exercise}..."

      yaml_file = "#{folder_name}/data/#{data}.solution.yml"

      if File.exist?(yaml_file)
        solution = YAML.load_file(yaml_file)[exercise]
        next unless !!solution
        if solution.to_s == result.to_s
          puts "Result: #{result} ✅"
        else
          puts "Result: #{result} ❌ (expected: #{solution})"
        end
      else
        puts "Result: #{result}"
      end
    end
    puts
  end
end

if !!ARGV.first  
  solve(ARGV.first, only_test: ARGV[1] == "test")
else
  (1..12).each do |day|
    solve(day)
  end
end
