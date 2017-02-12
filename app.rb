# app.rb
# just use app.rb file to get/post, don't put a lot of logic here

require 'sinatra'
require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'hangman.rb'  # load Ruby script (same directory)

get '/' do  # route to load the ISBN Validator page
  @title = "Hangman"  # instance variable for page name and header
  @word = initialize_word()
  @current = current_word()
  @guessed = guessed_letters()
  @wrong = 0
  erb :start  # load play.erb file (mainly a placeholder, populated via layout.erb)
end

# post '/guess' do  # route that accesses input from form's post > action (line 24 of layout.erb)
#   @title = "Hangman"  # instance variable for page name and header
#   @num = params[:letter]  # params used to access input from post > action (name="letter")
#   @status = is_too_small?(@num)  # ISBN validation status after evaluation via isbn_check.rb
#   @result = @status ? "Congratulations!" : "Sorry..."  # conditional text
#   @valid = @status ? "a valid ISBN number." : "not a valid ISBN number."  # more conditional text
#   erb :isbn_status  # load isbn_status.erb file with ISBN check results output
# end
