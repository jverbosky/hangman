# app.rb
# just use app.rb file to get/post, don't put a lot of logic here

require 'sinatra'
require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'hangman.rb'  # load Ruby script (same directory)

get '/' do  # route to load the ISBN Validator page
  @start = start_game()  # necessary to start the game, won't run if method called by itself
  @wrong = wrong_count()  # load the current count of incorrect guesses for hangman()
  @image = hangman(@wrong)  # use to load correct image
  @current = current_word()  # placeholder underscores and correct letters as guessed
  @guessed = guessed_letters()  # list of letters that have been guessed
  @word = mystery_word()  # testing
  @bad_letters = wrong_letters()  # testing
  @over = game_over?()  # use to determine if game is over
  @won = game_won?()  # use to determine if game has been won or lost
  erb :start  # load play.erb file (mainly a placeholder, populated via layout.erb)
end

post '/new' do
  @start = start_game()  # necessary to start the game, won't run if method called by itself
  @wrong = wrong_count()  # load the current count of incorrect guesses for hangman()
  @image = hangman(@wrong)  # use to load correct image
  @current = current_word()  # placeholder underscores and correct letters as guessed
  @guessed = guessed_letters()  # list of letters that have been guessed
  @word = mystery_word()  # testing
  @bad_letters = wrong_letters()  # testing
  @over = game_over?()  # use to determine if game is over
  @won = game_won?()  # use to determine if game has been won or lost
  erb :start  # load play.erb file (mainly a placeholder, populated via layout.erb)
end

post '/guess' do  # route that accesses input from form's post > action (line 24 of layout.erb)
  @letter = params[:letter]  # params used to access input from post > action (name="letter")
  @test = good_letter(@letter)  # necessary to pass guessed letter to good_letter(), won't run if called by itself
  @wrong = wrong_count()  # load the current count of incorrect guesses for hangman()
  @image = hangman(@wrong)  # use to load correct image
  @current = current_word()  # placeholder underscores and correct letters as guessed
  @guessed = guessed_letters()  # list of letters that have been guessed
  @feedback = feedback()  # optional feedback on correct/incorrect letter - currently commented out
  @word = mystery_word()  # testing
  @bad_letters = wrong_letters()  # testing
  #@new = params[:new]
  @over = game_over?()  # use to determine if game is over
  @won = game_won?()  # use to determine if game has been won or lost
  if @over  # if the game is over, check to see
    if @won  # if the player won, then load winner.erb
      erb :winner
    else  # if the player lost, then load loser.erb
      erb :loser
    end
  else  # otherwise if the game is in progress, then load play.erb
    erb :play
  end
end

# post '/onemore' do
#   start_game()
#   erb :start
# end