##################
#Very basic hangman game inspired by TechHire interview with Mined Minds
##################
#John C. Verbosky
#jverbosk@gmail.com
##################
####12/08/2016####
##################

#Import os to use Windows cls command
# to clear screen after each letter guess
#Import random to use random.choice
# to pull random word from list
import os, random

#List of mystery words
#Will work with non-four letter words, but will not 
# work properly with words that have repeating letters 
words = ["fish", "dogs", "cats", "mice", "bats", "pigs", "bird", "goat", "rock", "frog", "cows", "bull"]

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
		location_test(b)
	#If it is not in the word, pass it to the wrong_letter function
	else:
		wrong_letter(b)

#Function that receives mystery word letter from
# the letter_test function and checks to see where it occurs
def location_test(c):
	#Look through all of the letters in the word
	for i in word:
		#When a letter in the word matches the user's letter
		if i == c:
			#Assign the numerical position of the letter
			# in the word to the letter_index variable
			letter_index = word.index(i)
			#Then replace the appropriate placeholder
			# underscore in the build_word list with the
			# user's letter 
			#Ex: If the mystery word is "fish"
			# build_word[2] = "s"
			build_word[letter_index] = i
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
