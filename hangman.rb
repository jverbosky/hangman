###########################################################################
# Very basic hangman game inspired by TechHire interview with Mined Minds #
###########################################################################
##################### Re-imagined in Ruby (2017-02-07) ####################
###########################################################################

# Initial attempt will be 1-to-1 conversion
# Will refactor using TDD after conversion

# Array of mystery words
words = ["fish", "dogs", "cats", "mice", "bats", "pigs", "bird", "goat", "rock", "frog", "cows", "bull"]
$word = words.sample  # Select a random word from the words array
$bucket = []  # List to hold all letters that have been entered to guess
$build_word = []  # List to hold guessed letters that are found in mystery word
$wrong_count = []  # List to hold guessed letters that are not found in mystery word

# Method to progressively draw the hangman stages as incorrect letters are guessed
def hangman(count)
  if count == 0
    12.times { puts "\n" }
    # for x in range(12):
    #   print(" ")
  elsif count == 1
    9.times { puts "\n" }
    puts "   _________"
    2.times { puts "\n" }
  elsif count == 2
    3.times { puts "\n" }
    6.times { puts "       |" }
    puts "   ____|____"
    2.times { puts "\n" }
  elsif count == 3
    2.times { puts "\n" }
    puts "        ______"
    6.times { puts "       |" }
    puts "   ____|____"
    2.times { puts "\n" }
  elsif count == 4
    2.times { puts "\n" }
    puts "        ______"
    2.times { puts "       |      |" }
    4.times { puts "       |" }
    puts "   ____|____"
    2.times { puts "\n" }
  elsif count == 5
    2.times { puts "\n" }
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    3.times { puts "       |" }
    puts "   ____|____"
    2.times { puts "\n" }
  elsif count == 6
    2.times { puts "\n" }
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    puts "       |      |"
    2.times { puts "       |" }
    puts "   ____|____"
    2.times { puts "\n" }
  elsif count == 7
    2.times { puts "\n" }
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    puts "       |     /|"
    2.times { puts "       |" }
    puts "   ____|____"
    2.times { puts "\n" }
  elsif count == 8
    2.times { puts "\n" }
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    puts "       |     /|\\"
    2.times { puts "       |" }
    puts "   ____|____"
    2.times { puts "\n" }
  else
    2.times { puts "\n" }
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    puts "       |     /|\\"
    puts "       |     /"
    puts "       |"
    puts "   ____|____"
    2.times { puts "\n" }
  end
end

# Method that acts as primary starting/return point for other functions
def user_input()
  #Display the current progressive hangman "image" based on wrong guesses
  hangman($wrong_count.length)
  puts "\n  Word:     " + $build_word.join(" ")  # Display the correctly guessed letters and placeholders
  puts "\n  Letters:  " + $bucket.join(" ")  # Display all of the guessed letters
  print "\n  Please enter a letter: "  # Prompt the user for a letter
  letter = gets.chomp  # Assign the letter to a variable
  puts letter
  #Pass the user-specified letter to the good_letter function
  #good_letter(letter)
end

# Method to start the game
def start_game(word)
  #system("cls")  # Clear the screen
  # Populate the build_word list with an underscore for each letter in the mystery word
  $word.length.times { $build_word.push("_") }
  #Run the user_input function to display the main "UI"
  user_input()
end

start_game($word)
