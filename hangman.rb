###########################################################################
# Very basic hangman game inspired by TechHire interview with Mined Minds #
###########################################################################
##################### Re-imagined in Ruby (2017-02-07) ####################
###########################################################################

# Initial attempt will be 1-to-1 conversion
# Will refactor using TDD after conversion - particularly method calls

# array of mystery words
words = ["research", "persistence", "dedication", "curiosity", "troubleshoot", "energetic", "organization", "communication", "development", "loyalty"]
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

# Method that receives non-mystery word letter and adds it to the wrong_count array
def wrong_letter(letter)
  if $wrong_count.length < 9  # if the wrong_count list has less than 9 letters
    $wrong_count.push(letter)  # then add the letter to the list
    # puts "Contents of wrong_count array: #{$wrong_count}"  # testing comment
    user_input()  # run user_input() again
  else  # if this is the tenth wrong letter, it's game over
    2.times { puts "\n" }
    puts "        ______"
    2.times { puts "       |      |" }
    puts "       |      O"
    puts "       |     /|\\"
    puts "       |     / \\"
    puts "       |"
    puts "   ____|____"
    puts "\n  SORRY - GAME OVER!"
    puts "\n  Word:     " + $build_word.join(" ")  # list mystery word and letters so user can see progress
    puts "\n  Letters:  " + $bucket.join(" ")
    4.times { puts "\n" }
  end
end

# Method to run when the user correctly guesses the word
def winner()
  puts "\n\n     ---CONGRATULATIONS---"
  puts "\n\n      YOU WON THE GAME!!!"
  puts "\n\n  \\O/   \\O_  \\O/  _O/   \\O/ "
  puts "   |   _/     |     \\_   |  "
  puts "  / \\   |    / \\    |   / \\ "
  puts "\n\n  Word:     " + $build_word.join(" ")  # list mystery word and letters so user can see progress
  puts "\n  Letters:  " + $bucket.join(" ")
  4.times { puts "\n" }
end

# Method to compare the current build_word array against the mystery word
def word_test()
  if $build_word.join == $word  # if $build_word equals $word, run winner()
    # puts "Winner!"  # testing comment
    winner()
  else  # if they don't match, run user_input() for another letter
    user_input()
  end
end

# Method to populate $build_word with every occurrence of a letter
def add_letter(letter, locations)
  locations.each do |location|  # for each occurrence of a letter
    $build_word[location] = letter  # add the letter to the correct location in $build-word
  end
  word_test()  # then run word_test()
end

# Method that finds all locations of a letter in the word
def find_locations(letter)
  locations = []  # array for the index (position) of all instances of the letter in the word
  last_index = 0  # dual-purpose variable that holds the index (position) of the letter and the .index offset
  occurrences = $word.count letter  # variable used to control do loop iteration count
  occurrences.times do  # for every occurrence of the letter in the word
    last_index = $word.index(letter, last_index)  # determine the position of the letter in the word
    locations.push(last_index)  # push the position of the letter to the location array
    last_index += 1  # increment last_index by 1 to target the next occurrence of the letter (via .index offset)
  end
  add_letter(letter, locations)  # pass the user-specified letter and array of locations to add_letter()
end

# Method that checks to see if letter is in the mystery word
def letter_test(letter)
  if $word.include? letter  # If it is in the word, pass it to location_test()
    # puts "Yes, letter is in word."  # testing comment
    find_locations(letter)
  else  # If it is not in the word, pass it to wrong_letter()
    # puts "No, letter is not in word."  # testing comment
    wrong_letter(letter)
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
    # puts "Word: #{$word}"  # testing comment
    # puts "Bucket: #{$bucket}"  # testing comment
    letter_test(letter)  # then pass it to letter_test()
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
  good_letter(letter)  # pass the user-specified letter to good_letter()
end

# Method to start the game
def start_game(word)
  system("cls")  # Clear the screen
  $word.length.times { $build_word.push("_") }  # Populate the build_word list with an underscore for each letter in the mystery word
  user_input()  #Run user_input() to display the main "UI"
end

start_game($word)