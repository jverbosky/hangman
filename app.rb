# app.rb
# just use app.rb file to get/post, don't put a lot of logic here

require 'sinatra'
require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'hangman.rb'  # load Ruby script (same directory)

get '/' do  # route to load the ISBN Validator page
  @title = "Hangman"  # instance variable for page name and header
  @word = initialize_word()  # just used for testing
  @current = current_word()
  @guessed = guessed_letters()
  @bad_letters = wrong_letters()
  @wrong = wrong_count()
  @image = hangman(@wrong)
  erb :start  # load play.erb file (mainly a placeholder, populated via layout.erb)
end

post '/guess' do  # route that accesses input from form's post > action (line 24 of layout.erb)
  @title = "Hangman"  # instance variable for page name and header
  @word = initialize_word()  # just used for testing
  @letter = params[:letter]  # params used to access input from post > action (name="letter")
  @status = good_letter(@letter)
  @current = current_word()
  @guessed = guessed_letters()
  @bad_letters = wrong_letters()
  @wrong = wrong_count()
  @image = hangman(@wrong)
  @feedback = feedback()
  # @status = is_too_small?(@num)  # ISBN validation status after evaluation via isbn_check.rb
  # @result = @status ? "Congratulations!" : "Sorry..."  # conditional text
  # @valid = @status ? "a valid ISBN number." : "not a valid ISBN number."  # more conditional text
  
  # Need to add logic for winning - currently researching how to access global variables from program

  if @wrong < 10
    erb :play
  else
    erb :loser
  end
end

# get '/loser' do
#   erb :loser, :layout => :loser_layout
# end

# get '/winner' do
#   erb :loser, :layout => :loser_layout
# end