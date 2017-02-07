##################
#Very basic hangman game inspired by TechHire interview with Mined Minds
##################
#John C. Verbosky
#jverbosk@gmail.com
##################
#Change log
##################
#2016/12/08
# V1.0
# - Works for words without repeated letters
##################
#2016/12/12
# V1.1
# - Updated to work for words with repeated letters
# - Replaced location_test() with with find_location() and add_letter()
# - Updated words list
##################
#Thank you for your consideration!
##################

#Import os to use Windows cls command
# to clear screen after each letter guess
#Import random to use random.choice
# to pull random word from list
import os, random

#List of mystery words
#Will work with non-four letter words, but will not 
# work properly with words that have repeating letters 
words = ["research", "persistence", "dedication", "curiosity", "troubleshoot", "energetic", "organization", "communication", "development", "loyalty"]

#Statement to select random word from the words list
word = random.choice(words)

#List to hold all letters that have been entered to guess
bucket = []

#List to hold guessed letters that are found in mystery word
build_word = []

#List to hold guessed letters that are not found in mystery word
wrong_count = []

#Function to start the game
def start_game(word):
	#Clear the screen
	os.system("cls")
	#Populate the build_word list with an underscore
	# for each letter in the mystery word
	for abc in word:
		build_word.append("_")
	#Run the user_input function to display the main "UI"
	user_input()

#Function that acts as primary starting/return point for other functions
def user_input():
	#Display the current progressive hangman "image" based on wrong guesses
	hangman(len(wrong_count))
	print(" ")
	#Display the correctly guessed letters and placeholders
	print("  Word:     " + " ".join(build_word))
	print(" ")
	#Display all of the guessed letters
	print("  Letters:  " + " ".join(bucket))
	print(" ")
	#Prompt for collecting a letter from the user
	letter = input("  Please enter a letter:")
	#Pass the user-specified letter to the good_letter function
	good_letter(letter)

#Function that checks the user-specified letter for a few things
def good_letter(a):
	#Start by clearing the screen
	os.system("cls")
	#Check to see if letter has already been guessed and reprompt if so
	if a in bucket:
		print("  You already guessed that one - TRY AGAIN!")
		user_input()
	#Check is a single -letter- has been entered
	# and if so, add it to the bucket list,
	# then pass it to the letter_test function
	elif a.isalpha() and len(a) == 1:
		bucket.append(a)
		letter_test(a)
	#If multiple letters, non-alpha characters or nothing
	# has been entered, reprompt user to try again
	else:
		print("  Enter a single letter - TRY AGAIN!")
		user_input()

#Function that receives letter from good_letter function
# and checks to see if letter is in the mystery word
def letter_test(b):
	#If it is in the word, pass it to the location_test function
	if b in word:
		find_location(word, b)
	#If it is not in the word, pass it to the wrong_letter function
	else:
		wrong_letter(b)

#Function that receives mystery word and user letter from letter_test 
# function, checks to find all locations of letter in word, and
# writes location index to found list and passes to add_letter function
def find_location(word, letter):
	#List to hold the index (position) for 
	# all instances of the letter in the word
	location = []
	#Assign the index to -1 so it will become 0 when evaluated
	# in the try clause
	#When set at 0, the index() function will miss the letter 
	# if it is the first character in the word
	last_index = -1
	while True:
		try:
			#string.index(letter_to_find, place_to_start_looking)
			#Increment the value of last_index
			# (from -1 to 0 on first pass) and then assign
			# last_index to to the index (position) of the letter
			last_index = word.index(letter, last_index+1)
		except ValueError:
			#If the letter is not found in the word, it will
			# return ValueError and this function should end
			# without writing anything to the location list
			break
		else:
			#Append the index (position) of the letter to 
			# the location list on each pass
			#If the letter occurs multiple times, this list 
			# will have multiple indexes listed
			location.append(last_index)
	add_letter(letter, location)

#Receives letter and location list from find_location function
# and adds letter to the corresponding location(s) in the build_word list
# Finishes by calling the word_test function with the mystery word
def add_letter(letter, location_list):
	#For each instance of a letter, add that letter
	#  to the correct location in the build_word list
	for position in location_list:
		build_word[position] = letter
	#Next run the word_test function
	word_test(word)

#Function to compare the current build_word list against the mystery word
def word_test(word):
	#Use list() to turn the mystery word into a list
	# and if it matches the build_word list, run the winner() function
	if build_word == list(word):
		winner()
	#If they don't match, return to user_input() for another letter
	else:
		user_input()

#Function that receives non-mystery word letter from
# the letter_test function and adds it to the wrong_count list
def wrong_letter(d):
	#If the wrong_count list has less than 9 letters
	#then add the letter to the list
	if len(wrong_count) < 9:
		wrong_count.append(d)
		user_input()
	#If this is the tenth wrong letter, it's game over
	#Continue listing mystery word and letter so user can see progress
	else:
		#Used "for x in range()" so it's faster to adjust margins
		for x in range(2):
			print(" ")
		print("        ______      ")
		print("       |      |     ")
		print("       |      |     ")
		print("       |      O     ")
		print("       |     /|\    ")
		print("       |     / \    ")
		print("       |            ")
		print("   ____|____        ")
		print(" ")
		print("  SORRY - GAME OVER!")
		print(" ")
		print("  Word:     " + " ".join(build_word))
		print(" ")
		print("  Letters:  " + " ".join(bucket))
		for x in range(4):
			print(" ")

#Function that is called from the word_test function when the build_word list
# and the mystery word are matching (i.e. the user correctly guessed the word)
def winner():
	for x in range(2):
		print(" ")
	print("     ---CONGRATULATIONS---")
	for x in range(2):
		print(" ")
	print("      YOU WON THE GAME!!!")
	for x in range(2):
		print(" ")
	print("  \O/   \O_  \O/  _O/   \O/ ")
	print("   |   _/     |     \_   |  ")
	print("  / \   |    / \    |   / \ ")
	for x in range(2):
		print(" ")
	print("  Word:     " + " ".join(build_word))
	print(" ")
	print("  Letters:  " + " ".join(bucket))
	for x in range(4):
		print(" ")

#Function to progressively draw the hangman stages
# as incorrect letters are guessed
def hangman(count):
	if count == 0:
		for x in range(12):
			print(" ")
	elif count == 1:
		for x in range(9):
			print(" ")
		print("   _________       ")
		for x in range(2):
			print(" ")
	elif count == 2:
		for x in range(3):
			print(" ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("   ____|____       ")
		for x in range(2):
			print(" ")
	elif count == 3:
		for x in range(2):
			print(" ")
		print("        ______     ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("   ____|____       ")
		for x in range(2):
			print(" ")
	elif count == 4:
		for x in range(2):
			print(" ")
		print("        ______     ")
		print("       |      |    ")
		print("       |      |    ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("   ____|____       ")
		for x in range(2):
			print(" ")
	elif count == 5:
		for x in range(2):
			print(" ")
		print("        ______     ")
		print("       |      |    ")
		print("       |      |    ")
		print("       |      O    ")
		print("       |           ")
		print("       |           ")
		print("       |           ")
		print("   ____|____       ")
		for x in range(2):
			print(" ")
	elif count == 6:
		for x in range(2):
			print(" ")
		print("        ______     ")
		print("       |      |    ")
		print("       |      |    ")
		print("       |      O    ")
		print("       |      |    ")
		print("       |           ")
		print("       |           ")
		print("   ____|____       ")
		for x in range(2):
			print(" ")
	elif count == 7:
		for x in range(2):
			print(" ")
		print("        ______     ")
		print("       |      |    ")
		print("       |      |    ")
		print("       |      O    ")
		print("       |     /|    ")
		print("       |           ")
		print("       |           ")
		print("   ____|____       ")
		for x in range(2):
			print(" ")
	elif count == 8:
		for x in range(2):
			print(" ")
		print("        ______     ")
		print("       |      |    ")
		print("       |      |    ")
		print("       |      O    ")
		print("       |     /|\   ")
		print("       |           ")
		print("       |           ")
		print("   ____|____       ")
		for x in range(2):
			print(" ")
	elif count == 9:
		for x in range(2):
			print(" ")
		print("        ______     ")
		print("       |      |    ")
		print("       |      |    ")
		print("       |      O    ")
		print("       |     /|\   ")
		print("       |     /     ")
		print("       |           ")
		print("   ____|____       ")
		for x in range(2):
			print(" ")

#Call start_game(word) to begin the game - have fun! ^_^ /
start_game(word)
