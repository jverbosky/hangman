###########################################################################
# Very basic hangman game inspired by TechHire interview with Mined Minds #
###########################################################################
##################### Re-imagined in Ruby (2017-02-07) ####################
###########################################################################

# Initial attempt will be 1-to-1 conversion
# Will refactor using TDD after conversion - particularly method calls

# array of mystery words
words = ["fish", "dogs", "cats", "mice", "bats", "pigs", "bird", "goat", "rock", "frog", "cows", "bull"]
$word = words.sample  # select a random word from the words array
$bucket = []  # array to hold all letters that have been entered to guess
$build_word = []  # array to hold guessed letters that are found in mystery word
$wrong_count = []  # array to hold guessed letters that are not found in mystery word

# Method to progressively draw the hangman stages as incorrect letters are guessed
def hangman(count)
  if count == 0
    12.times { puts "\n" }
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

# Method that checks to see if letter is in the mystery word
def letter_test(letter)
  if $word.include? letter  # If it is in the word, pass it to the location_test method
    puts "Yes, letter is in word."
    #location_test(letter)
  else  # If it is not in the word, pass it to the wrong_letter method
    puts "No, letter is not in word."
    #wrong_letter(letter)
  end
end

# Method that checks the user-specified letter for a few things
def good_letter(letter)
  system("cls")  # start by clearing the screen
  if $bucket.include? letter  # check to see if letter has already been guessed and reprompt if so
    puts "  You already guessed that one - TRY AGAIN!"
    user_input()
  elsif letter[/[a-zA-Z]+/] and letter.length == 1  # check is a single -letter- has been entered
    $bucket.push(letter)  # if so, add it to the bucket list
    puts "Word: #{$word}"
    puts "Bucket: #{$bucket}"
    letter_test(letter)  # then pass it to the letter_test method
  else  # if multiple letters, non-alpha characters or nothing has been entered
    puts "  Enter a single letter - TRY AGAIN!"  # reprompt user to try again
    user_input()
  end
end

# Method that acts as primary starting/return point for other methods
def user_input()
  hangman($wrong_count.length)  # display the current progressive hangman "image" based on wrong guesses
  puts "\n  Word:     " + $build_word.join(" ")  # display the correctly guessed letters and placeholders
  puts "\n  Letters:  " + $bucket.join(" ")  # display all of the guessed letters
  print "\n  Please enter a letter: "  # prompt the user for a letter
  letter = gets.chomp  # assign the letter to a variable
  good_letter(letter)  # pass the user-specified letter to the good_letter method
end

# Method to start the game
def start_game(word)
  system("cls")  # Clear the screen
  $word.length.times { $build_word.push("_") }  # Populate the build_word list with an underscore for each letter in the mystery word
  user_input()  #Run the user_input method to display the main "UI"
end

start_game($word)
