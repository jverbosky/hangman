# Per http://stackoverflow.com/questions/946738/detect-key-press-non-blocking-w-o-getc-gets-in-ruby

@use_stty = begin  # check if Win32API is accessible or not
  require 'Win32API'
  false
rescue LoadError  # use Unix way
  true
end

# Return the ASCII code last key pressed, or nil if none
def getkey()
  if @use_stty
    system('stty raw -echo') # raw mode, no echo
    character = (STDIN.read_nonblock(1).ord rescue nil)
    system('stty -raw echo') # reset terminal mode
    return character
  else
    return Win32API.new('crtdll', '_kbhit', [ ], 'I').Call.zero? ? nil : Win32API.new('crtdll', '_getch', [ ], 'L').Call
  end
end

loop do
  k = getkey()
  puts "Key pressed: #{k.inspect}"
  sleep 1
end