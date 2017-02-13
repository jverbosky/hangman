###############################################################################
# Tests for hangman_testing.rb                                                 #
###############################################################################

###############################################################################
# Note - use hangman_testing.rb for testing (already commented out line 45)   #
###############################################################################
# Before running any tests on hangman.rb, comment out the appropriate lines:  #
# - test_1  > line 45                                                         #
# - test_15 > line 122 (uncomment line 123), comment out test 13              #
###############################################################################

require "minitest/autorun"
# require_relative "hangman.rb"
require_relative "hangman_testing.rb"

class TestHangmanRefactored < Minitest::Test

  # Verify that the $build_word array is populated correctly for the specified word
  # Note - need to comment out line 45 (random word selection) so test will use specified $word
  def test_1_initialize_build_word_array_with_placeholder_underscores
    $build_word = []
    $word = "testing"
    results = start_game()
    assert_equal(["_", "_", "_", "_", "_", "_", "_"], $build_word)
  end

  # Verify that current_word() outputs string correctly
  def test_2_convert_build_word_array_to_string
    $build_word = ["t", "_", "_", "t", "_", "n", "_"]
    results = current_word()
    assert_equal("t _ _ t _ n _", results)
  end

  # Verify that feedback() outputs string correctly
  def test_3_return_value_of_prompt
    $prompt = "You already guessed that one - TRY AGAIN!"
    results = feedback()
    assert_equal("You already guessed that one - TRY AGAIN!", results)
  end

  # Verify that game_over?() returns flag value correctly when true
  def test_4_verify_that_game_is_not_over
    $game_over = true
    results = game_over?()
    assert_equal(true, results)
  end

  # Verify that game_over?() returns flag value correctly when true
  def test_5_verify_that_game_is_over
    $game_over = false
    results = game_over?()
    assert_equal(false, results)
  end

  # Verify that games_won() returns the cumulative number of games won
  def test_6_return_cumulative_number_of_games_won
    $games_won = 0
    $games_won += 1
    results = games_won()
    assert_equal(1, results)
  end

  # Verify that games_won() returns the cumulative number of games lost
  def test_7_return_cumulative_number_of_games_lost
    $games_lost = 0
    $games_lost += 1
    results = games_lost()
    assert_equal(1, results)
  end

  # Verify that the image count value is 11 if the game_won flag is set to true
  def test_8_image_count_is_11_if_game_is_over
    $game_won = true
    $wrong_count = ["z", "x", "w", "q", "d", "f", "k", "m"]
    results = wrong_count()
    assert_equal(11, results)
  end

  # Verify that the correct image path is returned for the current image count
  # Note - had to move this test above test 14 due to conflicting global variable values
  def test_9_image_path_corresponds_to_image_count
    $wrong_count = ["z", "x", "w", "q", "d", "f", "k", "m"]
    count = $wrong_count.length
    results = hangman(count)
    assert_equal("/images/wrong_8.png", results)
  end

  # Verify that if a letter already in bucket array is entered, that it is not added to the bucket array again
  def test_10_verify_number_not_added_to_bucket_array_if_already_present
    $bucket = ["b"]
    letter = "b"
    results = good_letter(letter)
    assert_equal(["b"], $bucket)
  end

  # Verify that if a single letter is entered, that it is added to the bucket array
  def test_11_verify_letter_is_added_to_bucket_array_if_good
    $bucket = []
    letter = "a"
    results = good_letter(letter)
    assert_equal(["a"], $bucket)
  end

  # Verify that if a number is entered, that it is not added to the bucket array
  def test_12_verify_number_not_added_to_bucket_array
    $bucket = []
    letter = "7"
    results = good_letter(letter)
    assert_equal([], $bucket)
  end

  # Verify that letter is in the current word
  # Note - need to comment out this test if running test 15
  def test_13_return_good_job_prompt_if_letter_in_word
    $word = "test"
    letter = "e"
    results = letter_test(letter)
    assert_equal("Good job - that letter was in the word. Please guess again!", results)
  end

  # Verify that letter is not in the current word
  def test_14_return_sorry_prompt_if_letter_not_in_word
    $word = "test"
    letter = "y"
    results = letter_test(letter)
    assert_equal("Sorry - that letter was not in the word. Please try again!", results)
  end

  # # Verify the positions of a letter in a word
  # # Note - need to comment out original method call (line 122) and uncomment the subsequent line
  # #   for test to work, otherwise comment out this test
  # # Note - need to comment out test 13 when running this test or test 13 will fail due to
  # #   commented-out line 122
  # def test_15_return_positions_of_letter_in_word
  #   $word = "repeated"
  #   letter = "e"
  #   results = find_locations(letter)
  #   assert_equal([1, 3, 6], results)
  # end

  # Verify that letter gets placed into correct locations in $build_word array
  def test_16_replace_appropriate_placeholders_with_letter
    $build_word = ["_", "_", "_", "_", "_", "_", "_", "_"]
    letter = "e"
    locations = [1, 3, 6]
    results = add_letter(letter, locations)
    assert_equal(["_", "e", "_", "e", "_", "_", "e", "_"], $build_word)
  end

  # Verify that $games_won is incremented when word is correctly guessed
  def test_17_games_won_count_incremented_upon_win
    $games_won = 0
    $word = "testing"
    $build_word = ["t", "e", "s", "t", "i", "n", "g"]
    results = word_test()
    assert_equal(1, $games_won)
  end

  # Verify that an incorrectly guessed letter is added to the $wrong_count array
  def test_18_add_wrong_letter_to_wrong_count_array
    $wrong_count = ["z", "x", "w", "q", "d", "f", "k", "m"]
    letter = "u"
    results = wrong_letter(letter)
    assert_equal(["z", "x", "w", "q", "d", "f", "k", "m", "u"], $wrong_count)
  end

  # Verify that the image count value corresponds to the number if letters in the wrong_count array
  def test_19_image_count_corresponds_to_wrong_count_array_length_if_game_in_progress
    $game_won = false
    $wrong_count = ["z", "x", "w", "q", "d", "f", "k", "m"]
    results = wrong_count()
    assert_equal(8, results)
  end

end