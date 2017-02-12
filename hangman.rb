###############################################################################
### Very basic hangman game inspired by TechHire interview with Mined Minds ###
###############################################################################
######################## Rewritten in Ruby (2017-02-07) #######################
#############################  by John C. Verbosky ############################
###############################################################################
# Features:                                                                   #
# - animations for winning and losing                                         #
# - ability to start a new game or exit after win/loss                        #
# - cumulative score                                                          #
###############################################################################
# Note:                                                                       #
# - runs correctly on Windows x86, Mac and Linux                              #
# - does not work correctly on Windows with 64-bit Ruby                       #
#   - run with 32-bit Ruby on 64-bit Windows (see notes)                      #
###############################################################################

# array of mystery words
$words = ["research", "persistence", "dedication", "curiosity", "troubleshoot", "energetic", "organization",
          "communication", "development", "loyalty", "adaptable", "creativity", "improvement", "dependable",
          "teamwork", "collaboration", "optimistic", "focused", "meticulous", "effective", "inspired"]

$word = ""  # initialize string for mystery word
$bucket = []  # array to hold all letters that have been entered to guess
$build_word = []  # array to hold guessed letters that are found in mystery word
$wrong_count = []  # array to hold guessed letters that are not found in mystery word
$games_won = 0  # counter for games won
$games_lost = 0  # counter for games lost

# # Method to display guessed letters
# def letters()
#   puts "  Word:     " + $build_word.join(" ")  # display the correctly guessed letters and placeholders
#   margin(1)
#   puts "  Letters:  " + $bucket.join(" ")  # display all of the guessed letters
#   margin(2)
# end

# Method to initialize $build_word array with an underscore for every letter in $word
def initialize_word()
  if $word == ""
    $word = $words.sample  # select a random word from the words array
    $word.length.times { $build_word.push("_") }
  end
  return $word
end

def current_word()
  current = $build_word.join(" ")
end

def guessed_letters()
  guessed = $bucket.join(" ")
end

def wrong_letters()
  wrong = $wrong_count.join(" ")
end

# Method that acts as primary starting/return point for other methods
def user_input(letter)
  hangman($wrong_count.length)  # display the current progressive hangman "image" based on wrong guesses
  letters()  # display the correctly guessed letters and placeholders
  good_letter(letter)  # pass the user-specified letter to good_letter()
end

# Method that checks the user-specified letter for a few things
def good_letter(letter)
  if $bucket.include? letter  # check to see if letter has already been guessed and reprompt if so
    puts "  You already guessed that one - TRY AGAIN!"
    user_input()
  elsif letter[/[a-zA-Z]+/] and letter.length == 1  # check is a single -letter- has been entered
    $bucket.push(letter)  # if so, add it to the bucket list
    letter_test(letter)  # then pass it to letter_test()
  else  # if multiple letters, non-alpha characters or nothing has been entered
    puts "  Enter a single letter - TRY AGAIN!"  # reprompt user to try again
    user_input()
  end
end

# Method that checks to see if letter is in the mystery word
def letter_test(letter)
  # If it is in the word pass it to find_locations(), if not pass it to wrong_letter()
  $word.include?(letter) ? find_locations(letter) : wrong_letter(letter)
  # $word.include?(letter)  # use for testing
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
  # return locations  # use for testing
end

# Method to populate $build_word with every occurrence of a letter
def add_letter(letter, locations)
  # for each occurrence of a letter, add the letter to the correct location in $build-word
  locations.each { |location| $build_word[location] = letter }
  word_test()  # then run word_test()
end

# Method to compare the current build_word array against the mystery word
def word_test()
  if $build_word.join == $word  # if $build_word equals $word, the user won
    $games_won += 1  # so increase the games_won score by 1
    winner(1)  # and start winner() on frame 1 (animation count 1)
  else  # if they don't match, run user_input() for another letter
    user_input()
  end
end

# Method that receives non-mystery word letter and adds it to the wrong_count array
def wrong_letter(letter)
  if $wrong_count.length < 9  # if the wrong_count list has less than 9 letters
    $wrong_count.push(letter)  # then add the letter to the list
    user_input()  # run user_input() again
  else  # if this is the tenth wrong letter, it's game over
    $games_lost += 1  # so increase the games_lost score by 1
    loser()  # and start loser() on frame 1 (animation count 5)
  end
end

# Method to progressively draw the hangman stages as incorrect letters are guessed
def hangman(count)
  if count == 0
    image = "wrong_0"
  elsif count == 1
    image = "wrong_1"
  elsif count == 2
    image = "wrong_2"
  elsif count == 3
    image = "wrong_3"
  elsif count == 4
    image = "wrong_4"
  elsif count == 5
    image = "wrong_5"
  elsif count == 6
    image = "wrong_6"
  elsif count == 7
    image = "wrong_7"
  elsif count == 8
    image = "wrong_8"
  else
    image = "wrong_9"
  end
end

# Method to display winner() animation
def winner(ani_count)
  image = "winner"
end

# Method to display loser() animation
def loser(ani_count)
  image = "loser"
end