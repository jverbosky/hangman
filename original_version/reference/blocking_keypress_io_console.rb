# Blocks until key is pressed

require "io/console"
key = STDIN.getch

# works with alphanumeric keys, but not special keys (Esc, arrows, etc.)
if key != nil  # check to see if a key was pressed during winner/loser animation
  if key == "n"  # if the user presses any key except Esc (27)
    puts "Start new game..."
  elsif key == "q"  # if the user presses the Esc key (27)
    puts "Exiting game..."  # and exit the game
  end
end

