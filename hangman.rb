require 'yaml'
def start()
  puts "restore or not? y or n"
  ans = gets.chomp.downcase
  if ans == "y"
    restore()
    return
  else
    dictionary_path = '/home/beky/repos/Hangman/google-10000-english-no-swears.txt'
    dictionary_words = File.readlines(dictionary_path)
    eligible_words = dictionary_words.select {|word| word.length.between?(5,12)}
    pick = eligible_words.sample.strip
    puts "what's your guess?"
    guess = gets.chomp.downcase
    judge_guess(guess, 15, pick)

  end
end

def restore()
  yaml_path = 'saved.yaml'
  data = YAML.load_file(yaml_path)
  guess = data[:guess]
  real = data[:real]
  turns = data[:turns]
  judge_guess(guess, turns, real)
end

def judge_guess(guess, turns, real)
  puts "do you want to save the game? y/n"
  if(gets.chomp.downcase == 'y')
    data = {guess: guess, real: real, turns: turns}
    yaml_path = 'saved.yaml'
    File.write(yaml_path, data.to_yaml)
    return
  end
  if(guess == real)
    puts "Guess Correct!"
    return
  end
  if(turns == 0)
    puts 'Sorry, your guesses are incorrect for given chances'
  end
  hint = ''
  real.split('').each do |c|
    if guess.split('').include?(c)
      hint += c
    else
      hint += '_'
    end
  end
  puts hint
  puts 'please guess again'
  judge_guess(gets.chomp, turns-1, real)
end

start()
