require 'Win32API'

# def getkey()
#   return Win32API.new('crtdll', '_kbhit', [ ], 'I').Call.zero? ? nil : Win32API.new('crtdll', '_getch', [ ], 'L').Call
# end

# key = getkey()  # variable for last key pressed
# clear_screen()  # Clear the screen

# if key != nil  # check to see if a key was pressed during winner/loser animation
#   if key != 27  # if the user presses any key except Esc (27)
#     puts "Start new game..."
#   elsif key == 27  # if the user presses the Esc key (27)
#     puts "Exiting game..."  # and exit the game
#   end
# end

if Win32API.new('crtdll', '_kbhit', [ ], 'I').Call.zero? == true
	return nil
else
	return Win32API.new('crtdll', '_getch', [ ], 'L').Call
end